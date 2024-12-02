<?php
namespace App\Filament\Resources\ChineseResource\Pages;

use App\Filament\Resources\ChineseResource;
use Filament\Pages\Actions;
use Filament\Resources\Pages\CreateRecord;
use Kreait\Firebase\Factory;
use Illuminate\Support\Str;

class CreateChinese extends CreateRecord
{
    protected static string $resource = ChineseResource::class;

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

        $firebase->getReference("languages/CHINESE/courses/{$this->record->firebase_id}")->set([
            'name' => $this->record->name,
            'language' => 'Chinese',
            'lessons' => [], 
        ]);
    }
}

