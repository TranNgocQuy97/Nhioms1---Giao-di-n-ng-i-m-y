<?php

namespace App\Filament\Resources\LanguageResource\Pages;

use Filament\Resources\Pages\Page;
use App\Filament\Resources\LanguageResource; 
use Kreait\Firebase\Factory;

class EditCourse extends Page
{
    protected static string $resource = LanguageResource::class; 

    protected static string $view = 'filament.pages.edit-course';

    public int $languageId;
    public string $courseId;
    public string $courseName = '';

    public function mount(int $languageId, string $courseId): void
    {
        $this->languageId = $languageId;
        $this->courseId = $courseId;

        $firebase = (new Factory)
            ->withServiceAccount(config('services.firebase.credentials'))
            ->withDatabaseUri(config('services.firebase.database_url'))
            ->createDatabase();

        $course = $firebase
            ->getReference("languages/{$this->languageId}/courses/{$this->courseId}")
            ->getValue();

        $this->courseName = $course['name'] ?? '';
    }

    public function save(): void
    {
        $firebase = (new Factory)
            ->withServiceAccount(config('services.firebase.credentials'))
            ->withDatabaseUri(config('services.firebase.database_url'))
            ->createDatabase();

        $firebase->getReference("languages/{$this->languageId}/courses/{$this->courseId}")
            ->update(['name' => $this->courseName]);

        session()->flash('message', 'Course updated successfully.');
        redirect()->route('filament.resources.languages.view', ['record' => $this->languageId]);
    }
}
