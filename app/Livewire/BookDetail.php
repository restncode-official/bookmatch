<?php

declare(strict_types=1);

namespace App\Livewire;

use App\Enums\BorrowStatus;
use App\Events\BookBorrowed;
use App\Events\RatingSubmitted;
use App\Models\Book;
use App\Models\Bookmark;
use App\Models\Borrow;
use App\Models\Rating;
use Illuminate\Support\Facades\Auth;
use Livewire\Attributes\Computed;
use Livewire\Attributes\Layout;
use Livewire\Component;

#[Layout('layouts.public')]
class BookDetail extends Component
{
    public Book $book;
    public bool $isBookmarked = false;
    public bool $showBorrowModal = false;

    public int $newRating = 0;
    public string $newMessage = '';

    public bool $editingRating = false;
    public int $editRating = 0;
    public string $editMessage = '';

    public function mount(Book $book): void
    {
        $this->book = $book->load('genre');

        if (Auth::check()) {
            $this->isBookmarked = Bookmark::where('user_id', Auth::id())
                ->where('book_id', $book->id)
                ->exists();
        }
    }

    #[Computed]
    public function activeBorrow(): ?Borrow
    {
        if (! Auth::check()) {
            return null;
        }

        return Borrow::where('user_id', Auth::id())
            ->where('book_id', $this->book->id)
            ->whereIn('status', [BorrowStatus::Pending, BorrowStatus::Active, BorrowStatus::Overdue])
            ->first();
    }

    #[Computed]
    public function approvedRatings()
    {
        return $this->book->ratings()
            ->where('is_approved', true)
            ->with('user')
            ->latest()
            ->get();
    }

    #[Computed]
    public function userRating(): ?Rating
    {
        if (! Auth::check()) {
            return null;
        }

        return $this->book->ratings()
            ->where('user_id', Auth::id())
            ->first();
    }

    public function openBorrowModal(): void
    {
        if (! Auth::check()) {
            return;
        }

        if ($this->activeBorrow) {
            $this->addError('borrow', 'You already have a pending or active borrow for this book.');
            return;
        }

        $activeBorrowCount = Borrow::where('user_id', Auth::id())
            ->whereIn('status', [BorrowStatus::Pending, BorrowStatus::Active, BorrowStatus::Overdue])
            ->count();

        if ($activeBorrowCount >= 5) {
            $this->addError('borrow', 'You have reached the maximum of 5 active borrows. Please return a book first.');
            return;
        }

        $this->book->refresh();

        if ($this->book->available_copies <= 0) {
            $this->addError('borrow', 'No copies are currently available.');
            return;
        }

        $this->showBorrowModal = true;
    }

    public function confirmBorrowRequest(): void
    {
        if (! Auth::check()) {
            return;
        }

        $borrow = Borrow::create([
            'user_id'     => Auth::id(),
            'book_id'     => $this->book->id,
            'borrowed_at' => null,
            'due_date'    => null,
            'status'      => BorrowStatus::Pending,
        ]);

        unset($this->activeBorrow);

        $this->showBorrowModal = false;

        BookBorrowed::dispatch($borrow);

        session()->flash('success', 'Request submitted! A librarian will approve it shortly.');
    }

    public function closeBorrowModal(): void
    {
        $this->showBorrowModal = false;
    }

    public function toggleBookmark(): void
    {
        if (! Auth::check()) {
            return;
        }

        $existing = Bookmark::where('user_id', Auth::id())
            ->where('book_id', $this->book->id)
            ->first();

        if ($existing) {
            $existing->delete();
            $this->isBookmarked = false;
        } else {
            Bookmark::create(['user_id' => Auth::id(), 'book_id' => $this->book->id]);
            $this->isBookmarked = true;
        }
    }

    public function submitRating(): void
    {
        if (! Auth::check()) {
            return;
        }

        $this->validate([
            'newRating'  => ['required', 'integer', 'min:1', 'max:5'],
            'newMessage' => ['required', 'string', 'max:1000'],
        ]);

        Rating::create([
            'user_id'     => Auth::id(),
            'book_id'     => $this->book->id,
            'rating'      => $this->newRating,
            'message'     => $this->newMessage,
            'is_approved' => null,
        ]);

        RatingSubmitted::dispatch(Auth::user(), $this->book);

        $this->newRating  = 0;
        $this->newMessage = '';

        unset($this->userRating);

        session()->flash('success', 'Review submitted for approval.');
    }

    public function startEdit(): void
    {
        $rating = $this->userRating;
        if ($rating) {
            $this->editRating    = $rating->rating;
            $this->editMessage   = $rating->message ?? '';
            $this->editingRating = true;
        }
    }

    public function cancelEdit(): void
    {
        $this->editingRating = false;
        $this->editRating    = 0;
        $this->editMessage   = '';
    }

    public function updateRating(): void
    {
        if (! Auth::check()) {
            return;
        }

        $this->validate([
            'editRating'  => ['required', 'integer', 'min:1', 'max:5'],
            'editMessage' => ['required', 'string', 'max:1000'],
        ]);

        $rating = $this->userRating;
        if (! $rating || $rating->user_id !== Auth::id()) {
            return;
        }

        $rating->update([
            'rating'      => $this->editRating,
            'message'     => $this->editMessage,
            'is_approved' => null,
        ]);

        $this->editingRating = false;
        $this->editRating    = 0;
        $this->editMessage   = '';

        unset($this->userRating);

        session()->flash('success', 'Review updated and resubmitted for approval.');
    }

    public function deleteRating(): void
    {
        if (! Auth::check()) {
            return;
        }

        $rating = $this->userRating;
        if ($rating && $rating->user_id === Auth::id()) {
            $rating->delete();
            unset($this->userRating);
            session()->flash('success', 'Review deleted.');
        }
    }

    public function render()
    {
        return view('livewire.book-detail', [
            'approvedRatings'  => $this->approvedRatings,
            'userRating'       => $this->userRating,
            'activeBorrow'     => $this->activeBorrow,
            'showBorrowModal'  => $this->showBorrowModal,
        ])->title($this->book->title);
    }
}
