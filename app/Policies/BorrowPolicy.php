<?php

declare(strict_types=1);

namespace App\Policies;

use App\Enums\BorrowStatus;
use App\Models\Borrow;
use App\Models\User;

class BorrowPolicy
{
    /**
     * Determine whether the user can view any models.
     */
    public function viewAny(User $user): bool
    {
        return true;
    }

    /**
     * Determine whether the user can view the model.
     */
    public function view(User $user, Borrow $borrow): bool
    {
        return $user->id === $borrow->user_id;
    }

    public function create(User $user): bool
    {
        return true;
    }

    public function returnBorrow(User $user, Borrow $borrow): bool
    {
        return $user->id === $borrow->user_id
            && in_array($borrow->status, [BorrowStatus::Active, BorrowStatus::Overdue], true);
    }

    public function cancelRequest(User $user, Borrow $borrow): bool
    {
        return $user->id === $borrow->user_id
            && $borrow->status === BorrowStatus::Pending;
    }

    /**
     * Determine whether the user can update the model.
     */
    public function update(User $user, Borrow $borrow): bool
    {
        return false;
    }

    /**
     * Determine whether the user can delete the model.
     */
    public function delete(User $user, Borrow $borrow): bool
    {
        return false;
    }

    /**
     * Determine whether the user can restore the model.
     */
    public function restore(User $user, Borrow $borrow): bool
    {
        return false;
    }

    /**
     * Determine whether the user can permanently delete the model.
     */
    public function forceDelete(User $user, Borrow $borrow): bool
    {
        return false;
    }
}
