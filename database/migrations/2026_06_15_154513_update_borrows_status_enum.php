<?php

declare(strict_types=1);

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // Extend the status enum to include pending and rejected.
        DB::statement("ALTER TABLE borrows MODIFY COLUMN status ENUM('active','returned','overdue','pending','rejected') NOT NULL DEFAULT 'active'");

        // borrowed_at and due_date are set on approval, not on request.
        Schema::table('borrows', function (Blueprint $table): void {
            $table->dateTime('borrowed_at')->nullable()->change();
            $table->date('due_date')->nullable()->change();
        });
    }

    public function down(): void
    {
        Schema::table('borrows', function (Blueprint $table): void {
            $table->dateTime('borrowed_at')->nullable(false)->change();
            $table->date('due_date')->nullable(false)->change();
        });

        DB::statement("ALTER TABLE borrows MODIFY COLUMN status ENUM('active','returned','overdue') NOT NULL DEFAULT 'active'");
    }
};
