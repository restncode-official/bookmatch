<?php

declare(strict_types=1);

namespace Tests\Feature;

use App\Enums\BorrowStatus;
use App\Livewire\AdvancedBookSearch;
use App\Models\Book;
use App\Models\Borrow;
use App\Models\Genre;
use App\Models\Rating;
use App\Models\User;
use App\Services\BookSearchService;
use Database\Seeders\RolesAndPermissionsSeeder;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Livewire\Livewire;
use Spatie\Permission\PermissionRegistrar;
use Tests\TestCase;

class AdvancedBookSearchTest extends TestCase
{
    use RefreshDatabase;

    private Genre $genre;

    protected function setUp(): void
    {
        parent::setUp();
        $this->seed(RolesAndPermissionsSeeder::class);
        app()[PermissionRegistrar::class]->forgetCachedPermissions();

        // A neutral genre whose name matches none of the search terms used below.
        $this->genre = Genre::factory()->create(['name' => 'Computing', 'slug' => 'computing']);
    }

    private function service(): BookSearchService
    {
        return app(BookSearchService::class);
    }

    /** Create a book with safe, controlled text so match counts are deterministic. */
    private function makeBook(array $attrs): Book
    {
        return Book::factory()->create(array_merge([
            'genre_id' => $this->genre->id,
            'author' => 'Anonymous Writer',
            'publisher' => 'Generic Press',
            'description' => 'No special content here.',
            'total_copies' => 2,
            'available_copies' => 2,
        ], $attrs));
    }

    /** @param list<int> $ratings */
    private function addApprovedRatings(Book $book, array $ratings): void
    {
        foreach ($ratings as $value) {
            Rating::factory()->approved()->create([
                'user_id' => User::factory()->create()->id,
                'book_id' => $book->id,
                'rating' => $value,
            ]);
        }
    }

    private function addBorrows(Book $book, int $count): void
    {
        $user = User::factory()->create();

        for ($i = 0; $i < $count; $i++) {
            Borrow::create([
                'user_id' => $user->id,
                'book_id' => $book->id,
                'borrowed_at' => now(),
                'due_date' => now()->addDays(14),
                'status' => BorrowStatus::Active,
            ]);
        }
    }

    public function test_title_match_outranks_description_only_match(): void
    {
        $titleMatch = $this->makeBook(['title' => 'Mastering Python']);
        $descMatch = $this->makeBook(['title' => 'A General Guide', 'description' => 'Covers python basics in depth.']);
        $this->makeBook(['title' => 'Unrelated Cookbook']); // excluded by the gate

        $results = $this->service()->query(['q' => 'Python'])->get();

        $this->assertCount(2, $results, 'Only books mentioning the term should pass the relevance gate.');
        $this->assertSame($titleMatch->id, $results->first()->id);
        $this->assertSame($descMatch->id, $results->last()->id);
    }

    public function test_rating_and_popularity_break_ties_between_equal_text_matches(): void
    {
        $strong = $this->makeBook(['title' => 'Laravel In Action']);
        $weak = $this->makeBook(['title' => 'Laravel Up And Running']);

        $this->addApprovedRatings($strong, [5, 5, 5]);
        $this->addBorrows($strong, 4);
        $this->addApprovedRatings($weak, [3]);

        $results = $this->service()->query(['q' => 'Laravel'])->get();

        $this->assertSame($strong->id, $results->first()->id);
        $this->assertSame($weak->id, $results->last()->id);
    }

    public function test_synonym_expansion_matches_description(): void
    {
        $nlpBook = $this->makeBook([
            'title' => 'Speech and Text Systems',
            'description' => 'An introduction to natural language processing techniques.',
        ]);
        $this->makeBook(['title' => 'Gardening Basics']);

        $results = $this->service()->query(['q' => 'NLP'])->get();

        $this->assertCount(1, $results);
        $this->assertSame($nlpBook->id, $results->first()->id);
    }

    public function test_stopwords_are_ignored_so_filler_words_do_not_break_matching(): void
    {
        $aiBook = $this->makeBook(['title' => 'Artificial Intelligence Foundations']);
        $this->makeBook(['title' => 'Watercolor Techniques']); // no "ai" substring → excluded

        $results = $this->service()->query(['q' => 'tell me the best books about AI'])->get();

        $this->assertCount(1, $results);
        $this->assertSame($aiBook->id, $results->first()->id);
    }

    public function test_only_approved_ratings_count_toward_the_score(): void
    {
        $approvedBook = $this->makeBook(['title' => 'Clean Code Guide']);
        $pendingBook = $this->makeBook(['title' => 'Clean Code Manual']);

        $this->addApprovedRatings($approvedBook, [5, 5, 5]);

        // Pending (unapproved) 5-star ratings must not influence ranking.
        Rating::factory()->count(3)->create([
            'book_id' => $pendingBook->id,
            'rating' => 5,
            'is_approved' => null,
        ]);

        $results = $this->service()->query(['q' => 'Clean Code'])->get();

        $this->assertSame($approvedBook->id, $results->first()->id);
    }

    public function test_available_only_filter_excludes_out_of_stock_books(): void
    {
        $inStock = $this->makeBook(['title' => 'In Stock', 'available_copies' => 2]);
        $outStock = $this->makeBook(['title' => 'Sold Out', 'available_copies' => 0]);

        $ids = $this->service()->query(['availableOnly' => true])->pluck('id');

        $this->assertTrue($ids->contains($inStock->id));
        $this->assertFalse($ids->contains($outStock->id));
    }

    public function test_published_year_range_filter(): void
    {
        $old = $this->makeBook(['title' => 'Old Book', 'published_year' => 1990]);
        $target = $this->makeBook(['title' => 'Mid Book', 'published_year' => 2010]);
        $new = $this->makeBook(['title' => 'New Book', 'published_year' => 2020]);

        $ids = $this->service()->query(['yearFrom' => 2000, 'yearTo' => 2015])->pluck('id');

        $this->assertEquals([$target->id], $ids->all());
        $this->assertFalse($ids->contains($old->id));
        $this->assertFalse($ids->contains($new->id));
    }

    public function test_match_reasons_report_which_fields_matched(): void
    {
        $book = $this->makeBook([
            'title' => 'Deep Learning',
            'description' => 'No special content here.',
        ]);

        $phrases = $this->service()->phrases('deep learning');

        $this->assertSame(['Title'], $this->service()->matchedFields($book->load('genre'), $phrases));
    }

    public function test_component_renders_and_ranks_relevant_results_first(): void
    {
        $target = $this->makeBook(['title' => 'Practical Python']);
        $this->makeBook(['title' => 'History of Pottery']);

        Livewire::test(AdvancedBookSearch::class)
            ->set('search', 'Python')
            ->assertOk()
            ->assertViewHas('books', fn ($books) => $books->total() === 1
                && $books->first()->id === $target->id);
    }
}
