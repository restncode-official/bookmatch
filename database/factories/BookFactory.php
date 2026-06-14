<?php

namespace Database\Factories;

use App\Models\Genre;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<\App\Models\Book>
 */
class BookFactory extends Factory
{
    public function definition(): array
    {
        $copies = fake()->numberBetween(1, 5);

        return [
            'title'            => fake()->unique()->sentence(3),
            'author'           => fake()->name(),
            'isbn'             => fake()->unique()->numerify('#############'),
            'genre_id'         => Genre::factory(),
            'publisher'        => fake()->company(),
            'published_year'   => fake()->numberBetween(1980, 2024),
            'description'      => fake()->paragraph(),
            'cover_image'      => null,
            'total_copies'     => $copies,
            'available_copies' => $copies,
            'location_code'    => null,
        ];
    }
}
