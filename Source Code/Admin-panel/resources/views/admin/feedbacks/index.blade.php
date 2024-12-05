@extends('adminlte::page')

@section('content_header')
    <h1>Feedbacks</h1>
@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h3 class="card-title">List of Feedbacks</h3>
        </div>
        <div class="card-body">
            @if(session('success'))
                <div class="alert alert-success">
                    {{ session('success') }}
                </div>
            @endif
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Status</th>
                        <th>Message</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($feedbacks as $feedback)
                        <tr>
                            <td>{{ $feedback['name'] }}</td>
                            <td>{{ ucfirst($feedback['status']) }}</td>
                            <td>{{ $feedback['message'] }}</td>
                            <td>
                                @if($feedback['status'] == 'pending')
                                    <button class="btn btn-primary" data-toggle="modal" data-target="#answerModal-{{ $feedback['key'] }}">Answer</button>
                                @else
                                    <span class="badge badge-success">Resolved</span>
                                @endif
                            </td>
                        </tr>

                        <!-- Modal to answer feedback -->
                        <div class="modal fade" id="answerModal-{{ $feedback['key'] }}" tabindex="-1" role="dialog" aria-labelledby="answerModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="answerModalLabel">Answer Feedback</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <form action="{{ route('feedback.answer', $feedback['key']) }}" method="POST">
                                            @csrf
                                            <div class="form-group">
                                                <label for="answer">Your Answer:</label>
                                                <textarea class="form-control" name="answer" rows="4" required></textarea>
                                            </div>
                                            <button type="submit" class="btn btn-success">Submit Answer</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    @endforeach
                </tbody>
            </table>
        </div>
    </div>
@stop
