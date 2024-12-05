import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../FirebaseRealTimeDataBase/FirebaseRealTimeDataBase.dart';

class Flashcard extends StatefulWidget {
  final int isPressedCourse;
  final int isPressedLessons;
  const Flashcard({super.key, required this.isPressedCourse, required this.isPressedLessons});

  @override
  State<Flashcard> createState() => _FlashcardState();
}

class _FlashcardState extends State<Flashcard> {
  List<String> AuList = [];
  List<String> WList = [];
  int? numAu;
  final AudioPlayer audioPlayer = AudioPlayer();
  double currentPosition = 0.0;
  double totalDuration = 0.0;


  void loadLessTypes(int isPressedCourse, isPressedLesson) async {
    List<String> AuLi = await FireBaseRealTimeDataBase.fetchCourse(
        "languages/0/courses/$isPressedCourse/lessons/$isPressedLesson/exercises/1/questions", "audio_url");
    List<String> wList = await FireBaseRealTimeDataBase.fetchCourse(
        "languages/0/courses/$isPressedCourse/lessons/$isPressedLesson/exercises/1/questions", "name");
    setState(() {
      AuList = AuLi;
      WList = wList;
      numAu = AuList.length;
    });
  }

  @override
  void initState() {
    super.initState();
    loadLessTypes(widget.isPressedCourse, widget.isPressedLessons);
    audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        totalDuration = duration.inMilliseconds.toDouble();
      });
    });
    audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        currentPosition = position.inMilliseconds.toDouble();
      });
    });
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
                "Listen",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Container(
            height: 542,
            child: ListView.builder(
              itemCount: numAu ?? 0,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    await audioPlayer.play(UrlSource(AuList[index]));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 7),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 7),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color.fromRGBO(10, 20, 39, 1),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment:MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Word: ${WList[index]}",
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ],
                        ),

                        Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 30,
                        ),
                        Slider(
                          value: currentPosition,
                          min: 0.0,
                          max: totalDuration,
                          onChanged: (value) {
                            audioPlayer.seek(Duration(milliseconds: value.toInt()));
                            setState(() {
                              currentPosition = value;
                            });
                          },
                          activeColor: Colors.blue,
                          inactiveColor: Colors.blue.withOpacity(0.3),
                        ),
                        Text(
                          "${formatTime(Duration(milliseconds: currentPosition.toInt()))} / ${formatTime(Duration(milliseconds: totalDuration.toInt()))}",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                );
              },
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

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
