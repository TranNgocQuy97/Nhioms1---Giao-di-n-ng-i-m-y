<?php

namespace App\Filament\Resources\LanguageResource\Pages;

use Filament\Resources\Pages\Page;
use App\Filament\Resources\LanguageResource; 
use Illuminate\Support\Str;
use Kreait\Firebase\Factory;

class CreateCourse extends Page
{
    protected static string $resource = LanguageResource::class; 

    protected static string $view = 'filament.pages.create-course';

    public int $languageId;
    public string $courseName = '';

    public function mount(int $languageId): void
    {
        $this->languageId = $languageId;
    }

    public function save(): void
    {
        $firebase = (new Factory)
            ->withServiceAccount(config('services.firebase.credentials'))
            ->withDatabaseUri(config('services.firebase.database_url'))
            ->createDatabase();

        $courses = $firebase
            ->getReference("languages/{$this->languageId}/courses")
            ->getValue();

        $maxId = $courses ? max(array_keys($courses)) : -1;
        $newCourseId = $maxId + 1;

        $firebase->getReference("languages/{$this->languageId}/courses/{$newCourseId}")
            ->set([
                'id' => $newCourseId,
                'name' => $this->courseName,
            ]);

        session()->flash('message', 'Course created successfully.');
        redirect()->route('filament.resources.languages.view', ['record' => $this->languageId]);
    }
}
