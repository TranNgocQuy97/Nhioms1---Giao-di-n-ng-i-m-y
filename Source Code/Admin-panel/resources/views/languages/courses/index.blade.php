@extends('adminlte::page')

@section('title', ucfirst(strtolower($language)) . ' Courses')

@section('content_header')
    <h1>{{ ucfirst(strtolower($language)) }} Courses</h1>
@endsection

@section('content')
    <div class="card">
        <div class="card-header">
            <a href="{{ route('languages.courses.create', $language) }}" class="btn btn-primary mb-3">Add Course</a>
        </div>
        <div class="card-body">
            <div class="row">
                @if(!empty($courses))
                    @foreach($courses as $key => $course)
                        <div class="col-md-4">
                            <div class="card">
                                <div class="card-header">
                                    <h3 class="card-title">{{ $course['name'] ?? 'No Name' }}</h3>
                                </div>
                                <div class="card-body">
                                    <p>Course ID: {{ $course['id'] ?? 'N/A' }}</p>
                                </div>
                                <div class="card-footer">
                                    <!-- View Lessons Button -->
                                    <a href="{{ route('languages.courses.lessons.index', ['language' => $language, 'courseId' => $course['id']]) }}" class="btn btn-info">View</a>
                                    <!-- Edit Button -->
                                    <a href="{{ route('languages.courses.edit', ['language' => $language, 'courseId' => $course['id']]) }}" class="btn btn-warning">Edit</a>
                                    <!-- Delete Button -->
                                    <form action="{{ route('languages.courses.destroy', [$language, $course['id']]) }}" method="POST" style="display:inline;">
                                        @csrf
                                        @method('DELETE')
                                        <button class="btn btn-danger" onclick="return confirm('Are you sure?')">Delete</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    @endforeach
                @else
                    <p>No courses available.</p>
                @endif
            </div>
        </div>
    </div>
@endsection
