<?php

declare(strict_types=1);

namespace App\Listeners;

use App\Events\RatingSubmitted;
use App\Models\User;
use App\Notifications\RatingSubmittedNotification;
use Illuminate\Contracts\Queue\ShouldQueue;

class SendRatingSubmittedNotification implements ShouldQueue
{
    public function handle(RatingSubmitted $event): void
    {
        $notification = new RatingSubmittedNotification($event->book->title, $event->user->name);

        User::role('librarian')->get()->each->notify($notification);
    }
}
