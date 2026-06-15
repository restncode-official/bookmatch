<?php

declare(strict_types=1);

namespace App\Filament\Resources;

use App\Enums\BorrowStatus;
use App\Filament\Resources\BorrowResource\Pages;
use App\Models\Book;
use App\Models\Borrow;
use Filament\Actions\BulkActionGroup;
use Filament\Actions\DeleteBulkAction;
use Filament\Actions\DeleteAction;
use Filament\Actions\EditAction;
use Filament\Actions\Action;
use Filament\Forms;
use Filament\Schemas\Schema;
use Filament\Tables;
use Filament\Tables\Table;
use Filament\Resources\Resource;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Facades\DB;

class BorrowResource extends Resource
{
    protected static ?string $model = Borrow::class;

    protected static string | \BackedEnum | null $navigationIcon = 'heroicon-o-arrow-right-circle';

    public static function form(Schema $schema): Schema
    {
        return $schema
            ->schema([
                Forms\Components\Select::make('user_id')
                    ->relationship('user', 'name')
                    ->searchable()
                    ->preload()
                    ->required(),
                Forms\Components\Select::make('book_id')
                    ->relationship('book', 'title')
                    ->searchable()
                    ->preload()
                    ->required(),
                Forms\Components\DateTimePicker::make('borrowed_at')
                    ->nullable(),
                Forms\Components\DatePicker::make('due_date')
                    ->nullable(),
                Forms\Components\Select::make('status')
                    ->options([
                        BorrowStatus::Pending->value  => 'Pending',
                        BorrowStatus::Active->value   => 'Active',
                        BorrowStatus::Returned->value => 'Returned',
                        BorrowStatus::Overdue->value  => 'Overdue',
                        BorrowStatus::Rejected->value => 'Rejected',
                    ])
                    ->required()
                    ->default(BorrowStatus::Pending->value),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->query(Borrow::query()->with(['user', 'book']))
            ->columns([
                Tables\Columns\TextColumn::make('user.name')
                    ->searchable()
                    ->sortable()
                    ->weight('font-medium'),
                Tables\Columns\TextColumn::make('book.title')
                    ->searchable()
                    ->sortable()
                    ->limit(30),
                Tables\Columns\TextColumn::make('borrowed_at')
                    ->dateTime()
                    ->sortable(),
                Tables\Columns\TextColumn::make('due_date')
                    ->date()
                    ->sortable()
                    ->placeholder('—')
                    ->color(fn (Borrow $record): string => $record->status === BorrowStatus::Active && $record->due_date && now()->greaterThan($record->due_date) ? 'danger' : 'gray'),
                Tables\Columns\TextColumn::make('status')
                    ->badge()
                    ->formatStateUsing(fn (BorrowStatus $state): string => ucfirst($state->value))
                    ->color(fn (BorrowStatus $state): string => match ($state) {
                        BorrowStatus::Pending  => 'warning',
                        BorrowStatus::Active   => 'primary',
                        BorrowStatus::Returned => 'success',
                        BorrowStatus::Overdue  => 'danger',
                        BorrowStatus::Rejected => 'gray',
                    })
                    ->sortable(),
                Tables\Columns\TextColumn::make('returned_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->filters([
                Tables\Filters\SelectFilter::make('status')
                    ->options([
                        BorrowStatus::Pending->value  => 'Pending',
                        BorrowStatus::Active->value   => 'Active',
                        BorrowStatus::Returned->value => 'Returned',
                        BorrowStatus::Overdue->value  => 'Overdue',
                        BorrowStatus::Rejected->value => 'Rejected',
                    ]),
            ])
            ->actions([
                Action::make('approveRequest')
                    ->label('Approve')
                    ->icon('heroicon-o-check-badge')
                    ->color('success')
                    ->visible(fn (Borrow $record): bool => $record->status === BorrowStatus::Pending)
                    ->form([
                        Forms\Components\DatePicker::make('due_date')
                            ->label('Due Date')
                            ->required()
                            ->default(now()->addDays(14)->toDateString()),
                    ])
                    ->action(function (Borrow $record, array $data): void {
                        DB::transaction(function () use ($record, $data): void {
                            $record->update([
                                'status'      => BorrowStatus::Active,
                                'borrowed_at' => now(),
                                'due_date'    => $data['due_date'],
                            ]);
                            $record->book?->decrement('available_copies');
                        });
                    }),
                Action::make('rejectRequest')
                    ->label('Reject')
                    ->icon('heroicon-o-x-circle')
                    ->color('danger')
                    ->visible(fn (Borrow $record): bool => $record->status === BorrowStatus::Pending)
                    ->requiresConfirmation()
                    ->action(fn (Borrow $record): bool => $record->update(['status' => BorrowStatus::Rejected])),
                Action::make('markAsReturned')
                    ->label('Mark as Returned')
                    ->icon('heroicon-o-check-circle')
                    ->color('success')
                    ->visible(fn (Borrow $record): bool => in_array($record->status, [BorrowStatus::Active, BorrowStatus::Overdue], true))
                    ->requiresConfirmation()
                    ->action(function (Borrow $record): void {
                        DB::transaction(function () use ($record): void {
                            $record->update([
                                'returned_at' => now(),
                                'status'      => BorrowStatus::Returned,
                            ]);
                            $record->book?->increment('available_copies');
                        });
                    }),
                EditAction::make(),
                DeleteAction::make(),
            ])
            ->bulkActions([
                BulkActionGroup::make([
                    DeleteBulkAction::make(),
                ]),
            ])
            ->defaultSort('borrowed_at', 'desc');
    }

    public static function getRelations(): array
    {
        return [];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListBorrows::route('/'),
            'create' => Pages\CreateBorrow::route('/create'),
            'view' => Pages\ViewBorrow::route('/{record}'),
            'edit' => Pages\EditBorrow::route('/{record}/edit'),
        ];
    }
}
