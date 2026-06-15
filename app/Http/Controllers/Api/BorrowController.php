<?php

declare(strict_types=1);

namespace App\Http\Controllers\Api;

use App\Enums\BorrowStatus;
use App\Events\BookBorrowed;
use App\Http\Controllers\Controller;
use App\Http\Resources\BorrowResource;
use App\Models\Book;
use App\Models\Borrow;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;
use Illuminate\Support\Facades\DB;

class BorrowController extends Controller
{
    /**
     * The authenticated user's borrow history.
     */
    public function index(Request $request): AnonymousResourceCollection
    {
        $borrows = $request->user()->borrows()
            ->with('book.genre')
            ->latest()
            ->paginate(15);

        return BorrowResource::collection($borrows);
    }

    /**
     * Submit a borrow request. Creates a pending record for librarian approval.
     */
    public function store(Request $request, Book $book): JsonResponse
    {
        $user = $request->user();

        $alreadyRequested = Borrow::where('user_id', $user->id)
            ->where('book_id', $book->id)
            ->whereIn('status', [BorrowStatus::Pending, BorrowStatus::Active, BorrowStatus::Overdue])
            ->exists();

        if ($alreadyRequested) {
            return response()->json([
                'message' => 'You already have a pending or active borrow for this book.',
            ], 422);
        }

        $activeBorrowCount = Borrow::where('user_id', $user->id)
            ->whereIn('status', [BorrowStatus::Pending, BorrowStatus::Active, BorrowStatus::Overdue])
            ->count();

        if ($activeBorrowCount >= 5) {
            return response()->json([
                'message' => 'You have reached the maximum of 5 active borrows. Please return a book first.',
            ], 422);
        }

        $book->refresh();

        if ($book->available_copies <= 0) {
            return response()->json([
                'message' => 'No copies are currently available.',
            ], 422);
        }

        $borrow = Borrow::create([
            'user_id'     => $user->id,
            'book_id'     => $book->id,
            'borrowed_at' => null,
            'due_date'    => null,
            'status'      => BorrowStatus::Pending,
        ]);

        BookBorrowed::dispatch($borrow);

        return (new BorrowResource($borrow->load('book.genre')))
            ->response()
            ->setStatusCode(201);
    }

    public function returnBorrow(Request $request, Borrow $borrow): JsonResponse
    {
        $this->authorize('returnBorrow', $borrow);

        if (! in_array($borrow->status, [BorrowStatus::Active, BorrowStatus::Overdue], true)) {
            return response()->json([
                'message' => 'Only active or overdue borrows can be returned.',
            ], 422);
        }

        DB::transaction(function () use ($borrow): void {
            $borrow->update([
                'returned_at' => now(),
                'status'      => BorrowStatus::Returned,
            ]);
            $borrow->book?->increment('available_copies');
        });

        return (new BorrowResource($borrow->load('book.genre')))->response();
    }
}
