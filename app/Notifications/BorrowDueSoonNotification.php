<?php

declare(strict_types=1);

namespace App\Notifications;

use App\Models\Borrow;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class BorrowDueSoonNotification extends Notification implements ShouldQueue
{
    use Queueable;

    public function __construct(private readonly Borrow $borrow) {}

    public function via(object $notifiable): array
    {
        return ['mail', 'database'];
    }

    public function toMail(object $notifiable): MailMessage
    {
        $book    = $this->borrow->book;
        $dueDate = $this->borrow->due_date->format('M j, Y');

        return (new MailMessage)
            ->subject('Book due tomorrow')
            ->line('Your borrowed book "' . $book->title . '" is due tomorrow (' . $dueDate . ').')
            ->line('Please return it to avoid overdue status.')
            ->action('View Book', route('books.show', $book->slug));
    }

    public function toArray(object $notifiable): array
    {
        return [
            'message'   => 'Your borrowed book "' . $this->borrow->book->title . '" is due tomorrow.',
            'borrow_id' => $this->borrow->id,
            'book_id'   => $this->borrow->book_id,
            'due_date'  => $this->borrow->due_date->toDateString(),
        ];
    }
}
