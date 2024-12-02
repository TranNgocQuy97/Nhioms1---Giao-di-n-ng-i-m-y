<?php

use Illuminate\Support\Facades\Route;
use App\Filament\Resources\LanguageResource\Widgets\LessonsWidget;
use App\Filament\Resources\LessonResource\Widgets\ExercisesWidget;
use App\Filament\Resources\LessonResource\Widgets\QuestionsWidget;
use App\Filament\Resources\LessonResource\Widgets\AnswersWidget;

Route::get('admin/languages/{languageId}/courses/{courseId}/lessons', LessonsWidget::class)
    ->name('filament.resources.languages.courses.lessons');


Route::get('admin/languages/{languageId}/courses/{courseId}/lessons/{lessonId}/exercises', ExercisesWidget::class)
    ->name('filament.resources.languages.courses.lessons.exercises');

Route::get('admin/languages/{languageId}/courses/{courseId}/lessons/{lessonId}/exercises/{exerciseId}/questions', QuestionsWidget::class)
    ->name('filament.resources.languages.courses.lessons.exercises.questions');
    
    Route::get('admin/languages/{languageId}/courses/{courseId}/lessons/{lessonId}/exercises/{exerciseId}/questions/{questionId}/answers', AnswersWidget::class)
    ->name('filament.resources.languages.courses.lessons.exercises.questions.answers');
    