<?php
namespace App\Filament\Resources\ChineseResource\Pages;

use App\Filament\Resources\ChineseResource;
use Filament\Pages\Actions;
use Filament\Resources\Pages\ListRecords;
use Kreait\Laravel\Firebase\Facades\Firebase;
use Illuminate\Support\Collection;

class ListChineses extends ListRecords
{
    protected static string $resource = ChineseResource::class;

    protected function tableData(): Collection
    {
        $languages = Firebase::database()->getReference('languages')->getValue();

        $chineseCourses = $languages['CHINESE']['courses'] ?? [];

        return collect($chineseCourses)->map(function ($course) {
            return [
                'id' => $course['id'],
                'name' => $course['name'],
            ];
        });
    }
}


