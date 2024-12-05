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

    <!-- Leaderboard Widget -->
    <div class="card">
        <div class="card-header">
            <h3 class="card-title">Leaderboard</h3>
        </div>
        <div class="card-body">
            <canvas id="leaderboardChart" width="400" height="200"></canvas>
        </div>
    </div>

    @push('js')
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
            // Dữ liệu cho chart
            const leaderboardData = @json($leaderboardArray);
            const labels = leaderboardData.map(item => item.name);
            const scores = leaderboardData.map(item => item.score);

            // Tạo chart
            const ctx = document.getElementById('leaderboardChart').getContext('2d');
            const leaderboardChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Score',
                        data: scores,
                        backgroundColor: 'rgba(54, 162, 235, 0.2)',
                        borderColor: 'rgba(54, 162, 235, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        </script>
    @endpush
@stop
