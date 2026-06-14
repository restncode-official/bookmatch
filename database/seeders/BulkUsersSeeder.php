<?php

declare(strict_types=1);

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;

class BulkUsersSeeder extends Seeder
{
    public function run(): void
    {
        User::factory()->count(60)->create();
        User::factory()->faculty()->count(40)->create();
    }
}
