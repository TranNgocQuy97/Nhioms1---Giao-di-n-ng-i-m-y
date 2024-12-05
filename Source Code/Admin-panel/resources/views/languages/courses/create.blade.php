@extends('adminlte::page')

@section('title', 'Add Course')

@section('content_header')
    <h1>Add New Course for {{ ucfirst($language) }}</h1>
@endsection

@section('content')
    <form action="{{ route('languages.courses.store', $language) }}" method="POST">
        @csrf
        <div class="form-group">
            <label for="name">Course Name:</label>
            <input type="text" name="name" id="name" class="form-control" required>
        </div>
        <button type="submit" class="btn btn-success">Save</button>
    </form>
@endsection
