<?php

namespace App\Filament\Resources\LanguageResource\Widgets;

use Filament\Widgets\TableWidget as BaseWidget;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Actions\Action;
use Filament\Tables\Actions\Action as TableAction;
use Kreait\Firebase\Factory;
use Illuminate\Support\Collection;
use Illuminate\Database\Eloquent\Builder;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Form;

class LessonsWidget extends BaseWidget
{
    protected int | string | array $columnSpan = 'full';

    public int $courseId = 0; 
    public int $languageId = 0;

    public string $search = ''; 

    public function mount(int $languageId, int $courseId): void
    {
        $this->languageId = $languageId;
        $this->courseId = $courseId; 
    }

    protected function getTableQuery(): Builder
    {
        $firebaseData = collect($this->getTableData()); 
        return \App\Models\Lesson::query()->whereIn('id', $firebaseData->pluck('id'));
    }

    protected function getTableData(): array
    {
        $lessons = $this->fetchLessons();
        return $lessons->toArray();
    }

    protected function getTableColumns(): array
    {
        return [
            TextColumn::make('id')->label('ID'),
            TextColumn::make('name')->label('Lesson Name'),
            TextColumn::make('level')->label('Level'),
        ];
    }

    protected function getTableActions(): array
    {
        return [
            Action::make('view')
                ->label('View')
                ->icon('heroicon-o-eye') 
                ->url(fn($record) => route('filament.resources.languages.courses.lessons.exercises', [
                    'languageId' => $this->languageId,
                    'courseId' => $this->courseId,
                    'lessonId' => $record['id']]))
                ->color('gray'),

            Action::make('edit')
                ->label('Edit')
                ->icon('heroicon-o-pencil')
                ->form([
                    TextInput::make('name')->label('Lesson Name')->required()->maxLength(255),
                ])
                ->action(function (array $data, $record) {
                    $this->updateLesson($record['id'], $data);
                })
                ->requiresConfirmation()
                ->color('primary'),

            Action::make('delete')
                ->label('Delete')
                ->icon('heroicon-o-trash')
                ->action(fn($record) => $this->deleteLesson($record))
                ->requiresConfirmation()
                ->color('danger'),
        ];
    }

    private function fetchLessons(): Collection
    {
        if ($this->courseId <= 0 || $this->languageId <= 0) {
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

            return collect($selectedCourse['lessons'])
                ->filter(fn($lesson) => str_contains(strtolower($lesson['name'] ?? ''), strtolower($this->search)))
                ->sortBy('id');
        } catch (\Exception $e) {
            session()->flash('error', 'Failed to fetch lessons: ' . $e->getMessage());
            return collect();
        }
    }

    public function deleteLesson(array $record): void
    {
        try {
            $firebase = (new Factory)
                ->withServiceAccount(config('services.firebase.credentials'))
                ->withDatabaseUri(config('services.firebase.database_url'))
                ->createDatabase();

            $firebase->getReference("courses/{$this->courseId}/lessons/{$record['id']}")->remove();
            session()->flash('message', "Lesson deleted successfully.");
        } catch (\Exception $e) {
            session()->flash('error', 'Failed to delete lesson: ' . $e->getMessage());
        }
    }

    public function updateLesson(int $lessonId, array $data): void
    {
        try {
            $firebase = (new Factory)
                ->withServiceAccount(config('services.firebase.credentials'))
                ->withDatabaseUri(config('services.firebase.database_url'))
                ->createDatabase();

            $firebase->getReference("languages/{$this->languageId}/courses/{$this->courseId}/lessons/{$lessonId}")->update([
                'name' => $data['name'],
            ]);
            session()->flash('message', 'Lesson updated successfully.');
        } catch (\Exception $e) {
            session()->flash('error', 'Failed to update lesson: ' . $e->getMessage());
        }
    }
}