<?php

namespace App\Filament\Resources\LessonResource\Widgets;

use Filament\Widgets\TableWidget as BaseWidget;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Actions\Action;
use Kreait\Firebase\Factory;
use Illuminate\Support\Collection;
use Illuminate\Database\Eloquent\Builder;

class AnswersWidget extends BaseWidget
{
    protected int | string | array $columnSpan = 'full';

    public int $exerciseId = 0;
    public int $lessonId = 0;
    public int $courseId = 0;
    public int $languageId = 0;
    public int $questionId = 0; 

    public string $search = '';

    public function mount(int $questionId, int $exerciseId, int $languageId, int $courseId, int $lessonId): void
    {
        $this->languageId = $languageId;
        $this->courseId = $courseId; 
        $this->lessonId = $lessonId;
        $this->exerciseId = $exerciseId;
        $this->questionId = $questionId;
    }

    protected function getTableQuery(): Builder
    {
        $firebaseData = collect($this->getTableData());
        return \App\Models\Answer::query()->whereIn('id', $firebaseData->pluck('id'));
    }

    protected function getTableData(): array
    {
        $answers = $this->fetchAnswers();
        return $answers->toArray();
    }

    protected function getTableColumns(): array
    {
        return [
            TextColumn::make('question_name')
                ->label('Question Name'),

            TextColumn::make('audio_url')
                ->label('Audio'),

            TextColumn::make('answer_text')
                ->label('Answer'),

            TextColumn::make('is_correct')
                ->label('Is Correct')
                ->formatStateUsing(fn ($state) => $state ? 'Yes' : 'No'),
        ];
    }

    protected function getTableActions(): array
    {
        return [];
    }

    private function fetchAnswers(): Collection
    {
        if ($this->exerciseId <= 0 || $this->lessonId <= 0 || $this->courseId <= 0 || $this->languageId <= 0 || $this->questionId <= 0) {
            return collect();
        }

        try {
            $firebase = (new Factory)
                ->withServiceAccount(config('services.firebase.credentials'))
                ->withDatabaseUri(config('services.firebase.database_url'))
                ->createDatabase();

            $languages = $firebase->getReference("languages")->getValue();

            if (!$languages) {
                return collect(); 
            }

            $selectedLanguage = collect($languages)
                ->firstWhere('id', $this->languageId);

            if (!$selectedLanguage || !isset($selectedLanguage['courses'])) {
                return collect();
            }

            $selectedCourse = collect($selectedLanguage['courses'])
                ->firstWhere('id', $this->courseId); 

            if (!$selectedCourse || !isset($selectedCourse['lessons'])) {
                return collect();
            }

            $selectedLesson = collect($selectedCourse['lessons'])
                ->firstWhere('id', $this->lessonId);

            if (!$selectedLesson || !isset($selectedLesson['exercises'])) {
                return collect();
            }

            $selectedExercise = collect($selectedLesson['exercises'])
                ->firstWhere('id', $this->exerciseId);

            if (!$selectedExercise || !isset($selectedExercise['questions'])) {
                return collect();
            }

            $selectedQuestion = collect($selectedExercise['questions'])
                ->firstWhere('id', $this->questionId);

            if (!$selectedQuestion || !isset($selectedQuestion['answers'])) {
                return collect();
            }

            return collect($selectedQuestion['answers'])
                ->map(function ($answer) {
                    return [
                        'question_name' => $selectedQuestion['name'],
                        'audio_url' => $selectedQuestion['audio_url'],
                        'answer_text' => $answer['answer_text'],
                        'is_correct' => $answer['is_correct'],
                    ];
                })
                ->filter(fn($answer) => empty($this->search) || str_contains(strtolower($answer['answer_text'] ?? ''), strtolower($this->search)))
                ->sortBy('is_correct', SORT_DESC); 
        } catch (\Exception $e) {
            session()->flash('error', 'Failed to fetch answers: ' . $e->getMessage());
            return collect();
        }
    }
}
