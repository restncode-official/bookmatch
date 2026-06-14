<?php

declare(strict_types=1);

namespace App\Notifications;

use App\Models\Rating;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class RatingApprovedNotification extends Notification implements ShouldQueue
{
    use Queueable;

    public function __construct(private readonly Rating $rating) {}

    public function via(object $notifiable): array
    {
        return ['mail', 'database'];
    }

    public function toMail(object $notifiable): MailMessage
    {
        $book = $this->rating->book;

        return (new MailMessage)
            ->subject('Your review has been published')
            ->greeting('Hello ' . $notifiable->name . '!')
            ->line('Your review for "' . $book->title . '" is now live.')
            ->action('View Book', route('books.show', $book->slug))
            ->line('Thank you for contributing to Bookmatch!');
    }

    public function toArray(object $notifiable): array
    {
        return [
            'message'  => 'Your review for "' . $this->rating->book->title . '" has been published.',
            'book_id'  => $this->rating->book_id,
            'book_slug' => $this->rating->book->slug,
        ];
    }
}
