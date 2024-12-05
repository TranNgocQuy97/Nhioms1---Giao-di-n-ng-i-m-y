@extends('adminlte::page')

@section('content_header')
    <h1>Exercise: {{ $exerciseId }}</h1>
@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <a href="{{ route('languages.courses.lessons.exercises.index', [$language, $courseId, $lessonId]) }}" class="btn btn-secondary float-right">Back</a>
            <a href="{{ route('languages.courses.lessons.exercises.questions.create', [$language, $courseId, $lessonId, $exerciseId]) }}" class="btn btn-success mb-3">Add Question</a>
        </div>
        <div class="card-body">
            <table class="table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach($questions as $question)
                        <tr>
                            <td>{{ $question['id'] }}</td>
                            <td>{{ $question['name'] }}</td>
                            <td>
                                <a href="{{ route('languages.courses.lessons.exercises.questions.view', [$language, $courseId, $lessonId, $exerciseId, $question['id']]) }}" class="btn btn-info btn-sm">View</a>
                                <a href="{{ route('languages.courses.lessons.exercises.questions.edit', [$language, $courseId, $lessonId, $exerciseId, $question['id']]) }}" class="btn btn-warning btn-sm">Edit</a>
                                <form action="{{ route('languages.courses.lessons.exercises.questions.destroy', [$language, $courseId, $lessonId, $exerciseId, $question['id']]) }}" method="POST" style="display:inline;" onsubmit="return confirm('Are you sure?');">
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
