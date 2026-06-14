<?php

declare(strict_types=1);

namespace App\Livewire;

use App\Models\Genre;
use App\Services\BookSearchService;
use Livewire\Attributes\Layout;
use Livewire\Attributes\Title;
use Livewire\Attributes\Url;
use Livewire\Component;
use Livewire\WithPagination;

#[Layout('layouts.public')]
#[Title('Advanced Search')]
class AdvancedBookSearch extends Component
{
    use WithPagination;

    #[Url(as: 'q', except: '')]
    public string $search = '';

    #[Url(except: '')]
    public string $genre = '';

    #[Url(as: 'rating', except: 0)]
    public int $minRating = 0;

    #[Url(as: 'from', except: '')]
    public string $yearFrom = '';

    #[Url(as: 'to', except: '')]
    public string $yearTo = '';

    #[Url(as: 'available', except: false)]
    public bool $availableOnly = false;

    #[Url(except: 'relevance')]
    public string $sort = 'relevance';

    public function updatingSearch(): void
    {
        $this->resetPage();
    }

    public function updatingGenre(): void
    {
        $this->resetPage();
    }

    public function updatingMinRating(): void
    {
        $this->resetPage();
    }

    public function updatingYearFrom(): void
    {
        $this->resetPage();
    }

    public function updatingYearTo(): void
    {
        $this->resetPage();
    }

    public function updatingAvailableOnly(): void
    {
        $this->resetPage();
    }

    public function updatingSort(): void
    {
        $this->resetPage();
    }

    public function clearFilters(): void
    {
        $this->reset(['search', 'genre', 'minRating', 'yearFrom', 'yearTo', 'availableOnly', 'sort']);
        $this->resetPage();
    }

    public function render(BookSearchService $searchService)
    {
        $phrases = $searchService->phrases($this->search);

        $books = $searchService->query([
            'q' => $this->search,
            'genre' => $this->genre,
            'minRating' => $this->minRating,
            'yearFrom' => $this->yearFrom,
            'yearTo' => $this->yearTo,
            'availableOnly' => $this->availableOnly,
            'sort' => $this->sort,
        ])->paginate(12)->withQueryString();

        // Pre-compute "why this matched" reasons for the current page only.
        $matchReasons = [];
        foreach ($books as $book) {
            $matchReasons[$book->id] = $searchService->matchedFields($book, $phrases);
        }

        return view('livewire.advanced-book-search', [
            'books' => $books,
            'genres' => Genre::orderBy('name')->get(),
            'matchReasons' => $matchReasons,
            'hasQuery' => $phrases !== [],
        ]);
    }
}
