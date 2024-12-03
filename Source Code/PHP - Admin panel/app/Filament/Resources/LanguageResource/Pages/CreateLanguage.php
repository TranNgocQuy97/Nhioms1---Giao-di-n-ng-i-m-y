<?php

namespace App\Filament\Resources\LanguageResource\Pages;

use App\Filament\Resources\LanguageResource;
use Filament\Resources\Pages\CreateRecord;
use Kreait\Firebase\Factory;
use Kreait\Firebase\ServiceAccount;
use Illuminate\Support\Str;

class CreateLanguage extends CreateRecord
{
    protected static string $resource = LanguageResource::class;

    protected function mutateFormDataBeforeCreate(array $data): array
    {
        // Tạo một ID ngẫu nhiên cho Firebase nếu cần thiết
        $data['firebase_id'] = (string) Str::uuid();
        return $data;
    }

    protected function afterCreate(): void
    {
        $firebase = (new Factory)
            ->withServiceAccount(config('services.firebase.credentials'))
            ->withDatabaseUri(config('services.firebase.database_url'))
            ->createDatabase();

        // Thêm dữ liệu vào Firebase
        $firebase->getReference("languages/{$this->record->firebase_id}")->set([
            'name' => $this->record->name,
            'courses' => [],
        ]);
    }
}
