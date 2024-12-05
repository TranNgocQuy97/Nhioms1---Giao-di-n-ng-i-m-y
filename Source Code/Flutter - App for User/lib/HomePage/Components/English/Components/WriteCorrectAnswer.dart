import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../../FirebaseRealTimeDataBase/FirebaseRealTimeDataBase.dart';

class WriteCorrectAnswer extends StatefulWidget {
  final int isPressedCourse;
  final int isPressedLessons;
  const WriteCorrectAnswer({super.key, required this.isPressedCourse, required this.isPressedLessons});
  @override
  _WriteCorrectAnswerState createState() => _WriteCorrectAnswerState();
}

class _WriteCorrectAnswerState extends State<WriteCorrectAnswer> {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  double currentPosition = 0.0;
  double maxDuration = 0.0;
  List<String> AudiosString = [];
  List<int> idList = [];
  List<String> QuesList = [];
  List<String> CorrectAnswerList = [];
  int? numAudio;
  void loadAudio(int isPressedCourse, isPressedLesson) async {
    List<String> Audios = await FireBaseRealTimeDataBase.fetchCourse(
        "languages/0/courses/$isPressedCourse/lessons/$isPressedLesson/exercises/3/questions", "audio_url");
    List<String> CrAW = await FireBaseRealTimeDataBase.fetchCourse(
        "languages/0/courses/$isPressedCourse/lessons/$isPressedLesson/exercises/3/questions", "correct_answer");
    List<String> Ques = await FireBaseRealTimeDataBase.fetchCourse(
        "languages/0/courses/$isPressedCourse/lessons/$isPressedLesson/exercises/3/questions", "name");
    List<int> ids = await FireBaseRealTimeDataBase.getList(
        "languages/0/courses/$isPressedCourse/lessons/$isPressedLesson/exercises/3/questions", "id");
    setState(() {
      AudiosString = Audios;
      QuesList = Ques;
      CorrectAnswerList = CrAW;
      idList = ids;
      numAudio = AudiosString.length;
    });
  }

  @override
  void initState() {
    super.initState();
    loadAudio(widget.isPressedCourse,widget.isPressedLessons);
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
    audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        currentPosition = position.inMilliseconds.toDouble();
      });
    });
    audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        maxDuration = duration.inMilliseconds.toDouble();
      });
    });
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Container(
            height: 60,
            child: Center(
              child: Text(
                "Write Correct Answer",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Container(
            height: 542,
            child: ListView(
              padding: EdgeInsets.all(0),
               children: List.generate(
                numAudio ?? 0,
                    (index) => Container(
                  margin: EdgeInsets.symmetric(vertical: 7),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(10, 20, 39, 1),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Name: ",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            "${idList[index]} ",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Audio:",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              if (isPlaying) {
                                audioPlayer.pause();
                              } else {
                                audioPlayer.play(UrlSource(AudiosString[index]));
                              }
                            },
                            child: Icon(
                              isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          Expanded(
                            child: Slider(
                              value: currentPosition,
                              max: maxDuration,
                              onChanged: (value) {
                                audioPlayer.seek(Duration(milliseconds: value.round()));
                              },
                              activeColor: Colors.blue,
                              inactiveColor: Colors.blue.withOpacity(0.3),
                            ),
                          ),
                          Text(
                            "${formatTime(Duration(milliseconds: currentPosition.toInt()))} / ${formatTime(Duration(milliseconds: maxDuration.toInt()))}",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                      Text(
                        "Question: ${QuesList[index]} ",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}
