<?php
namespace App\Filament\Resources\ChineseResource\Pages;

use App\Filament\Resources\ChineseResource;
use Filament\Pages\Actions;
use Filament\Resources\Pages\EditRecord;
use Kreait\Firebase\Factory;

class EditChinese extends EditRecord
{
    protected static string $resource = ChineseResource::class;

    protected function afterSave(): void
    {
        $firebase = (new Factory)
            ->withServiceAccount(config('services.firebase.credentials'))
            ->withDatabaseUri(config('services.firebase.database_url'))
            ->createDatabase();

        $firebase->getReference("languages/CHINESE/courses/{$this->record->firebase_id}")->update([
            'name' => $this->record->name,
        ]);
    }
}
