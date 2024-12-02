<?php

namespace App\Filament\Resources\UserResource\Pages;

use App\Filament\Resources\UserResource;
use Filament\Resources\Pages\EditRecord;
use Kreait\Laravel\Firebase\Facades\Firebase;

class EditUser extends EditRecord
{
    protected static string $resource = UserResource::class;

    protected function afterSave(): void
    {
        Firebase::database()->getReference("users/{$this->record['firebase_id']}")->update([
            'name' => $this->record['name'],
            'email' => $this->record['email'],
            'role' => $this->record['role'],
        ]);
    }
}
