<?php

namespace App\Filament\Resources\LessonResource\Widgets;

use Filament\Widgets\TableWidget as BaseWidget;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Columns\BooleanColumn;
use Filament\Tables\Actions\Action;
use Kreait\Firebase\Factory;
use Illuminate\Support\Collection;
use Illuminate\Database\Eloquent\Builder;

class QuestionsWidget extends BaseWidget
{
    protected int | string | array $columnSpan = 'full';

    public int $exerciseId = 0;
    public int $lessonId = 0;
    public int $courseId = 0; 
    public int $languageId = 0;
    protected string $exerciseType = '';

    public string $search = '';

    public function mount(int $exerciseId, int $languageId, int $courseId, int $lessonId, string $exerciseType = ''): void
    {
        $this->languageId = $languageId;
        $this->courseId = $courseId; 
        $this->lessonId = $lessonId;
        $this->exerciseId = $exerciseId;
        $this->exerciseType = $exerciseType;
    }

    protected function getTableQuery(): Builder
    {
        $firebaseData = collect($this->getTableData());
        return \App\Models\Question::query()->whereIn('id', $firebaseData->pluck('id'));
    }

    protected function getTableData(): array
    {
        $questions = $this->fetchQuestions();
        return $questions->toArray();
    }

    protected function getTableColumns(): array
    {
        return [
            TextColumn::make('id')
                ->label('ID'),

            TextColumn::make('name')
                ->label('Question'),

            TextColumn::make('video_url')
                ->label('Video'),

            TextColumn::make('audio_url')
                ->label('Audio'),

            TextColumn::make('answers')
                ->label('Answers')
                ->getStateUsing(function ($record) {
                    return collect($record['answers'])->map(function ($answer) {
                        $icon = $answer['is_correct'] ? 'heroicon-o-check-circle' : 'heroicon-o-x-circle';
                        $color = $answer['is_correct'] ? 'text-green-500' : 'text-red-500';
                        return "<div class='flex items-center space-x-2'>
                                    <span class='inline-block $color'>
                                        <x-heroicon-o-$icon class='w-5 h-5'/>
                                    </span>
                                    <span class='ml-2'>{$answer['answer_text']}</span>
                                </div>";
                    })->implode('');
                })
                ->html(),

            TextColumn::make('correct_answers')
                ->label('Correct Answers')
                ->getStateUsing(function ($record) {
                    return collect($record['answers'])->filter(function ($answer) {
                        return $answer['is_correct'] == 1; 
                    })->map(function ($answer) {
                        return "<div class='flex items-center space-x-2'>
                                    <span class='inline-block text-green-500'>
                                        <x-heroicon-o-check-circle class='w-5 h-5'/>
                                    </span>
                                    <span class='ml-2'>{$answer['answer_text']}</span>
                                </div>";
                    })->implode('');
                })
                ->html(),
        ];
    }

    protected function getTableActions(): array
    {
        return [
            // Action::make('view')
            //     ->label('View')
            //     ->icon('heroicon-o-eye')
            //     ->color('gray')
            //     ->url(fn ($record) => route('filament.resources.languages.courses.lessons.exercises.questions.answers', [
            //         'lessonId' => $this->lessonId,
            //         'courseId' => $this->courseId,
            //         'languageId' => $this->languageId,
            //         'exerciseId' => $this->exerciseId,
            //         'questionId' => $record['id'], 
            //     ])),

            Action::make('edit')
                ->label('Edit')
                ->icon('heroicon-o-pencil')
                ->requiresConfirmation()
                ->color('primary'),

            Action::make('delete')
                ->label('Delete')
                ->icon('heroicon-o-trash')
                ->requiresConfirmation()
                ->color('danger')
                ->action(fn($record) => $this->deleteQuestion($record)),
        ];
    }

    private function fetchQuestions(): Collection
    {
        if ($this->exerciseId <= 0 || $this->lessonId <= 0 || $this->courseId <= 0 || $this->languageId <= 0) {
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

            return collect($selectedExercise['questions'])
                ->map(function ($question) {
                    if (isset($question['answers'])) {
                        $question['answers'] = collect($question['answers'])->map(function ($answer) {
                            return [
                                'answer_text' => $answer['answer_text'],
                                'is_correct' => $answer['is_correct'] == 1, 
                            ];
                        });
                    } else {
                        $question['answers'] = [];
                    }
                    return $question;
                })
                ->filter(fn($question) => empty($this->search) || str_contains(strtolower($question['name'] ?? ''), strtolower($this->search)))
                ->sortBy('id');

        } catch (\Exception $e) {
            session()->flash('error', 'Failed to fetch questions: ' . $e->getMessage());
            return collect();
        }
    }

    public function deleteQuestion(array $record): void
    {
        try {
            $firebase = (new Factory)
                ->withServiceAccount(config('services.firebase.credentials'))
                ->withDatabaseUri(config('services.firebase.database_url'))
                ->createDatabase();

            $firebase->getReference("languages/{$this->languageId}/courses/{$this->courseId}/lessons/{$this->lessonId}/exercises/{$this->exerciseId}/questions/{$record['id']}")->remove();
            session()->flash('message', "Question deleted successfully.");
        } catch (\Exception $e) {
            session()->flash('error', 'Failed to delete exercise: ' . $e->getMessage());
        }
    }

    public function updateQuestion(int $questionId, array $data): void
    {
        try {
            $firebase = (new Factory)
                ->withServiceAccount(config('services.firebase.credentials'))
                ->withDatabaseUri(config('services.firebase.database_url'))
                ->createDatabase();

            $firebase->getReference("languages/{$this->languageId}/courses/{$this->courseId}/lessons/{$this->lessonId}/exercises/{$this->exerciseId}/questions/{$record['id']}")->update([
                'question' => $data['name'],
            ]);
            session()->flash('message', 'Question updated successfully.');
        } catch (\Exception $e) {
            session()->flash('error', 'Failed to update question: ' . $e->getMessage());
        }
    }
}
