<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('ratings', function (Blueprint $table) {
            // null = pending, true = approved, false = rejected
            $table->boolean('is_approved')->nullable()->default(null)->change();
        });
    }

    public function down(): void
    {
        Schema::table('ratings', function (Blueprint $table) {
            $table->boolean('is_approved')->nullable(false)->default(false)->change();
        });
    }
};
