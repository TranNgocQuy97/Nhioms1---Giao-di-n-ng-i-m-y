<?php

namespace App\Filament\Resources\LanguageResource\Pages;

use App\Filament\Resources\LanguageResource;
use Filament\Resources\Pages\EditRecord;
use Kreait\Firebase\Factory;
use Kreait\Firebase\ServiceAccount;

class EditLanguage extends EditRecord
{
    protected static string $resource = LanguageResource::class;

    protected function afterSave(): void
    {
        $firebase = (new Factory)
            ->withServiceAccount(config('services.firebase.credentials'))
            ->withDatabaseUri(config('services.firebase.database_url'))
            ->createDatabase();

        // Cập nhật dữ liệu trong Firebase
        $firebase->getReference("languages/{$this->record->firebase_id}")->update([
            'name' => $this->record->name,
        ]);
    }
}
