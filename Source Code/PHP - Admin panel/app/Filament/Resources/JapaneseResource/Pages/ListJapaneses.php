<?php

namespace App\Filament\Resources\JapaneseResource\Pages;

use App\Filament\Resources\JapaneseResource;
use Filament\Pages\Actions;
use Filament\Resources\Pages\ListRecords;
use Kreait\Laravel\Firebase\Facades\Firebase;
use Illuminate\Support\Collection;

class ListJapaneses extends ListRecords
{
    protected static string $resource = JapaneseResource::class;

    protected function tableData(): Collection
    {
        $languages = Firebase::database()->getReference('languages')->getValue();

        $japaneseCourses = $languages['JAPANESE']['courses'] ?? [];

        return collect($japaneseCourses)->map(function ($course) {
            return [
                'id' => $course['id'],
                'name' => $course['name'],
            ];
        });
    }
}
