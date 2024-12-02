<?php

namespace App\Filament\Resources;

use App\Filament\Resources\ChineseResource\Pages;
use Filament\Forms;
use Filament\Resources\Form;
use Filament\Resources\Resource;
use Filament\Resources\Table;
use Filament\Tables;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Actions\Action;
use Kreait\Laravel\Firebase\Facades\Firebase;

class ChineseResource extends Resource
{
    protected static ?string $model = null;  

    protected static ?string $navigationGroup = 'Languages';
    protected static ?string $navigationIcon = 'heroicon-o-book-open';
    protected static ?string $label = 'Chinese Courses';
    protected static ?int $navigationSort = 1;

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\TextInput::make('name')
                    ->label('Course Name')
                    ->required()
                    ->maxLength(255),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('id')
                    ->label('ID')
                    ->sortable()
                    ->searchable(),
                TextColumn::make('name')
                    ->label('Course')
                    ->sortable()
                    ->searchable(),
            ])
            ->filters([])
            ->actions([
                Tables\Actions\ViewAction::make(),
                Tables\Actions\EditAction::make(),
                Tables\Actions\DeleteAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\DeleteBulkAction::make(),
            ]);
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListChineses::route('/'),
            'create' => Pages\CreateChinese::route('/create'),
            'edit' => Pages\EditChinese::route('/{record}/edit'),
        ];
    }
}
