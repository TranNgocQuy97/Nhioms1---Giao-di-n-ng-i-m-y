<?php

namespace App\Filament\Resources\LessonResource\Widgets;

use Filament\Widgets\TableWidget as BaseWidget;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Actions\Action;
use Kreait\Firebase\Factory;
use Illuminate\Support\Collection;
use Illuminate\Database\Eloquent\Builder;

class ExercisesWidget extends BaseWidget
{
    protected int | string | array $columnSpan = 'full';

    public int $lessonId = 0;
    public int $courseId = 0; 
    public int $languageId = 0;

    public string $search = '';

    public function mount(int $languageId, int $courseId, int $lessonId): void
    {
        $this->languageId = $languageId;
        $this->courseId = $courseId; 
        $this->lessonId = $lessonId;
    }

    protected function getTableQuery(): Builder
    {
        $firebaseData = collect($this->getTableData());
        return \App\Models\Exercise::query()->whereIn('id', $firebaseData->pluck('id'));
    }

    protected function getTableData(): array
    {
        $exercises = $this->fetchExercises();
        return $exercises->toArray();
    }

    protected function getTableColumns(): array
    {
        return [
            TextColumn::make('id')->label('ID'),
            TextColumn::make('name')->label('Exercise Name'),
            TextColumn::make('type')->label('Type'),
        ];
    }

    protected function getTableActions(): array
    {
        return [
            Action::make('view')
                ->label('View')
                ->icon('heroicon-o-eye')
                ->url(fn($record) => route('filament.resources.languages.courses.lessons.exercises.questions', [
                    'languageId' => $this->languageId,
                    'courseId' => $this->courseId,
                    'lessonId' => $this->lessonId,
                    'exerciseId' => $record['id'],
                    'exerciseType' => $record['type']
                    ]))
                ->color('gray'),

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
                ->action(fn($record) => $this->deleteExercise($record)),
        ];
    }

    private function fetchExercises(): Collection
    {
        if ($this->lessonId <= 0 || $this->courseId <= 0 || $this->languageId <= 0) {
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
                ->firstWhere('id', $this->courseId); 

            if (!$selectedLesson || !isset($selectedLesson['exercises'])) {
                return collect();
            }

            return collect($selectedLesson['exercises'])
                ->filter(fn($exercise) => str_contains(strtolower($exercise['name'] ?? ''), strtolower($this->search)))
                ->sortBy('id');
        } catch (\Exception $e) {
            session()->flash('error', 'Failed to fetch exercises: ' . $e->getMessage());
            return collect();
        }
    }

    public function deleteExercise(array $record): void
    {
        try {
            $firebase = (new Factory)
                ->withServiceAccount(config('services.firebase.credentials'))
                ->withDatabaseUri(config('services.firebase.database_url'))
                ->createDatabase();

            $firebase->getReference("languages/{$this->languageId}/courses/{$this->courseId}/lessons/{$this->lessonId}/exercises/{$record['id']}")->remove();
            session()->flash('message', "Exercise deleted successfully.");
        } catch (\Exception $e) {
            session()->flash('error', 'Failed to delete exercise: ' . $e->getMessage());
        }
    }

    public function updateExercise(int $exerciseId, array $data): void
    {
        try {
            $firebase = (new Factory)
                ->withServiceAccount(config('services.firebase.credentials'))
                ->withDatabaseUri(config('services.firebase.database_url'))
                ->createDatabase();

            $firebase->getReference("languages/{$this->languageId}/courses/{$this->courseId}/lessons/{$this->$lessonId}/exercises/{$exerciseId}")->update([
                'name' => $data['name'],
            ]);
            session()->flash('message', 'Exercise updated successfully.');
        } catch (\Exception $e) {
            session()->flash('error', 'Failed to update exercise: ' . $e->getMessage());
        }
    }
}
