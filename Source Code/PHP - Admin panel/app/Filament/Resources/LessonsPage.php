<?php

namespace App\Filament\Resources\LanguageResource\Pages;

use Filament\Pages\Page;
use Kreait\Firebase\Factory;
use Illuminate\Support\Collection;

class LessonsPage extends Page
{
    protected static ?string $navigationIcon = 'heroicon-o-book-open';
    protected static string $view = 'filament.pages.lessons-page';

    public $courseId;
    public $lessons = [];

    public function mount($courseId)
    {
        $this->courseId = $courseId;
        $this->lessons = $this->fetchLessons($courseId);
    }

    protected function fetchLessons($courseId)
    {
        $firebase = (new Factory)
            ->withServiceAccount(config('services.firebase.credentials'))
            ->withDatabaseUri(config('services.firebase.database_url'))
            ->createDatabase();

        // Fetch lessons for the specific course from Firebase
        $lessons = $firebase->getReference("languages/{$courseId}/courses/{$courseId}/lessons")->getValue();

        // Convert the lessons array into a Collection
        if ($lessons === null) {
            return collect([]);
        }

        return collect($lessons);
    }
}
