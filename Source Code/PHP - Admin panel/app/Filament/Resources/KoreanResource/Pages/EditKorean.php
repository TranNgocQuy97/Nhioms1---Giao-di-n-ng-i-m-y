<?php

namespace App\Filament\Resources\KoreanResource\Pages;

use App\Filament\Resources\KoreanResource;
use Filament\Pages\Actions;
use Filament\Resources\Pages\EditRecord;
use Kreait\Firebase\Factory;

class EditKorean extends EditRecord
{
    protected static string $resource = KoreanResource::class;

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
