<?php

declare(strict_types=1);

namespace App\Listeners;

use App\Events\BorrowDueSoon;
use App\Notifications\BorrowDueSoonNotification;
use Illuminate\Contracts\Queue\ShouldQueue;

class SendBorrowDueSoonNotification implements ShouldQueue
{
    public function handle(BorrowDueSoon $event): void
    {
        $event->borrow->user->notify(new BorrowDueSoonNotification($event->borrow));
    }
}
