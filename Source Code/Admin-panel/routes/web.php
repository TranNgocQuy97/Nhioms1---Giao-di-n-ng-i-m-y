<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\FirebaseConnectionController;
use App\Http\Controllers\FirebaseLanguageController;
use App\Http\Controllers\HomeController;
use App\Http\Controllers\FirebaseLessonController;
use App\Http\Controllers\ProgressController;
use App\Http\Controllers\FeedbackController;


/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Auth::routes();

Route::middleware(['auth'])->group(function () {
    Route::get('/home', [HomeController::class, 'index'])->name('home');
    Route::get('/admin', function () {
        return view('admin.dashboard');
    });
});

// Users Routes
Route::prefix('admin')->group(function () {
    Route::resource('users', FirebaseConnectionController::class)->names([
        'index' => 'admin.users.index',
        'create' => 'admin.users.create',
        'store' => 'admin.users.store',
        'show' => 'admin.users.show',
        'edit' => 'admin.users.edit',
        'update' => 'admin.users.update',
        'destroy' => 'admin.users.destroy',
    ]);   
});

// Courses Routes
Route::prefix('languages/{language}')->group(function () {
    Route::get('/', [FirebaseLanguageController::class, 'index'])->name('languages.courses.index');
    Route::get('/create', [FirebaseLanguageController::class, 'create'])->name('languages.courses.create');
    Route::post('/courses', [FirebaseLanguageController::class, 'store'])->name('languages.courses.store'); 
    Route::get('/edit/{courseId}', [FirebaseLanguageController::class, 'edit'])->name('languages.courses.edit');
    Route::put('/update/{courseId}', [FirebaseLanguageController::class, 'update'])->name('languages.courses.update');
    Route::delete('/destroy/{courseId}', [FirebaseLanguageController::class, 'destroy'])->name('languages.courses.destroy');
});

// Lessons Routes
Route::prefix('languages/{language}/courses/{courseId}/lessons')->group(function () {
    Route::get('/', [FirebaseLanguageController::class, 'showLessons'])->name('languages.courses.lessons.index');
    Route::get('/create', [FirebaseLanguageController::class, 'createLesson'])->name('languages.courses.lessons.create');
    Route::post('/store', [FirebaseLanguageController::class, 'storeLesson'])->name('languages.courses.lessons.store');
    Route::get('/{lessonId}/edit', [FirebaseLanguageController::class, 'editLesson'])->name('languages.courses.lessons.edit');
    Route::put('/{lessonId}', [FirebaseLanguageController::class, 'updateLesson'])->name('languages.courses.lessons.update');
    Route::delete('/{lessonId}', [FirebaseLanguageController::class, 'destroyLesson'])->name('languages.courses.lessons.destroy');
});

// Exercises Routes
Route::prefix('languages/{language}/courses/{courseId}/lessons/{lessonId}/exercises')
    ->group(function () {
        Route::get('/', [FirebaseLanguageController::class, 'showExercises'])->name('languages.courses.lessons.exercises.index');
        Route::get('/create', [FirebaseLanguageController::class, 'createExercise'])->name('languages.courses.lessons.exercises.create');
        Route::post('/', [FirebaseLanguageController::class, 'storeExercise'])->name('languages.courses.lessons.exercises.store');
        Route::get('/{exerciseId}/edit', [FirebaseLanguageController::class, 'editExercise'])->name('languages.courses.lessons.exercises.edit');
        Route::put('/{exerciseId}', [FirebaseLanguageController::class, 'updateExercise'])->name('languages.courses.lessons.exercises.update');
        Route::delete('/{exerciseId}', [FirebaseLanguageController::class, 'destroyExercise'])->name('languages.courses.lessons.exercises.destroy');
    });

// Questions Routes
Route::prefix('languages/{language}/courses/{courseId}/lessons/{lessonId}/exercises/{exerciseId}/questions')
    ->group(function () {
        Route::get('/', [FirebaseLanguageController::class, 'showQuestions'])->name('languages.courses.lessons.exercises.questions.index');
        Route::get('/create', [FirebaseLanguageController::class, 'createQuestion'])->name('languages.courses.lessons.exercises.questions.create');
        Route::post('/', [FirebaseLanguageController::class, 'storeQuestion'])->name('languages.courses.lessons.exercises.questions.store');
        Route::get('/{questionId}/edit', [FirebaseLanguageController::class, 'editQuestion'])->name('languages.courses.lessons.exercises.questions.edit');
        Route::put('/{questionId}', [FirebaseLanguageController::class, 'updateQuestion'])->name('languages.courses.lessons.exercises.questions.update');
        Route::delete('/{questionId}', [FirebaseLanguageController::class, 'destroyQuestion'])->name('languages.courses.lessons.exercises.questions.destroy');
    });

Route::get('languages/{language}/courses/{courseId}/lessons/{lessonId}/exercises/{exerciseId}/questions/{questionId}/view', [FirebaseLanguageController::class, 'showQuestionDetails'])->name('languages.courses.lessons.exercises.questions.view');

Route::get('admin/progress', [ProgressController::class, 'index'])->name('admin.progress');

Route::prefix('admin')->group(function () {
    Route::get('feedback', [FeedbackController::class, 'index'])->name('feedback.index');
    Route::post('feedback/{key}/answer', [FeedbackController::class, 'answer'])->name('feedback.answer');
});
