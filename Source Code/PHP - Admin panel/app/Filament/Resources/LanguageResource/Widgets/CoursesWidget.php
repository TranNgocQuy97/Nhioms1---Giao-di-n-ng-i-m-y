<?php

namespace App\Filament\Resources\LanguageResource\Widgets;

use Filament\Widgets\TableWidget as BaseWidget;
use Illuminate\Database\Eloquent\Builder; 
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Actions\Action;
use Filament\Tables\Filters\Filter;
use Kreait\Firebase\Factory;
use Illuminate\Support\Collection;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Form;

class CoursesWidget extends BaseWidget
{
    protected int | string | array $columnSpan = 'full';

    public ?int $languageId = null;

    public string $search = ''; 

    public function mount(): void
    {
        $this->languageId = (int) (request()->route('record') ?? 0);
    }

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\TextInput::make('name')
                    ->label('Course Name')
                    ->required()
                    ->maxLength(255),
            ]);
    }

    protected function getTableQuery(): Builder
    {
        $firebaseData = collect($this->getTableData()); 
        return \App\Models\Course::query()->whereIn('id', $firebaseData->pluck('id'));
    }

    protected function getTableData(): array
    {
        $courses = $this->fetchCourses();
        return $courses->toArray();
    }

    protected function getTableColumns(): array
    {
        return [
            TextColumn::make('id')->label('ID'),
            TextColumn::make('name')->label('Course Name'),
        ];
    }

    protected function getTableActions(): array
    {
        return [
            Action::make('view')
                ->label('View')
                ->icon('heroicon-o-eye')
                ->color('gray')
                ->url(fn ($record) => route('filament.resources.languages.courses.lessons', [
                    'languageId' => $this->languageId,
                    'courseId' => $record['id'],
                ]))
                ->openUrlInNewTab(false),

            Action::make('edit')
                ->label('Edit')
                ->icon('heroicon-o-pencil')
                ->form([
                    TextInput::make('name')->label('Course Name')->required()->maxLength(255),
                ])
                ->action(function (array $data, $record) {
                    $this->updateCourse($record['id'], $data);
                })
                ->requiresConfirmation()
                ->color('primary'),

            Action::make('delete')
                ->label('Delete')
                ->icon('heroicon-o-trash')
                ->action(fn($record) => $this->deleteCourse($record))
                ->requiresConfirmation()
                ->color('danger'),
        ];
    }

    protected function getTableHeaderActions(): array
    {
        return [
            Action::make('create')
                ->label('New Course')
                ->icon('heroicon-o-plus-circle')
                ->color('success')
                ->form([
                    TextInput::make('name')
                        ->label('Course Name')
                        ->required()
                        ->maxLength(255),
                ])
                ->action(function (array $data) {
                    $this->createCourse($data);
                }),
        ];
    }

    private function fetchCourses(): Collection
    {
        if ($this->languageId <= 0) {
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

            return collect($selectedLanguage['courses'])
                ->filter(fn($course) => str_contains(strtolower($course['name'] ?? ''), strtolower($this->search))) // Tìm kiếm theo tên khóa học
                ->sortBy('id');
        } catch (\Exception $e) {
            session()->flash('error', 'Failed to fetch courses: ' . $e->getMessage());
            return collect();
        }
    }

    public function editCourse(int $courseId): void
    {
        session()->flash('message', "Edit Course: $courseId");
    }

    public function deleteCourse(array $record): void
    {
        try {
            $firebase = (new Factory)
                ->withServiceAccount(config('services.firebase.credentials'))
                ->withDatabaseUri(config('services.firebase.database_url'))
                ->createDatabase();

            $firebase->getReference("languages/{$this->languageId}/courses/{$record['id']}")->remove();
            session()->flash('message', "Course deleted successfully.");
        } catch (\Exception $e) {
            session()->flash('error', 'Failed to delete course: ' . $e->getMessage());
        }
    }

    public function createCourse(array $data): void
    {
        try {
            $firebase = (new Factory)
                ->withServiceAccount(config('services.firebase.credentials'))
                ->withDatabaseUri(config('services.firebase.database_url'))
                ->createDatabase();

            $courses = collect($firebase->getReference("languages/{$this->languageId}/courses")->getValue());

            $newCourseId = $courses->pluck('id')->max() + 1;

            $firebase->getReference("languages/{$this->languageId}/courses/{$newCourseId}")
                ->set([
                    'id' => $newCourseId,
                    'name' => $data['name'],
                ]);

            session()->flash('message', 'New course created successfully.');
        } catch (\Exception $e) {
            session()->flash('error', 'Failed to create course: ' . $e->getMessage());
        }
    }

    public function updateCourse(int $courseId, array $data): void
    {
        try {
            $firebase = (new Factory)
                ->withServiceAccount(config('services.firebase.credentials'))
                ->withDatabaseUri(config('services.firebase.database_url'))
                ->createDatabase();

            $firebase->getReference("languages/{$this->languageId}/courses/{$courseId}")->update([
                'name' => $data['name'],
            ]);
            session()->flash('message', 'Course  updated successfully.');
        } catch (\Exception $e) {
            session()->flash('error', 'Failed to update course: ' . $e->getMessage());
        }
    }

}
