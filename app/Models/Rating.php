<?php

declare(strict_types=1);

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

#[Fillable(['user_id', 'book_id', 'rating', 'message', 'is_approved'])]
class Rating extends Model
{
    use HasFactory;

    protected function casts(): array
    {
        return [];
    }

    // Preserves null (pending) vs false (rejected) vs true (approved).
    // Laravel's built-in boolean cast collapses null→false, losing that distinction.
    protected function isApproved(): Attribute
    {
        return Attribute::make(
            get: fn (mixed $value): ?bool => $value === null ? null : (bool) $value,
        );
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function book(): BelongsTo
    {
        return $this->belongsTo(Book::class);
    }
}
