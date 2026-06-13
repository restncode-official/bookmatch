<?php

namespace App\Filament\Resources;

use App\Filament\Resources\UserResource\Pages;
use App\Models\User;
use Filament\Actions\BulkActionGroup;
use Filament\Actions\DeleteBulkAction;
use Filament\Actions\DeleteAction;
use Filament\Actions\EditAction;
use Filament\Actions\ViewAction;
use Filament\Forms;
use Filament\Infolists;
use Filament\Infolists\Components\TextEntry;
use Filament\Infolists\Components\Section;
use Filament\Infolists\Infolist;
use Filament\Schemas\Schema;
use Filament\Tables;
use Filament\Tables\Table;
use Filament\Resources\Resource;
use Illuminate\Database\Eloquent\Builder;

class UserResource extends Resource
{
    protected static ?string $model = User::class;

    protected static string | \BackedEnum | null $navigationIcon = 'heroicon-o-user-group';

    public static function form(Schema $schema): Schema
    {
        return $schema
            ->schema([
                Forms\Components\TextInput::make('name')
                    ->required()
                    ->maxLength(255),
                Forms\Components\TextInput::make('email')
                    ->required()
                    ->email()
                    ->maxLength(255)
                    ->unique(ignoreRecord: true),
                Forms\Components\Select::make('role')
                    ->options([
                        'admin' => 'Admin',
                        'librarian' => 'Librarian',
                        'student' => 'Student',
                        'faculty' => 'Faculty',
                    ])
                    ->required()
                    ->default('student'),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->query(User::query())
            ->columns([
                Tables\Columns\TextColumn::make('name')
                    ->searchable()
                    ->sortable()
                    ->weight('font-medium'),
                Tables\Columns\TextColumn::make('email')
                    ->searchable()
                    ->sortable(),
                Tables\Columns\TextColumn::make('role')
                    ->badge()
                    ->color(fn (string $state): string => match ($state) {
                        'admin' => 'danger',
                        'librarian' => 'info',
                        'student' => 'success',
                        'faculty' => 'warning',
                        default => 'gray',
                    })
                    ->sortable(),
                Tables\Columns\TextColumn::make('ratings_count')
                    ->counts('ratings')
                    ->sortable()
                    ->toggleable(),
                Tables\Columns\TextColumn::make('borrows_count')
                    ->counts('borrows')
                    ->sortable()
                    ->toggleable(),
                Tables\Columns\TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->filters([])
            ->actions([
                ViewAction::make(),
                EditAction::make(),
                DeleteAction::make(),
            ])
            ->bulkActions([
                BulkActionGroup::make([
                    DeleteBulkAction::make(),
                ]),
            ])
            ->defaultSort('name');
    }

    public static function infolist(Schema $schema): Schema
    {
        return $schema
            ->schema([
                Infolists\Components\Section::make('User Information')
                    ->schema([
                        Infolists\Components\TextEntry::make('name'),
                        Infolists\Components\TextEntry::make('email'),
                        Infolists\Components\TextEntry::make('role')
                            ->badge()
                            ->color(fn (string $state): string => match ($state) {
                                'admin' => 'danger',
                                'librarian' => 'info',
                                'student' => 'success',
                                'faculty' => 'warning',
                                default => 'gray',
                            }),
                        Infolists\Components\TextEntry::make('student_id'),
                        Infolists\Components\TextEntry::make('department'),
                        Infolists\Components\TextEntry::make('created_at')
                            ->dateTime(),
                    ])
                    ->columns(2),
                Infolists\Components\Section::make('Statistics')
                    ->schema([
                        Infolists\Components\TextEntry::make('ratings_count')
                            ->label('Total Ratings')
                            ->counts('ratings'),
                        Infolists\Components\TextEntry::make('borrows_count')
                            ->label('Total Borrows')
                            ->counts('borrows'),
                    ])
                    ->columns(2),
            ]);
    }

    public static function getRelations(): array
    {
        return [];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListUsers::route('/'),
            'create' => Pages\CreateUser::route('/create'),
            'view' => Pages\ViewUser::route('/{record}'),
            'edit' => Pages\EditUser::route('/{record}/edit'),
        ];
    }
}
