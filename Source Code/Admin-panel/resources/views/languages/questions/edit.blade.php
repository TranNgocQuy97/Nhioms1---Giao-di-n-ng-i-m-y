@extends('adminlte::page')

@section('content_header')
    <h1>Edit Question</h1>
@stop

@section('content')
    <form action="{{ route('languages.courses.lessons.exercises.questions.update', [$language, $courseId, $lessonId, $exerciseId, $questionId]) }}" method="POST">
        @csrf
        @method('PUT')

        <div class="form-group">
            <label for="name">Question Name</label>
            <input type="text" class="form-control" name="name" value="{{ $question['name'] }}" required>
        </div>

        @if($exerciseType == 'Video')
            <div class="form-group">
                <label for="video_url">Video URL (Vimeo)</label>
                <input type="url" class="form-control" name="video_url" value="{{ $question['video_url'] }}" placeholder="https://vimeo.com/your-video-id" required>
            </div>
        @else
            <div class="form-group">
                <label for="audio_url">Audio URL (Google Drive)</label>
                <input type="url" class="form-control" name="audio_url" value="{{ $question['audio_url'] }}" placeholder="https://drive.google.com/your-audio-link" required>
            </div>

            @if($exerciseType == 'Choose correct answer')
                <div class="form-group">
                    <label for="options">Options (Max 4 options)</label>
                    <div class="options-wrapper">
                        @foreach($question['options'] as $key => $option)
                            <input type="text" class="form-control option" name="options[]" value="{{ $option }}" placeholder="Option {{ $key + 1 }}" required>
                        @endforeach
                    </div>
                </div>

                <div class="form-group">
                    <label for="correct_answer">Correct Answer</label>
                    <select class="form-control" name="correct_answer" required>
                        <option value="">Select Correct Answer</option>
                        <option value="1" {{ $question['correct_answer'] == '1' ? 'selected' : '' }}>Option 1</option>
                        <option value="2" {{ $question['correct_answer'] == '2' ? 'selected' : '' }}>Option 2</option>
                        <option value="3" {{ $question['correct_answer'] == '3' ? 'selected' : '' }}>Option 3</option>
                        <option value="4" {{ $question['correct_answer'] == '4' ? 'selected' : '' }}>Option 4</option>
                    </select>
                </div>
            @endif
        @endif

        <button type="submit" class="btn btn-primary">Update Question</button>
    </form>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            let optionWrapper = document.querySelector('.options-wrapper');
            let options = optionWrapper.querySelectorAll('.option');

            options.forEach((option, index) => {
                option.addEventListener('input', function() {
                    if (this.value && index === options.length - 1) {
                        if (options.length < 4) {
                            let newOption = document.createElement('input');
                            newOption.type = 'text';
                            newOption.classList.add('form-control', 'option');
                            newOption.name = 'options[]';
                            newOption.placeholder = `Option ${options.length + 1}`;
                            optionWrapper.appendChild(newOption);
                        }
                    }
                });
            });
        });
    </script>
@stop
