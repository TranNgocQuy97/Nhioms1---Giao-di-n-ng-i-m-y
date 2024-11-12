<?php

namespace App\Filament\Resources\LanguageResource\Pages;

use App\Filament\Resources\LanguageResource;
use Filament\Pages\Actions;
use Filament\Resources\Pages\ListRecords;

class ListLanguages extends ListRecords
{
    protected static string $resource = LanguageResource::class;

    protected function tableData(): Collection
    {
        $serviceAccount = ServiceAccount::fromJsonFile(storage_path('firebase_credentials.json'));
        $firebase = (new Factory)
            ->withServiceAccount($serviceAccount)
            ->createDatabase();

        $languages = $firebase->getReference('languages')->getValue();

        // Chuyển dữ liệu từ Firebase thành Collection cho Filament
        return collect($languages);
    }
}
