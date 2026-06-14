<?php

declare(strict_types=1);

namespace App\Listeners;

use App\Events\RatingApproved;
use App\Notifications\RatingApprovedNotification;
use Illuminate\Contracts\Queue\ShouldQueue;

class SendRatingApprovedNotification implements ShouldQueue
{
    public function handle(RatingApproved $event): void
    {
        $event->rating->user->notify(new RatingApprovedNotification($event->rating));
    }
}
