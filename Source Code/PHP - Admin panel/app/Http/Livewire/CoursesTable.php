<?php

namespace App\Http\Livewire;

use Livewire\Component;

class CoursesTable extends Component
{
    public $languageId;
    public $courses = [];

    public function mount($languageId)
    {
        $this->languageId = $languageId;
        $this->courses = $this->fetchCourses($languageId);
    }

    public function fetchCourses($languageId)
    {
        $firebase = (new Factory)
            ->withServiceAccount(config('services.firebase.credentials'))
            ->withDatabaseUri(config('services.firebase.database_url'))
            ->createDatabase();

        $courses = $firebase->getReference("languages/{$languageId}/courses")->getValue();
        return collect($courses);
    }

    public function render()
    {
        return view('livewire.courses-table');
    }
}
