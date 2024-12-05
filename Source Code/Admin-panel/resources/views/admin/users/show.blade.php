@extends('adminlte::page')

@section('title', 'User Details')

@section('content_header')
    <h1>User Details</h1>
@endsection

@section('content')
    <div class="card">
        <div class="card-body">
            <p><strong>Name:</strong> {{ $user['name'] ?? 'N/A' }}</p>
            <p><strong>Email:</strong> {{ $user['email'] ?? 'N/A' }}</p>
            <p><strong>Phone Number:</strong> {{ $user['phoneNumber'] ?? 'N/A' }}</p>
            <a href="{{ route('admin.users.index') }}" class="btn btn-secondary">Back to Users</a>
        </div>
    </div>
@endsection
