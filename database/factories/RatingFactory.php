<?php

namespace Database\Factories;

use App\Models\Book;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<\App\Models\Rating>
 */
class RatingFactory extends Factory
{
    public function definition(): array
    {
        return [
            'user_id'     => User::factory(),
            'book_id'     => Book::factory(),
            'rating'      => fake()->numberBetween(1, 5),
            'message'     => fake()->optional(0.6)->sentence(),
            'is_approved' => null,
        ];
    }

    public function approved(): static
    {
        return $this->state(['is_approved' => true]);
    }
}
