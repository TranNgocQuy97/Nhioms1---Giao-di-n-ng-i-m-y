<?php

namespace App\Filament\Resources\LanguageResource\Pages;

use Filament\Pages\Page;
use Kreait\Firebase\Factory;
use Kreait\Firebase\ServiceAccount;
use Illuminate\Support\Collection;

class ExercisesPage extends Page
{
    protected static ?string $navigationIcon = 'heroicon-o-clipboard-list';
    protected static string $view = 'filament.pages.exercises-page';

    public $lessonId;
    public $exercises = [];

    public function mount($lessonId)
    {
        $this->lessonId = $lessonId;
        $this->exercises = $this->fetchExercises($lessonId);
    }

    protected function fetchExercises($lessonId)
    {
        $firebase = (new Factory)
            ->withServiceAccount(config('services.firebase.credentials'))
            ->withDatabaseUri(config('services.firebase.database_url'))
            ->createDatabase();

        // Fetch exercises for the specific lesson from Firebase
        $exercises = $firebase->getReference("lessons/{$lessonId}/exercises")->getValue();

        // Convert the exercises array into a Collection
        return collect($exercises);
    }
}
