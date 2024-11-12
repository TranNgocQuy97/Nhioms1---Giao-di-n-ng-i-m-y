<?php

namespace App\Filament\Resources\LanguageResource\Pages;

use App\Filament\Resources\LanguageResource;
use Filament\Pages\Page;
use Kreait\Firebase\Factory;
use Kreait\Firebase\ServiceAccount;
use Illuminate\Support\Collection;

class CoursesPage extends Page 
{
    protected static ?string $navigationIcon = 'heroicon-o-book-open';
    protected static string $view = 'filament.pages.courses-page';

    public $languageId;
    public $courses = [];

    public function mount($languageId)
    {
        $this->languageId = $languageId;
        $this->languageName = $this->fetchLanguageName($languageId);
        $this->courses = $this->fetchCourses($languageId);
    }

    protected function fetchCourses($languageId)
    {
        $firebase = (new Factory)
            ->withServiceAccount(config('services.firebase.credentials'))
            ->withDatabaseUri(config('services.firebase.database_url'))
            ->createDatabase();

        $courses = $firebase->getReference("languages/{$languageId}/courses")->getValue();

        return collect($courses);
    }

    protected function fetchLanguageName($languageId)
    {
        $firebase = (new Factory)
            ->withServiceAccount(config('services.firebase.credentials'))
            ->withDatabaseUri(config('services.firebase.database_url'))
            ->createDatabase();

        $language = $firebase->getReference("languages/{$languageId}")->getValue();

        return $language['name'] ?? 'Unknown Language';
    }

    public function createCourse()
    {
        $firebase = $this->initializeFirebase();
        $courseId = $firebase->getReference("languages/{$this->languageId}/courses")->push()->getKey();

        $firebase->getReference("languages/{$this->languageId}/courses/{$courseId}")
                 ->set(['name' => $this->newCourseName]);

        $this->courses = $this->fetchCourses($this->languageId); 
        $this->newCourseName = ''; 
    }

    public function editCourse($courseId, $newName)
    {
        $firebase = $this->initializeFirebase();

        $firebase->getReference("languages/{$this->languageId}/courses/{$courseId}")
                 ->update(['name' => $newName]);

        $this->courses = $this->fetchCourses($this->languageId); 
    }

    public function deleteCourse($courseId)
    {
        $firebase = $this->initializeFirebase();

        $firebase->getReference("languages/{$this->languageId}/courses/{$courseId}")->remove();

        $this->courses = $this->fetchCourses($this->languageId); 
    }

    private function initializeFirebase()
    {
        return (new Factory)
            ->withServiceAccount(config('services.firebase.credentials'))
            ->withDatabaseUri(config('services.firebase.database_url'))
            ->createDatabase();
    }
}
