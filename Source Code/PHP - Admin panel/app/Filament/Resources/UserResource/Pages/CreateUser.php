<?php

namespace App\Filament\Resources\UserResource\Pages;

use App\Filament\Resources\UserResource;
use Filament\Resources\Pages\CreateRecord;
use Kreait\Laravel\Firebase\Facades\Firebase;

class CreateUser extends CreateRecord
{
    protected static string $resource = UserResource::class;

    protected function afterCreate(): void
    {
        Firebase::database()->getReference("users/{$this->record['firebase_id']}")->set([
            'name' => $this->record['name'],
            'email' => $this->record['email'],
            'role' => $this->record['role'],
            'password' => $this->record['password'], 
        ]);
    }
}
