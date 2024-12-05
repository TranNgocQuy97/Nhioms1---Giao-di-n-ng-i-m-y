@extends('adminlte::page')

@section('content_header')
    <h1>Add Exercise to Lesson</h1>
@stop

@section('content')
    <form method="POST" action="{{ route('languages.courses.lessons.exercises.store', [$language, $courseId, $lessonId]) }}">
        @csrf
        <div class="form-group">
            <label for="name">Exercise Name</label>
            <input type="text" class="form-control" id="name" name="name" required>
        </div>

        <div class="form-group">
            <label for="type">Exercise Type</label>
            <select class="form-control" id="type" name="type" required>
                <option value="video">Video</option>
                <option value="flashcard">Flashcard</option>
                <option value="write_correct_answer">Write correct answer</option>
                <option value="choose_correct_answer">Choose correct answer</option>
            </select>
        </div>

        <button type="submit" class="btn btn-primary">Save Exercise</button>
    </form>
@stop
