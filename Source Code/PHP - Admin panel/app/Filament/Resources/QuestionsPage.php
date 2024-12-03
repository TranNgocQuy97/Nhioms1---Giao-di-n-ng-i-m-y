<?php

namespace App\Filament\Resources\LanguageResource\Pages;

use Filament\Pages\Page;
use Kreait\Firebase\Factory;
use Kreait\Firebase\ServiceAccount;
use Illuminate\Support\Collection;

class QuestionsPage extends Page
{
    protected static ?string $navigationIcon = 'heroicon-o-question-mark-circle';
    protected static string $view = 'filament.pages.questions-page';

    public $exerciseId;
    public $questions = [];

    public function mount($exerciseId)
    {
        $this->exerciseId = $exerciseId;
        $this->questions = $this->fetchQuestions($exerciseId);
    }

    protected function fetchQuestions($exerciseId)
    {
        $firebase = (new Factory)
            ->withServiceAccount(config('services.firebase.credentials'))
            ->withDatabaseUri(config('services.firebase.database_url'))
            ->createDatabase();

        // Fetch questions for the specific exercise from Firebase
        $questions = $firebase->getReference("exercises/{$exerciseId}/questions")->getValue();

        // Convert the questions array into a Collection
        return collect($questions);
    }
}
