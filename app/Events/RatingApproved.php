<?php

declare(strict_types=1);

namespace App\Events;

use App\Models\Rating;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class RatingApproved
{
    use Dispatchable, SerializesModels;

    public function __construct(public readonly Rating $rating) {}
}
