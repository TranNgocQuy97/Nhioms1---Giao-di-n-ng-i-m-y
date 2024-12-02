<?php

namespace App\Filament\Resources\EnglishResource\Pages;

use App\Filament\Resources\EnglishResource;
use Filament\Resources\Pages\EditRecord;
use Kreait\Firebase\Factory;
use Filament\Pages\Actions;

class EditEnglish extends EditRecord
{
    protected static string $resource = EnglishResource::class;

    protected function afterSave(): void
    {
        $firebase = (new Factory)
            ->withServiceAccount(config('services.firebase.credentials'))
            ->withDatabaseUri(config('services.firebase.database_url'))
            ->createDatabase();

        $firebase->getReference("courses/{$this->record->firebase_id}")->update([
            'name' => $this->record->name,
        ]);
    }
}
