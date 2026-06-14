<?php

declare(strict_types=1);

namespace App\Notifications;

use Illuminate\Notifications\Notification;

class RatingSubmittedNotification extends Notification
{
    public function __construct(
        private readonly string $bookTitle,
        private readonly string $userName,
    ) {}

    public function via(object $notifiable): array
    {
        return ['database'];
    }

    public function toArray(object $notifiable): array
    {
        return [
            'message' => 'New rating submitted for "' . $this->bookTitle . '" by ' . $this->userName . ' — needs approval.',
        ];
    }
}
