@extends('adminlte::page')

@section('title', 'Lessons of ' . $course['name'])

@section('content_header')
    <h1>{{ $course['name'] }}</h1>
@endsection

@section('content')
    <div class="card">
        <div class="card-header">
            <a href="{{ route('languages.courses.index', ['language' => $language]) }}" class="btn btn-secondary float-right">Back</a>
            <a href="{{ route('languages.courses.lessons.create', ['language' => $language, 'courseId' => $courseId]) }}" class="btn btn-primary mb-3">Add Lesson</a>
        </div>
        <div class="card-body">
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Level</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($lessons as $key => $lesson)
                        <tr>
                            <td>{{ $lesson['id'] }}</td>
                            <td>{{ $lesson['name'] }}</td>
                            <td>{{ $lesson['level'] == 1 ? 'Easy' : ($lesson['level'] == 2 ? 'Medium' : 'Hard') }}</td>
                            <td>
                                <a href="{{ route('languages.courses.lessons.exercises.index', ['language' => $language, 'courseId' => $courseId, 'lessonId' => $lesson['id']]) }}" class="btn btn-info">View</a>
                                <a href="{{ route('languages.courses.lessons.edit', ['language' => $language, 'courseId' => $courseId, 'lessonId' => $lesson['id']]) }}" class="btn btn-warning">Edit</a>
                                <form action="{{ route('languages.courses.lessons.destroy', ['language' => $language, 'courseId' => $courseId, 'lessonId' => $lesson['id']]) }}" method="POST" style="display:inline;">
                                    @csrf
                                    @method('DELETE')
                                    <button class="btn btn-danger" onclick="return confirm('Are you sure?')">Delete</button>
                                </form>
                            </td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        </div>
    </div>
@endsection
