<?php

namespace Tests\Feature;

use App\Enums\UserRole;
use App\Models\Book;
use App\Models\Genre;
use App\Models\Rating;
use App\Models\Recommendation;
use App\Models\User;
use App\Services\RecommendationService;
use Database\Seeders\RolesAndPermissionsSeeder;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class RecommendationTest extends TestCase
{
    use RefreshDatabase;

    protected function setUp(): void
    {
        parent::setUp();
        $this->seed(RolesAndPermissionsSeeder::class);
        app()[\Spatie\Permission\PermissionRegistrar::class]->forgetCachedPermissions();
    }

    public function test_recommendation_service_generates_trending_results(): void
    {
        $genre = Genre::factory()->create();
        $books = Book::factory()->count(5)->create(['genre_id' => $genre->id]);
        $users = User::factory()->count(3)->create(['role' => UserRole::Student]);

        // Give each book several high-rated approved ratings in the last 30 days
        foreach ($books as $book) {
            foreach ($users as $user) {
                Rating::factory()->create([
                    'user_id'     => $user->id,
                    'book_id'     => $book->id,
                    'rating'      => 5,
                    'is_approved' => true,
                    'created_at'  => now()->subDays(10),
                ]);
            }
        }

        $service  = app(RecommendationService::class);
        $trending = $service->trending();

        $this->assertNotEmpty($trending);
        $this->assertContainsOnly('array', $trending);
        $this->assertArrayHasKey('book_id', $trending->first());
        $this->assertArrayHasKey('score', $trending->first());
    }

    public function test_recommendation_service_generates_genre_based_results(): void
    {
        $genre = Genre::factory()->create();
        $user  = User::factory()->create(['role' => UserRole::Student]);
        $user->assignRole('student');

        // User has highly-rated a book in this genre
        $ratedBook = Book::factory()->create(['genre_id' => $genre->id]);
        Rating::factory()->create([
            'user_id'     => $user->id,
            'book_id'     => $ratedBook->id,
            'rating'      => 5,
            'is_approved' => true,
        ]);

        // There are other books in the same genre with approved ratings
        $otherBooks = Book::factory()->count(3)->create(['genre_id' => $genre->id]);
        $rater      = User::factory()->create(['role' => UserRole::Student]);

        foreach ($otherBooks as $book) {
            Rating::factory()->create([
                'user_id'     => $rater->id,
                'book_id'     => $book->id,
                'rating'      => 4,
                'is_approved' => true,
            ]);
        }

        $service   = app(RecommendationService::class);
        $genreBased = $service->genreBased($user);

        $this->assertNotEmpty($genreBased);

        // Should not include the book the user already rated
        $this->assertNotContains(
            $ratedBook->id,
            $genreBased->pluck('book_id')->all()
        );
    }

    public function test_generate_for_user_creates_recommendations(): void
    {
        $genre = Genre::factory()->create();
        $user  = User::factory()->create(['role' => UserRole::Student]);
        $user->assignRole('student');

        // Seed enough data for at least trending to produce results
        $books = Book::factory()->count(5)->create(['genre_id' => $genre->id]);
        $rater = User::factory()->create(['role' => UserRole::Student]);

        foreach ($books as $book) {
            Rating::factory()->create([
                'user_id'     => $rater->id,
                'book_id'     => $book->id,
                'rating'      => 5,
                'is_approved' => true,
                'created_at'  => now()->subDays(5),
            ]);
        }

        $this->assertSame(0, Recommendation::where('user_id', $user->id)->count());

        app(RecommendationService::class)->generateForUser($user);

        $this->assertGreaterThan(0, Recommendation::where('user_id', $user->id)->count());
    }
}
