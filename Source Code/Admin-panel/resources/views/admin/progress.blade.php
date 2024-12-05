@extends('adminlte::page')

@section('title', 'Progress Dashboard')

@section('content_header')
    <h1>Progress Dashboard</h1>
@stop

@section('content')
    <div class="row">
        <!-- Users Widget -->
        <div class="col-lg-3 col-6">
            <div class="small-box bg-success">
                <div class="inner">
                    <h3>{{ $userCount }}</h3>
                    <p>Total Users</p>
                </div>
                <div class="icon">
                    <i class="fas fa-users"></i>
                </div>
            </div>
        </div>

        <!-- Feedbacks Widget -->
        <div class="col-lg-3 col-6">
            <div class="small-box bg-danger">
                <div class="inner">
                    <h3>{{ $feedbackCount }}</h3>
                    <p>Total Feedbacks</p>
                </div>
                <div class="icon">
                    <i class="fas fa-comments"></i>
                </div>
            </div>
        </div>

        <!-- Courses Widget -->
        <div class="col-lg-3 col-6">
            <div class="small-box bg-info">
                <div class="inner">
                    <h3>{{ $courseCount }}</h3>
                    <p>Total Courses</p>
                </div>
                <div class="icon">
                    <i class="fas fa-book"></i>
                </div>
            </div>
        </div>

        <!-- Lessons Widget -->
        <div class="col-lg-3 col-6">
            <div class="small-box bg-warning">
                <div class="inner">
                    <h3>{{ $lessonCount }}</h3>
                    <p>Total Lessons</p>
                </div>
                <div class="icon">
                    <i class="fas fa-chalkboard-teacher"></i>
                </div>
            </div>
        </div>
    </div>

    <!-- Leaderboard Table -->
    <div class="card">
        <div class="card-header">
            <h3 class="card-title">Ranking</h3>
        </div>
        <div class="card-body">
            <table id="leaderboardTable" class="table table-bordered table-hover">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Score</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($leaderboardArray as $index => $leader)
                        <tr>
                            <td>
                                {{ $leader['name'] }}
                                @if($index === 0)
                                    <i class="fas fa-gem text-primary ml-2" title="Top Scorer"></i>
                                @endif
                            </td>
                            <td>{{ $leader['score'] }}</td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        </div>
    </div>
@stop

@push('js')
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap4.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#leaderboardTable').DataTable({
                "order": [[1, "desc"]], 
                "paging": true,
                "searching": false,
                "info": false
            });
        });
    </script>
@endpush

@push('css')
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap4.min.css">
@endpush
