<?php

namespace Tests\Feature;

use App\Enums\UserRole;
use App\Events\RatingApproved;
use App\Models\Rating;
use App\Models\User;
use Database\Seeders\RolesAndPermissionsSeeder;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Event;
use Tests\TestCase;

class AdminRatingApprovalTest extends TestCase
{
    use RefreshDatabase;

    protected function setUp(): void
    {
        parent::setUp();
        $this->seed(RolesAndPermissionsSeeder::class);
        app()[\Spatie\Permission\PermissionRegistrar::class]->forgetCachedPermissions();
    }

    public function test_admin_can_approve_rating(): void
    {
        Event::fake([RatingApproved::class]);

        $admin  = User::factory()->create(['role' => UserRole::Admin]);
        $admin->assignRole('admin');
        $rating = Rating::factory()->create(['is_approved' => false]);

        $this->assertTrue($admin->hasPermissionTo('approve-ratings'));

        $rating->update(['is_approved' => true]);
        RatingApproved::dispatch($rating->load('user', 'book'));

        $this->assertDatabaseHas('ratings', ['id' => $rating->id, 'is_approved' => true]);
        Event::assertDispatched(RatingApproved::class, fn ($e) => $e->rating->id === $rating->id);
    }

    public function test_admin_can_reject_rating(): void
    {
        $admin  = User::factory()->create(['role' => UserRole::Admin]);
        $admin->assignRole('admin');
        $rating = Rating::factory()->create();

        $this->assertTrue($admin->hasPermissionTo('approve-ratings'));

        $rating->delete();

        $this->assertDatabaseMissing('ratings', ['id' => $rating->id]);
    }

    public function test_librarian_can_approve_rating(): void
    {
        $librarian = User::factory()->create(['role' => UserRole::Librarian]);
        $librarian->assignRole('librarian');
        $rating    = Rating::factory()->create(['is_approved' => false]);

        $this->assertTrue($librarian->hasPermissionTo('approve-ratings'));

        $rating->update(['is_approved' => true]);

        $this->assertDatabaseHas('ratings', ['id' => $rating->id, 'is_approved' => true]);
    }

    public function test_student_cannot_approve_rating(): void
    {
        $student = User::factory()->create(['role' => UserRole::Student]);
        $student->assignRole('student');

        $this->assertFalse($student->hasPermissionTo('approve-ratings'));

        // Attempting to delete another user's rating via the HTTP layer returns 403
        $owner  = User::factory()->create(['role' => UserRole::Student]);
        $owner->assignRole('student');
        $rating = Rating::factory()->for($owner, 'user')->create();

        $this->actingAs($student)
            ->delete(route('ratings.destroy', $rating))
            ->assertForbidden();
    }
}
