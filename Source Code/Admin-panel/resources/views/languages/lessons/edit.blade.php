@extends('adminlte::page')

@section('content')
    <h1>Edit Lesson</h1>
    <form action="{{ route('languages.courses.lessons.update', [$language, $courseId, $lessonId]) }}" method="POST">
        @csrf
        @method('PUT')
        <div class="form-group">
            <label for="name">Lesson Name</label>
            <input type="text" name="name" value="{{ $lesson['name'] }}" class="form-control" required>
        </div>
        <div class="form-group">
            <label for="level">Level</label>
            <select name="level" class="form-control">
                <option value="1" {{ $lesson['level'] == 1 ? 'selected' : '' }}>Easy</option>
                <option value="2" {{ $lesson['level'] == 2 ? 'selected' : '' }}>Medium</option>
                <option value="3" {{ $lesson['level'] == 3 ? 'selected' : '' }}>Hard</option>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">Update</button>
    </form>
@endsection
