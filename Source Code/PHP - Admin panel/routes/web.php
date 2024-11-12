<?php

use Illuminate\Support\Facades\Route;
use App\Filament\Resources\LanguageResource\Pages\CoursesPage;
use App\Filament\Resources\LanguageResource\Pages\LessonsPage;
use App\Filament\Resources\LanguageResource\Pages\ExercisesPage;
use App\Filament\Resources\LanguageResource\Pages\QuestionsPage;

Route::get('/admin/languages/{languageId}/courses', CoursesPage::class)
    ->name('filament.resources.language.courses');

Route::get('/admin/courses/{courseId}/lessons', LessonsPage::class)
    ->name('filament.resources.language.lessons');

Route::get('/admin/lessons/{lessonId}/exercises', ExercisesPage::class)
    ->name('filament.resources.language.exercises');

Route::get('/admin/exercises/{exerciseId}/questions', QuestionsPage::class)
    ->name('filament.resources.language.questions');
