<?php

namespace App\Filament\Resources\LanguageResource\Pages;

use App\Filament\Resources\LanguageResource;
use Filament\Resources\Pages\ViewRecord;

class ListCourses extends ViewRecord
{
    protected static string $resource = LanguageResource::class;

    protected function getHeaderWidgets(): array
    {
        return [
            \App\Filament\Resources\LanguageResource\Widgets\CoursesWidget::class,
        ];
    }
}