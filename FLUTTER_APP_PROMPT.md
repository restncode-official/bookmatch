# BookMatch Flutter Mobile App — Full Development Prompt

> Use this document as a single, self-contained specification to build the BookMatch Flutter app from scratch in one continuous flow. Every section is ordered to match the natural build sequence: project scaffold → data layer → state management → screens → polish.

---

## 1. Project Context

BookMatch is a university library management system. The Flutter app is the **student/faculty-facing mobile client**. Staff management (approvals, inventory) remains in the web admin panel. The app must support:

- Browsing and searching the book catalog (public, no login required)
- Account registration and login (Sanctum token auth)
- Borrowing books and viewing borrow history
- Bookmarking books
- Rating books (with awareness that ratings are pending until staff-approved)
- Personalized recommendations (collaborative / genre-based / trending)
- Profile management (name, email, password)

---

## 2. Tech Stack Decisions

| Concern | Choice | Reason |
|---|---|---|
| State management | **Riverpod 2** (code-gen) | Compile-safe providers, testable, scales well |
| Navigation | **GoRouter** | Declarative, deep-link ready, integrates with Riverpod auth state |
| HTTP | **Dio** + `dio_cache_interceptor` | Interceptors for auth tokens; cache for book lists |
| Local storage | **flutter_secure_storage** (token) + **shared_preferences** (prefs) | Separate concerns |
| Image loading | **cached_network_image** | Disk cache for cover images |
| Forms | **flutter_form_builder** + **form_builder_validators** | Reduce boilerplate |
| Code generation | **build_runner**, **freezed**, **json_serializable** | Immutable models, sealed unions |
| Linting | **flutter_lints** + custom analysis_options | Enforced from day one |
| Testing | **flutter_test** + **mocktail** | Unit + widget tests |

Minimum SDK: `flutter: ">=3.19.0"`, Dart `>=3.3.0`, `minSdkVersion 21`, `ios deployment_target 14.0`.

---

## 3. Environment & Configuration

Create `lib/core/config/env.dart`:

```dart
class Env {
  static const baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://10.0.2.2/api', // Android emulator → localhost
  );
}
```

Pass at build time:
```bash
flutter run --dart-define=BASE_URL=https://api.yourdomain.com
```

---

## 4. Project Structure

```
lib/
├── core/
│   ├── config/          # Env, theme, constants
│   ├── http/            # Dio client, interceptors, error handling
│   ├── router/          # GoRouter definition
│   └── utils/           # Date helpers, formatters
├── data/
│   ├── models/          # Freezed models (one file per domain entity)
│   ├── repositories/    # One repository per resource (books, borrows, …)
│   └── datasources/     # Remote datasources (thin wrappers over Dio)
├── features/
│   ├── auth/            # Login, register, profile screens + providers
│   ├── books/           # Catalog, detail, search
│   ├── borrows/         # History, borrow action
│   ├── bookmarks/       # Bookmarks list
│   ├── ratings/         # Rate dialog, rating list
│   ├── recommendations/ # Recommendations screen
│   └── dashboard/       # Home dashboard
└── main.dart
```

---

## 5. API Reference

**Base URL**: configured via `Env.baseUrl`  
**Auth header**: `Authorization: Bearer {token}` (add via Dio interceptor)  
**Content-Type**: `application/json`

### 5.1 Authentication

#### Register
```
POST /auth/register
Body: { name, email, password, password_confirmation, role?, student_id? }
201: { data: User, token: string }
422: { message, errors: { field: [string] } }
```

#### Login
```
POST /auth/login
Body: { email, password }
200: { data: User, token: string }
422: { message }
429: rate limited
```

#### Get Current User
```
GET /auth/user
Auth: required
200: { data: User }
```

#### Logout
```
POST /auth/logout
Auth: required
200: { message: "Logged out." }
```

---

### 5.2 Profile

```
GET  /profile              → { data: User }
PATCH /profile             → Body: { name, email }  → { data: User }
PUT  /profile/password     → Body: { current_password, password, password_confirmation }
                           → { message: "Password updated." }
```

Note: Changing email resets `email_verified_at` to null.

---

### 5.3 Books

```
GET /books
  Query: q (search title/author/isbn), genre (id), rating (min int 1-5),
         sort (newest|title|rating), page
  Auth: not required
  200: { data: [Book], meta: PaginationMeta, links: PaginationLinks }

GET /books/{slug}
  Auth: not required
  200: { data: Book }
```

---

### 5.4 Genres

```
GET /genres
  Auth: not required
  200: { data: [Genre] }
```

---

### 5.5 Ratings

```
GET /books/{slug}/ratings?page=n
  Auth: not required (shows only approved ratings)
  200: { data: [Rating], meta, links }

POST /books/{slug}/ratings
  Auth: required
  Body: { rating (1-5), message? }
  201/200: { data: Rating, message: "Review submitted for approval." }
  Note: one rating per user per book; re-submitting updates and resets approval to null.

DELETE /ratings/{id}
  Auth: required
  200: { message: "Review deleted." }
  403: if not owner
```

---

### 5.6 Bookmarks

```
GET /bookmarks?page=n
  Auth: required
  200: { data: [Bookmark], meta, links }

POST /books/{slug}/bookmark
  Auth: required
  201: { bookmarked: true }   ← bookmarked
  200: { bookmarked: false }  ← removed (toggle)
```

---

### 5.7 Borrows

```
GET /borrows?page=n
  Auth: required
  200: { data: [Borrow], meta, links }

POST /books/{slug}/borrow
  Auth: required
  201: { data: Borrow }
  422: { message: "No copies are currently available." }
  Note: due_date = 14 days from borrow date.
```

---

### 5.8 Dashboard

```
GET /dashboard
  Auth: required
  200:
  {
    stats: { ratings_count, borrows_count, avg_rating_given },
    my_ratings: [Rating],   // latest 5
    my_borrows: [Borrow]    // latest 5
  }
```

---

### 5.9 Recommendations

```
GET /recommendations?type=collaborative|genre_based|trending
  Auth: required
  200: { data: [Recommendation] }  // ordered by score desc
```

---

## 6. Data Models (Freezed)

Generate with `dart run build_runner build --delete-conflicting-outputs`.

### 6.1 User
```dart
@freezed
class User with _$User {
  const factory User({
    required int id,
    required String name,
    required String email,
    required String role,           // "student"|"admin"|"librarian"|"faculty"
    String? studentId,
    String? department,
    String? avatar,
    DateTime? emailVerifiedAt,
    required DateTime createdAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
```

### 6.2 Book
```dart
@freezed
class Book with _$Book {
  const factory Book({
    required int id,
    required String title,
    required String author,
    required String isbn,
    required String slug,
    String? publisher,
    int? publishedYear,
    String? description,
    String? coverImage,
    required int totalCopies,
    required int availableCopies,
    String? locationCode,
    required bool isAvailable,
    required double averageRating,
    required int approvedRatingsCount,
    required Genre genre,
    required DateTime createdAt,
  }) = _Book;

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
}
```

### 6.3 Genre
```dart
@freezed
class Genre with _$Genre {
  const factory Genre({
    required int id,
    required String name,
    required String slug,
    String? description,
    required int booksCount,
  }) = _Genre;

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
}
```

### 6.4 Rating
```dart
@freezed
class Rating with _$Rating {
  const factory Rating({
    required int id,
    required int rating,
    String? message,
    bool? isApproved,           // null = pending, true = approved, false = rejected
    required UserSummary user,
    Book? book,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Rating;

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);
}
```

### 6.5 Borrow
```dart
@freezed
class Borrow with _$Borrow {
  const factory Borrow({
    required int id,
    required String status,       // "active"|"returned"|"overdue"
    required bool isOverdue,
    required DateTime borrowedAt,
    required String dueDate,      // "YYYY-MM-DD"
    DateTime? returnedAt,
    required Book book,
    required DateTime createdAt,
  }) = _Borrow;

  factory Borrow.fromJson(Map<String, dynamic> json) => _$BorrowFromJson(json);
}
```

### 6.6 Bookmark
```dart
@freezed
class Bookmark with _$Bookmark {
  const factory Bookmark({
    required int id,
    required Book book,
    required DateTime createdAt,
  }) = _Bookmark;

  factory Bookmark.fromJson(Map<String, dynamic> json) => _$BookmarkFromJson(json);
}
```

### 6.7 Recommendation
```dart
@freezed
class Recommendation with _$Recommendation {
  const factory Recommendation({
    required int id,
    required double score,
    required String reasonType,   // "collaborative"|"genre_based"|"trending"
    required Book book,
    required DateTime createdAt,
  }) = _Recommendation;

  factory Recommendation.fromJson(Map<String, dynamic> json) =>
      _$RecommendationFromJson(json);
}
```

### 6.8 Pagination
```dart
@freezed
class PaginatedResponse<T> with _$PaginatedResponse<T> {
  const factory PaginatedResponse({
    required List<T> data,
    required PaginationMeta meta,
  }) = _PaginatedResponse<T>;
}

@freezed
class PaginationMeta with _$PaginationMeta {
  const factory PaginationMeta({
    required int currentPage,
    required int lastPage,
    required int perPage,
    required int total,
    int? from,
    int? to,
  }) = _PaginationMeta;

  factory PaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$PaginationMetaFromJson(json);
}
```

---

## 7. HTTP Layer

### 7.1 Dio Client

```dart
// lib/core/http/api_client.dart
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: Env.baseUrl,
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 30),
    headers: {'Accept': 'application/json'},
  ));

  dio.interceptors.addAll([
    AuthInterceptor(ref),
    LogInterceptor(requestBody: true, responseBody: true),
  ]);

  return dio;
});
```

### 7.2 Auth Interceptor

```dart
class AuthInterceptor extends Interceptor {
  final Ref _ref;
  AuthInterceptor(this._ref);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _ref.read(tokenProvider);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // Token expired or invalid — sign the user out
      _ref.read(authNotifierProvider.notifier).logout();
    }
    handler.next(err);
  }
}
```

### 7.3 Error Handling

Create a sealed `ApiException` class:

```dart
sealed class ApiException implements Exception {
  const ApiException();
}

class ValidationException extends ApiException {
  final Map<String, List<String>> errors;
  const ValidationException(this.errors);
  String fieldError(String field) => errors[field]?.first ?? '';
}

class UnauthorizedException extends ApiException {
  const UnauthorizedException();
}

class NotFoundException extends ApiException {
  const NotFoundException();
}

class ServerException extends ApiException {
  final String message;
  const ServerException(this.message);
}

class NetworkException extends ApiException {
  const NetworkException();
}
```

Write a `handleDioError(DioException e)` function that maps HTTP status codes to these sealed types. Repositories should catch `DioException` and rethrow as `ApiException`.

---

## 8. Repositories

Each repository is exposed as a Riverpod provider. All methods are `async` and return typed results. Throw `ApiException` subtypes on failure.

### 8.1 AuthRepository
```
Future<({User user, String token})> register({...})
Future<({User user, String token})> login(String email, String password)
Future<User> getUser()
Future<void> logout()
```

### 8.2 BookRepository
```
Future<PaginatedResponse<Book>> listBooks({String? q, int? genre, int? rating, String sort = 'newest', int page = 1})
Future<Book> getBook(String slug)
```

### 8.3 GenreRepository
```
Future<List<Genre>> listGenres()
```

### 8.4 RatingRepository
```
Future<PaginatedResponse<Rating>> listRatings(String slug, {int page = 1})
Future<Rating> upsertRating(String slug, {required int rating, String? message})
Future<void> deleteRating(int id)
```

### 8.5 BookmarkRepository
```
Future<PaginatedResponse<Bookmark>> listBookmarks({int page = 1})
Future<bool> toggleBookmark(String slug)   // returns new bookmarked state
```

### 8.6 BorrowRepository
```
Future<PaginatedResponse<Borrow>> listBorrows({int page = 1})
Future<Borrow> borrowBook(String slug)
```

### 8.7 DashboardRepository
```
Future<DashboardData> getDashboard()
// DashboardData: { stats, myRatings, myBorrows }
```

### 8.8 RecommendationRepository
```
Future<List<Recommendation>> getRecommendations({String type = 'collaborative'})
```

### 8.9 ProfileRepository
```
Future<User> getProfile()
Future<User> updateProfile({required String name, required String email})
Future<void> updatePassword({required String currentPassword, required String password, required String passwordConfirmation})
```

---

## 9. Auth State Management

### Token Provider
```dart
// Persisted in flutter_secure_storage
final tokenProvider = StateNotifierProvider<TokenNotifier, String?>(
  (ref) => TokenNotifier(),
);
```

### Auth State
```dart
@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(User user) = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
}
```

### AuthNotifier
```dart
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this._authRepo, this._tokenNotifier) : super(const AuthState.initial()) {
    _init();
  }

  Future<void> _init() async {
    // Check stored token, fetch user, set state
  }

  Future<void> login(String email, String password) async { ... }
  Future<void> register({...}) async { ... }
  Future<void> logout() async { ... }
}
```

---

## 10. Navigation (GoRouter)

```dart
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    initialLocation: '/catalog',
    redirect: (context, state) {
      final isAuth = authState is _Authenticated;
      final protectedRoutes = ['/dashboard', '/borrows', '/bookmarks', '/profile', '/recommendations'];
      final goingToProtected = protectedRoutes.any((r) => state.matchedLocation.startsWith(r));

      if (!isAuth && goingToProtected) return '/login';
      if (isAuth && (state.matchedLocation == '/login' || state.matchedLocation == '/register')) {
        return '/dashboard';
      }
      return null;
    },
    routes: [
      // Public
      GoRoute(path: '/catalog', builder: (_, __) => const CatalogScreen()),
      GoRoute(path: '/catalog/:slug', builder: (_, state) => BookDetailScreen(slug: state.pathParameters['slug']!)),
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/register', builder: (_, __) => const RegisterScreen()),

      // Authenticated (ShellRoute with bottom nav)
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(path: '/dashboard', builder: (_, __) => const DashboardScreen()),
          GoRoute(path: '/borrows', builder: (_, __) => const BorrowsScreen()),
          GoRoute(path: '/bookmarks', builder: (_, __) => const BookmarksScreen()),
          GoRoute(path: '/recommendations', builder: (_, __) => const RecommendationsScreen()),
          GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
          GoRoute(path: '/profile/password', builder: (_, __) => const ChangePasswordScreen()),
        ],
      ),
    ],
  );
});
```

---

## 11. Screens — Build Order & Spec

Build in this order to maximise reuse of components already built.

### Screen 1 — Catalog (CatalogScreen)

**Route**: `/catalog`  
**Auth**: Not required  

- AppBar with search icon → opens inline search bar
- Filter row (horizontal chips): genre filter, min-rating filter, sort picker
- `GridView` (2-column) of `BookCard` widgets, infinite scroll (load next page on scroll near bottom)
- `BookCard` shows: cover image (cached), title, author, star rating, availability badge
- Pull-to-refresh
- Empty state: "No books found" with reset filters CTA

**Providers needed**:
```dart
final catalogProvider = StateNotifierProvider<CatalogNotifier, CatalogState>((ref) { ... });
final genresProvider = FutureProvider<List<Genre>>((ref) { ... });
```

---

### Screen 2 — Book Detail (BookDetailScreen)

**Route**: `/catalog/:slug`  
**Auth**: Not required to view; required to borrow/bookmark/rate  

Layout (SliverAppBar + CustomScrollView):
- Hero cover image in SliverAppBar
- Title, author, genre chip, publisher, year
- Availability badge + location code
- Star rating widget (read-only average) + `approvedRatingsCount`
- Description (expandable with "Show more")
- Action buttons row:
  - **Borrow** (disabled if `!isAvailable` or already borrowed actively)
  - **Bookmark** (toggle icon button, filled/outlined, optimistic update)
- Ratings section: horizontal list of approved ratings, "Write a review" button (auth-gated)
- **Rate dialog** (bottom sheet): 5-star selector + optional text field → POST → show "Pending approval" snackbar

---

### Screen 3 — Login (LoginScreen)

**Route**: `/login`  

- Email + Password fields with validation
- "Login" button (loading state)
- "Forgot password?" placeholder (disabled, shows "Contact library staff" toast)
- Link to `/register`
- Show field-level errors from `ValidationException`
- On success → navigate to `/dashboard`

---

### Screen 4 — Register (RegisterScreen)

**Route**: `/register`  

Fields:
- Name (required)
- Email (required, email format)
- Role selector (student / faculty) — admin and librarian not selectable in-app
- Student ID (conditional: shown only when role = student)
- Password + Password Confirmation (min 8 chars)
- "Create Account" button with loading state
- Link to `/login`

---

### Screen 5 — Dashboard (DashboardScreen)

**Route**: `/dashboard`  
**Auth**: Required  

- Welcome header: "Hello, {name}" + role chip
- Stats row: 3 cards (Ratings submitted, Books borrowed, Avg rating given)
- "My Active Borrows" section: horizontal scrollable list of `BorrowCard` (book cover + title + due date chip, overdue highlighted in red)
- "My Recent Ratings" section: list of `RatingCard` (book + stars + approval badge: pending/approved/rejected)
- "For You" teaser: first 3 recommendations from `collaborative` type with "See all" link

---

### Screen 6 — Borrows (BorrowsScreen)

**Route**: `/borrows`  
**Auth**: Required  

- Segmented tabs: Active | History
- Paginated `ListView` of `BorrowCard` (full-width)
- `BorrowCard`: cover image, title, author, borrowed date, due date, status chip (color-coded: active=blue, returned=green, overdue=red), `isOverdue` triggers overdue warning banner
- Empty state per tab

---

### Screen 7 — Bookmarks (BookmarksScreen)

**Route**: `/bookmarks`  
**Auth**: Required  

- Paginated grid of `BookCard` with swipe-to-remove (calls toggle bookmark endpoint, optimistic update)
- Empty state: "No bookmarks yet" with "Browse catalog" CTA

---

### Screen 8 — Recommendations (RecommendationsScreen)

**Route**: `/recommendations`  
**Auth**: Required  

- Tab bar: "For You" (collaborative) | "By Genre" (genre_based) | "Trending"
- Each tab: `ListView` of `RecommendationCard` (book cover, title, author, reason type label, score as percentage bar)
- Tap → navigate to Book Detail

---

### Screen 9 — Profile (ProfileScreen)

**Route**: `/profile`  
**Auth**: Required  

- Avatar (initials fallback)
- Name, email, role chip, student ID (if present)
- "Edit Profile" in-place form (toggle edit mode)
- "Change Password" → navigates to `/profile/password`
- "Logout" with confirmation dialog

---

### Screen 10 — Change Password (ChangePasswordScreen)

**Route**: `/profile/password`  
**Auth**: Required  

- Current Password, New Password, Confirm Password fields
- Password strength indicator
- Submit → on success, show snackbar and pop

---

## 12. Shared Components

Build these before screens so screens can import them.

| Component | Description |
|---|---|
| `BookCard` | 2-col grid card: cover, title, author, stars, availability dot |
| `BorrowCard` | Full-width list card: cover thumbnail + borrow metadata |
| `RatingCard` | Rating row: user avatar initials + stars + message + approval badge |
| `RecommendationCard` | Book info + reason badge + score bar |
| `StarRating` | Tap-to-rate (interactive) or display-only; accepts `double` |
| `AvailabilityBadge` | Green "Available" / Red "Unavailable" chip |
| `ApprovalBadge` | Amber "Pending" / Green "Approved" / Red "Rejected" chip |
| `PaginatedListView` | Scrolls, calls `loadMore()` near bottom, shows loading footer |
| `EmptyState` | Icon + title + optional subtitle + optional CTA button |
| `ErrorState` | Error icon + message + "Retry" button |
| `LoadingOverlay` | Semi-transparent overlay with `CircularProgressIndicator` |
| `CoverImage` | `CachedNetworkImage` with Book icon placeholder, fixed aspect 2:3 |

---

## 13. Theme

```dart
// lib/core/config/theme.dart
final appTheme = ThemeData(
  colorSchemeSeed: const Color(0xFF1A237E),  // deep indigo — library feel
  useMaterial3: true,
  brightness: Brightness.light,
);

final appDarkTheme = ThemeData(
  colorSchemeSeed: const Color(0xFF1A237E),
  useMaterial3: true,
  brightness: Brightness.dark,
);
```

- System theme detection (`ThemeMode.system`)
- Typography: use `TextTheme` from Material 3 scale — `displaySmall` for book titles, `bodyMedium` for metadata
- Overdue borrows: always `Colors.red.shade700` regardless of theme

---

## 14. Error & Loading Patterns

- All async providers use `AsyncValue<T>` → use `.when(data, loading, error)` in widgets
- Never show raw `Exception.toString()` to the user — map to friendly messages:

| Exception | User message |
|---|---|
| `NetworkException` | "No internet connection" |
| `UnauthorizedException` | "Please log in again" |
| `ValidationException` | Show per-field under each form field |
| `ServerException` | "Something went wrong. Please try again." |
| `NotFoundException` | "Not found" |

- Snackbar helper: `ScaffoldMessenger.of(context).showSnackBar(...)` — use success (green), error (red), info (blue) styles.

---

## 15. Offline & Caching Strategy

- Book list and genre list: cache with `dio_cache_interceptor` using `CachePolicy.refreshForceCache` (serve stale while revalidating)
- Book detail: cache 10 minutes
- Auth-gated endpoints (borrows, bookmarks, ratings): no cache
- Cached network images: default flutter `CachedNetworkImage` disk cache
- On network error for cached routes: serve stale data + show a non-blocking "Offline mode" banner

---

## 16. Key Business Logic to Enforce in UI

1. **Borrow button state**: disabled if `book.availableCopies == 0` OR user already has an active borrow for this book (check against borrow history provider).
2. **Bookmark icon**: optimistic toggle — flip icon immediately, revert on API error.
3. **Rating approval status**: after submitting, show `ApprovalBadge("Pending")`. Do not count user's own pending rating in displayed average.
4. **Overdue styling**: any `Borrow` where `isOverdue == true` must render due date in red with a warning icon.
5. **Role-gated UI**: only show "Borrow" / "Rate" / "Bookmark" actions when `authState is _Authenticated`. Tapping while unauthenticated → show bottom sheet prompting login.
6. **Pagination cursor**: track `currentPage` and `lastPage` from `PaginationMeta`; disable load-more when `currentPage >= lastPage`.

---

## 17. Testing Plan

| Layer | What to test |
|---|---|
| Models | `fromJson` / `toJson` round-trip for every Freezed model |
| Repositories | Mock Dio, assert correct endpoints called, correct exception mapping |
| Notifiers | Unit test state transitions: login flow, logout, borrow success/failure |
| Widgets | `CatalogScreen` search debounce, `BookDetailScreen` borrow button disable state, `LoginScreen` validation errors |

---

## 18. Build & Run Instructions

```bash
# Install dependencies
flutter pub get

# Generate code (Freezed + JSON serializable)
dart run build_runner build --delete-conflicting-outputs

# Run on Android emulator (dev)
flutter run --dart-define=BASE_URL=http://10.0.2.2/api

# Run on iOS simulator (dev)
flutter run --dart-define=BASE_URL=http://localhost/api

# Production build
flutter build apk --release --dart-define=BASE_URL=https://api.yourdomain.com
flutter build ipa --release --dart-define=BASE_URL=https://api.yourdomain.com
```

---

## 19. pubspec.yaml Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.5.1
  riverpod_annotation: ^2.3.5
  go_router: ^14.2.0
  dio: ^5.4.3
  dio_cache_interceptor: ^3.4.4
  flutter_secure_storage: ^9.2.2
  shared_preferences: ^2.3.1
  cached_network_image: ^3.3.1
  flutter_form_builder: ^9.3.0
  form_builder_validators: ^10.0.1
  freezed_annotation: ^2.4.4
  json_annotation: ^4.9.0
  intl: ^0.19.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^4.0.0
  build_runner: ^2.4.11
  freezed: ^2.5.2
  json_serializable: ^6.8.0
  riverpod_generator: ^2.4.3
  mocktail: ^1.0.4
```

---

## 20. Delivery Checklist

- [ ] Scaffold: folder structure, `Env`, theme, router
- [ ] HTTP layer: Dio client, auth interceptor, error mapping
- [ ] All Freezed models generated
- [ ] All repositories implemented and unit tested
- [ ] Auth flow: register → login → token storage → auto-login on relaunch → logout
- [ ] Catalog screen with search + filter + infinite scroll
- [ ] Book detail with borrow + bookmark + rate actions
- [ ] Dashboard with stats + active borrows teaser + recommendations teaser
- [ ] Borrows screen (active + history tabs)
- [ ] Bookmarks screen with swipe-to-remove
- [ ] Recommendations screen with 3 tabs
- [ ] Profile + change password screens
- [ ] Shared components library complete
- [ ] Error and loading states on all async screens
- [ ] Dark mode support verified
- [ ] Widget tests for at least: login form, catalog search, book detail borrow button
- [ ] Production build succeeds for both Android and iOS
