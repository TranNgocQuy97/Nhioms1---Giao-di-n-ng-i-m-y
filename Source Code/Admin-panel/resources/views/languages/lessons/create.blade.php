@extends('adminlte::page')

@section('content')
    <h1>Add Lesson</h1>
    <form action="{{ route('languages.courses.lessons.store', [$language, $courseId]) }}" method="POST">
        @csrf
        <div class="form-group">
            <label for="name">Lesson Name</label>
            <input type="text" name="name" class="form-control" required>
        </div>
        <div class="form-group">
            <label for="level">Level</label>
            <select name="level" class="form-control">
                <option value="1">Easy</option>
                <option value="2">Medium</option>
                <option value="3">Hard</option>
            </select>
        </div>
        <button type="submit" class="btn btn-success">Add</button>
    </form>
@endsection
