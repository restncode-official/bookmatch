<?php

namespace Tests\Feature;

use App\Models\Book;
use App\Models\Genre;
use App\Models\Rating;
use App\Models\User;
use Database\Seeders\RolesAndPermissionsSeeder;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Livewire\Livewire;
use App\Livewire\BookCatalogue;
use Tests\TestCase;

class BookCatalogueTest extends TestCase
{
    use RefreshDatabase;

    protected function setUp(): void
    {
        parent::setUp();
        $this->seed(RolesAndPermissionsSeeder::class);
        app()[\Spatie\Permission\PermissionRegistrar::class]->forgetCachedPermissions();
    }

    public function test_catalogue_returns_books(): void
    {
        Book::factory()->count(5)->create();

        Livewire::test(BookCatalogue::class)
            ->assertOk()
            ->assertViewHas('books', fn ($books) => $books->total() === 5);
    }

    public function test_search_by_title_returns_correct_results(): void
    {
        $target = Book::factory()->create(['title' => 'Eloquent JavaScript Deep Dive']);
        Book::factory()->count(4)->create();

        Livewire::test(BookCatalogue::class)
            ->set('search', 'Eloquent JavaScript')
            ->assertViewHas('books', fn ($books) => $books->total() === 1
                && $books->first()->id === $target->id);
    }

    public function test_filter_by_genre_returns_correct_books(): void
    {
        $genre       = Genre::factory()->create();
        $otherGenre  = Genre::factory()->create();

        Book::factory()->count(3)->create(['genre_id' => $genre->id]);
        Book::factory()->count(2)->create(['genre_id' => $otherGenre->id]);

        Livewire::test(BookCatalogue::class)
            ->set('genre', (string) $genre->id)
            ->assertViewHas('books', fn ($books) => $books->total() === 3);
    }

    public function test_filter_by_minimum_rating_works(): void
    {
        $highBook = Book::factory()->create();
        $lowBook  = Book::factory()->create();
        $rater    = User::factory()->create();

        Rating::factory()->create([
            'user_id'     => $rater->id,
            'book_id'     => $highBook->id,
            'rating'      => 5,
            'is_approved' => true,
        ]);
        Rating::factory()->create([
            'user_id'     => $rater->id,
            'book_id'     => $lowBook->id,
            'rating'      => 2,
            'is_approved' => true,
        ]);

        Livewire::test(BookCatalogue::class)
            ->set('minRating', 4)
            ->assertViewHas('books', function ($books) use ($highBook, $lowBook) {
                $ids = $books->pluck('id')->all();
                return in_array($highBook->id, $ids) && !in_array($lowBook->id, $ids);
            });
    }
}
