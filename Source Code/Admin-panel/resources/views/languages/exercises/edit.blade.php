@extends('adminlte::page')

@section('content_header')
    <h1>Edit Exercise</h1>
@stop

@section('content')
    <form method="POST" action="{{ route('languages.courses.lessons.exercises.update', [$language, $courseId, $lessonId, $exerciseId]) }}">
        @csrf
        @method('PUT')

        <div class="form-group">
            <label for="name">Exercise Name</label>
            <input type="text" class="form-control" id="name" name="name" value="{{ $exercise['name'] }}" required>
        </div>

        <div class="form-group">
            <label for="type">Exercise Type</label>
            <select class="form-control" id="type" name="type" required>
                <option value="video" {{ $exercise['type'] == 'video' ? 'selected' : '' }}>Video</option>
                <option value="flashcard" {{ $exercise['type'] == 'flashcard' ? 'selected' : '' }}>Flashcard</option>
                <option value="write_correct_answer" {{ $exercise['type'] == 'write_correct_answer' ? 'selected' : '' }}>Write correct answer</option>
                <option value="choose_correct_answer" {{ $exercise['type'] == 'choose_correct_answer' ? 'selected' : '' }}>Choose correct answer</option>
            </select>
        </div>

        <button type="submit" class="btn btn-primary">Update Exercise</button>
    </form>
@stop
