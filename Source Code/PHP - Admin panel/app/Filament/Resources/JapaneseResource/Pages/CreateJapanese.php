<?php

namespace App\Filament\Resources\JapaneseResource\Pages;

use App\Filament\Resources\JapaneseResource;
use Filament\Pages\Actions;
use Filament\Resources\Pages\CreateRecord;
use Kreait\Firebase\Factory;
use Illuminate\Support\Str;

class CreateJapanese extends CreateRecord
{
    protected static string $resource = JapaneseResource::class;

    protected function mutateFormDataBeforeCreate(array $data): array
    {
        $data['firebase_id'] = (string) Str::uuid();
        return $data;
    }

    protected function afterCreate(): void
    {
        $firebase = (new Factory)
            ->withServiceAccount(config('services.firebase.credentials'))
            ->withDatabaseUri(config('services.firebase.database_url'))
            ->createDatabase();

        $firebase->getReference("courses/{$this->record->firebase_id}")->set([
            'name' => $this->record->name,
            'language' => 'Japanese',
            'lessons' => [],
        ]);
    }
}
