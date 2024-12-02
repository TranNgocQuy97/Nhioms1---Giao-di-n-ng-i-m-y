<?php

namespace App\Filament\Resources\EnglishResource\Pages;

use App\Filament\Resources\EnglishResource;
use Filament\Resources\Pages\CreateRecord;
use Kreait\Firebase\Factory;
use Illuminate\Support\Str;
use Filament\Pages\Actions;

class CreateEnglish extends CreateRecord
{
    protected static string $resource = EnglishResource::class;

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
            'language' => 'English',
            'lessons' => [],
        ]);
    }
}
