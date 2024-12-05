@extends('adminlte::page')

@section('title', 'Edit Course')

@section('content_header')
    <h1>Edit Course: {{ $course['name'] }}</h1>
@endsection

@section('content')
    <form action="{{ route('languages.courses.update', [$language, $courseId]) }}" method="POST">
        @csrf
        @method('PUT')
        <div class="form-group">
            <label for="name">Course Name:</label>
            <input type="text" name="name" id="name" class="form-control" value="{{ $course['name'] }}" required>
        </div>
        <button type="submit" class="btn btn-success">Update</button>
    </form>
@endsection
