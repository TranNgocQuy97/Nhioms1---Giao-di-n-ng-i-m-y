@extends('adminlte::page')

@section('title', 'User Details')

@section('content_header')
    <h1>User Details</h1>
@endsection

@section('content')
    <div class="card">
        <div class="card-header">
            <a href="{{ route('admin.users.index') }}" class="btn btn-secondary float-right">Back to Users</a>
        </div>
        <div class="card-body">
            <p><strong>Name:</strong> {{ $user['name'] ?? 'N/A' }}</p>
            <p><strong>Email:</strong> {{ $user['email'] ?? 'N/A' }}</p>
            <p><strong>Phone Number:</strong> {{ $user['phoneNumber'] ?? 'N/A' }}</p>
        </div>
    </div>

    <!-- Card for Course Access History -->
    <div class="card">
        <div class="card-header">
            <h3 class="card-title">Course Access History</h3>
        </div>
        <div class="card-body">
            @if(isset($user['courseStart']) && is_array($user['courseStart']))
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Language</th>
                            <th>Timestamp</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach($user['courseStart'] as $course)
                            <tr>
                                <td>{{ $course['language'] ?? 'N/A' }}</td>
                                <td>{{ isset($course['timestamp']) ? \Carbon\Carbon::createFromTimestamp($course['timestamp'])->format('Y-m-d H:i:s') : 'N/A' }}</td>
                            </tr>
                        @endforeach
                    </tbody>
                </table>
            @else
                <p>No course access history available.</p>
            @endif
        </div>
    </div>
@endsection
