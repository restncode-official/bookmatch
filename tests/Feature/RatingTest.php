<?php

namespace Tests\Feature;

use App\Enums\UserRole;
use App\Models\Book;
use App\Models\Rating;
use App\Models\User;
use Database\Seeders\RolesAndPermissionsSeeder;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Livewire\Livewire;
use App\Livewire\BookDetail;
use Tests\TestCase;

class RatingTest extends TestCase
{
    use RefreshDatabase;

    protected function setUp(): void
    {
        parent::setUp();
        $this->seed(RolesAndPermissionsSeeder::class);
        app()[\Spatie\Permission\PermissionRegistrar::class]->forgetCachedPermissions();
    }

    public function test_authenticated_user_can_submit_rating(): void
    {
        $user = User::factory()->create(['role' => UserRole::Student]);
        $user->assignRole('student');
        $book = Book::factory()->create();

        Livewire::actingAs($user)
            ->test(BookDetail::class, ['book' => $book])
            ->set('newRating', 4)
            ->set('newMessage', 'Really enjoyed this book.')
            ->call('submitRating')
            ->assertHasNoErrors();

        $this->assertDatabaseHas('ratings', [
            'user_id'     => $user->id,
            'book_id'     => $book->id,
            'rating'      => 4,
            'is_approved' => null,
        ]);
    }

    public function test_user_cannot_submit_duplicate_rating(): void
    {
        $user = User::factory()->create(['role' => UserRole::Student]);
        $user->assignRole('student');
        $book = Book::factory()->create();

        Rating::factory()->create([
            'user_id' => $user->id,
            'book_id' => $book->id,
            'rating'  => 3,
        ]);

        // Component shows edit form, not create form — calling submitRating does nothing (guard: userRating exists)
        Livewire::actingAs($user)
            ->test(BookDetail::class, ['book' => $book])
            ->call('submitRating');

        $this->assertSame(1, Rating::where('user_id', $user->id)->where('book_id', $book->id)->count());
    }

    public function test_user_can_edit_own_rating(): void
    {
        $user = User::factory()->create(['role' => UserRole::Student]);
        $user->assignRole('student');
        $book = Book::factory()->create();

        Rating::factory()->create([
            'user_id' => $user->id,
            'book_id' => $book->id,
            'rating'  => 2,
            'message' => 'Initial review',
        ]);

        Livewire::actingAs($user)
            ->test(BookDetail::class, ['book' => $book])
            ->call('startEdit')
            ->set('editRating', 5)
            ->set('editMessage', 'Changed my mind — excellent!')
            ->call('updateRating')
            ->assertHasNoErrors();

        $this->assertDatabaseHas('ratings', [
            'user_id' => $user->id,
            'book_id' => $book->id,
            'rating'  => 5,
            'message' => 'Changed my mind — excellent!',
        ]);
    }

    public function test_user_cannot_edit_others_rating(): void
    {
        $owner = User::factory()->create(['role' => UserRole::Student]);
        $owner->assignRole('student');
        $attacker = User::factory()->create(['role' => UserRole::Student]);
        $attacker->assignRole('student');
        $rating = Rating::factory()->for($owner, 'user')->create();

        $this->actingAs($attacker)
            ->delete(route('ratings.destroy', $rating))
            ->assertForbidden();
    }

    public function test_unauthenticated_user_cannot_rate(): void
    {
        $book = Book::factory()->create();

        $this->post(route('ratings.store', $book), ['rating' => 5, 'message' => 'Good'])
            ->assertRedirect(route('login'));
    }
}
