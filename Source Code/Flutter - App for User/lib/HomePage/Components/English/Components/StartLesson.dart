import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class StartCourse extends StatefulWidget {
  final int isPressedCourse;

  const StartCourse({super.key, required this.isPressedCourse});

  @override
  State<StartCourse> createState() => _StartCourseState();
}

class _StartCourseState extends State<StartCourse> {
  late YoutubePlayerController _controller;
  String videoUrl = "https://www.youtube.com/watch?v=URALwXz7q8k&list=PL5q2T2FxzK7W1ynSrFh9E8eKQvdwTgXbm";

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(videoUrl) ?? 'default_id',
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.play_arrow),
                onPressed: () {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    _controller.play();
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.stop),
                onPressed: () {
                  _controller.pause();
                  _controller.seekTo(const Duration(seconds: 0));
                },
              ),
              IconButton(
                icon: Icon(Icons.fast_forward),
                onPressed: () {
                  if (_controller.value.isReady) {
                    final currentPosition = _controller.value.position;
                    final totalDuration = _controller.metadata.duration;
                    final newPosition = currentPosition + const Duration(seconds: 10);
                    if (newPosition < totalDuration) {
                      _controller.seekTo(newPosition);
                    } else {
                      _controller.seekTo(totalDuration);
                    }
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.replay_10),
                onPressed: () {
                  if (_controller.value.isReady) {
                    final currentPosition = _controller.value.position;
                    final newPosition = currentPosition - const Duration(seconds: 10);
                    if (newPosition > Duration.zero) {
                      _controller.seekTo(newPosition);
                    } else {
                      _controller.seekTo(Duration.zero);
                    }
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
