@extends('adminlte::page')

@section('content_header')
    <h1>{{ $lesson['name'] }}</h1>
@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <a href="{{ route('languages.courses.lessons.index', ['language' => $language, 'courseId' => $courseId]) }}" class="btn btn-secondary float-right">Back</a>
            <a href="{{ route('languages.courses.lessons.exercises.create', [$language, $courseId, $lessonId]) }}" class="btn btn-success mb-3">Add Exercise</a>
        </div>
        <div class="card-body">
            <table class="table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Type</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach($exercises as $exercise)
                        <tr id="exercise-{{ $exercise['id'] }}">
                            <td>{{ $exercise['id'] }}</td>
                            <td>{{ $exercise['name'] }}</td>
                            <td>{{ ucwords(str_replace('_', ' ', $exercise['type'])) }}</td>
                            <td>
                                <a href="{{ route('languages.courses.lessons.exercises.questions.index', [$language, $courseId, $lessonId, $exercise['id']]) }}" class="btn btn-info btn-sm">View</a>
                                <a href="{{ route('languages.courses.lessons.exercises.edit', [$language, $courseId, $lessonId, $exercise['id']]) }}" class="btn btn-warning btn-sm">Edit</a>
                                <form action="{{ route('languages.courses.lessons.exercises.destroy', [$language, $courseId, $lessonId, $exercise['id']]) }}" method="POST" style="display:inline;" onsubmit="return confirm('Are you sure?');">
                                    @csrf
                                    @method('DELETE')
                                    <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                </form>
                            </td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        </div>
    </div>
@stop
