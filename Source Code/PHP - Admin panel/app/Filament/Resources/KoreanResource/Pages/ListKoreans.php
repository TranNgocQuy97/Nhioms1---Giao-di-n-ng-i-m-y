<?php

namespace App\Filament\Resources\KoreanResource\Pages;

use App\Filament\Resources\KoreanResource;
use Filament\Pages\Actions;
use Filament\Resources\Pages\ListRecords;
use Kreait\Laravel\Firebase\Facades\Firebase;
use Illuminate\Support\Collection;

class ListKoreans extends ListRecords
{
    protected static string $resource = KoreanResource::class;

    protected function tableData(): Collection
    {
        $languages = Firebase::database()->getReference('languages')->getValue();

        $koreanCourses = $languages['KOREAN']['courses'] ?? [];

        return collect($koreanCourses)->map(function ($course) {
            return [
                'id' => $course['id'],
                'name' => $course['name'],
            ];
        });
    }
}
