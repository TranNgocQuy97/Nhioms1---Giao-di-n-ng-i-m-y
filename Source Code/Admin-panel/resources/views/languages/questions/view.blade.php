@extends('adminlte::page')

@section('content_header')
    <h1>Question Details</h1>
@stop

@section('content')
    <div class="card">
        <div class="card-body">
            <table class="table">
                <thead>
                    <tr>
                        <th>Field</th>
                        <th>Details</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Name</td>
                        <td>{{ $question['name'] }}</td>
                    </tr>

                    @if($exerciseType == 'Video')
                        <tr>
                            <td>Video</td>
                            <td>
                                @if(!empty($question['video_url']))
                                    <iframe src="{{ $question['video_url'] }}" frameborder="0" allow="autoplay; fullscreen" style="width:100%; height:300px;"></iframe>
                                @else
                                    No video uploaded.
                                @endif
                            </td>
                        </tr>
                    @endif

                    @if(in_array($exerciseType, ['Flashcard', 'Write correct answer', 'Choose correct answer']))
                        <tr>
                            <td>Audio</td>
                            <td>
                                @if(!empty($question['audio_url']))
                                    <audio controls>
                                        <source src="{{ $question['audio_url'] }}" type="audio/mpeg">
                                        Your browser does not support the audio element.
                                    </audio>
                                @else
                                    No audio uploaded.
                                @endif
                            </td>
                        </tr>
                    @endif

                    @if($exerciseType == 'Write correct answer' || $exerciseType == 'Choose correct answer')
                        <tr>
                            <td>Correct Answer</td>
                            <td>{{ $question['correct_answer'] }}</td>
                        </tr>
                    @endif

                    @if($exerciseType == 'Choose correct answer')
                        <tr>
                            <td>Options</td>
                            <td>
                                @foreach($question['options'] as $option)
                                    <p>{{ $option }}</p>
                                @endforeach
                            </td>
                        </tr>
                    @endif
                </tbody>
            </table>
        </div>
        <div class="card-footer text-left">
            <a href="{{ route('languages.courses.lessons.exercises.questions.index', [$language, $courseId, $lessonId, $exerciseId]) }}" class="btn btn-secondary">Back</a>
            <a href="{{ route('languages.courses.lessons.exercises.questions.edit', [$language, $courseId, $lessonId, $exerciseId, $question['id']]) }}" class="btn btn-warning">Edit</a>
            <form action="{{ route('languages.courses.lessons.exercises.questions.destroy', [$language, $courseId, $lessonId, $exerciseId, $question['id']]) }}" method="POST" style="display:inline;" onsubmit="return confirm('Are you sure?');">
                @csrf
                @method('DELETE')
                <button type="submit" class="btn btn-danger">Delete</button>
            </form>
        </div>
    </div>
@stop
