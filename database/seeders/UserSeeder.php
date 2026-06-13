<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    public function run(): void
    {
        $admin = User::create([
            'name' => 'Admin User',
            'email' => 'admin@library.edu',
            'password' => Hash::make('password'),
            'role' => 'admin',
        ]);
        $admin->assignRole('admin');

        foreach (range(1, 2) as $i) {
            $librarian = User::create([
                'name' => fake()->name(),
                'email' => 'librarian' . $i . '@library.edu',
                'password' => Hash::make('password'),
                'role' => 'librarian',
            ]);
            $librarian->assignRole('librarian');
        }

        $departments = ['CS', 'Math', 'Physics', 'Biology', 'Engineering'];

        foreach (range(1, 20) as $i) {
            $student = User::create([
                'name' => fake()->name(),
                'email' => 'student' . $i . '@library.edu',
                'password' => Hash::make('password'),
                'role' => 'student',
                'student_id' => 'STU-' . fake()->unique()->numberBetween(1000, 9999),
                'department' => fake()->randomElement($departments),
            ]);
            $student->assignRole('student');
        }
    }
}
