<?php

namespace App\Filament\Resources\EnglishResource\Pages;

use App\Filament\Resources\EnglishResource;
use Filament\Pages\Actions;
use Filament\Resources\Pages\ListRecords;
use Kreait\Laravel\Firebase\Facades\Firebase;
use Illuminate\Support\Collection;

class ListEnglishes extends ListRecords
{
    protected static string $resource = EnglishResource::class;

    protected function tableData(): Collection
    {
        $languages = Firebase::database()->getReference('languages')->getValue();

        $englishCourses = $languages['ENGLISH']['courses'] ?? [];

        return collect($englishCourses)->map(function ($course) {
            return [
                'id' => $course['id'],
                'name' => $course['name'],
            ];
        });
    }
}
