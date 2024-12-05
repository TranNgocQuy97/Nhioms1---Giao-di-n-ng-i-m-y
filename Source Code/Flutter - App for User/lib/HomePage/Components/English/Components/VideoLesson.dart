import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class VideoLesson extends StatefulWidget {
  final String videoString;
  const VideoLesson({super.key, required this.videoString});
  @override
  State<VideoLesson> createState() => _VideoLessonState();
}

class _VideoLessonState extends State<VideoLesson> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.videoString) ?? 'https://www.youtube.com/watch?v=URALwXz7q8k&list=PL5q2T2FxzK7W1ynSrFh9E8eKQvdwTgXbm',
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
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "GETTING STARTTED",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
            ),
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

