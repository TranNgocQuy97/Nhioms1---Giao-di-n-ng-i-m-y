import 'package:athena/HomePage/Components/English/Components/ChooseCorrectAnswer.dart';
import 'package:athena/HomePage/Components/English/Components/VideoLesson.dart';
import 'package:flutter/material.dart';
import '../../FirebaseRealTimeDataBase/FirebaseRealTimeDataBase.dart';
import 'Flashcard.dart';
import 'WriteCorrectAnswer.dart';




class StartLesson extends StatefulWidget {
  final int isPressedCourse;
  final int isPressedLessons;
  const StartLesson({super.key, required this.isPressedCourse, required this.isPressedLessons});
  @override
  State<StartLesson> createState() => _StartLesson();
}

class _StartLesson extends State<StartLesson> {
  Color topColor = Color.fromRGBO(10, 20, 39, 1);
  Color bottomColor = Colors.white;
  double share = 0.25;
  int? numType ;
  int isPressedType = 0;
  List<String> lessonTypes = [];
  void loadLessTypes(int isPressedCourse, isPressedLesson) async {
    List<String> Types = await FireBaseRealTimeDataBase.fetchCourse(
        "languages/0/courses/$isPressedCourse/lessons/$isPressedLesson/exercises", "type");
    setState(() {
      lessonTypes = Types;
      numType = lessonTypes.length;
    });
  }
  @override
  void initState() {
    super.initState();
    loadLessTypes(widget.isPressedCourse,widget.isPressedLessons);
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
            height: screenHeight,
            width: screenWidth,
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: screenHeight,
                      width: screenWidth*0.5,
                      color: bottomColor,
                    ),
                    Container(
                      height: screenHeight,
                      width: screenWidth*0.5,
                      color: topColor,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 10, 15, 15),
                      height: screenHeight*share,
                      width: screenWidth,
                      decoration: BoxDecoration(
                        color: topColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(80),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                              height: 100,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: (){
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(
                                        Icons.arrow_back_ios_rounded,
                                        size: 24,
                                        color: Colors.white,
                                      )
                                  ),
                                  Text(
                                    "Choose type",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20
                                    ),
                                  ),
                                  Container(
                                      height: 50,
                                      width: 50,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.network(
                                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjKiLTZODsQbeA9ViUROoMQ4WwMfqAbpIm1A&s",
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                  ),
                                ],
                              )
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            height: 50,
                            width: 300,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(42, 54, 99, 1),
                              borderRadius: BorderRadius.circular(13)
                            ),
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: List.generate(
                                  numType ?? 0,
                                      (index) => GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isPressedType = index;
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: isPressedType==index ? topColor : null,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Center(
                                    child: Text(
                                      lessonTypes[index],
                                      style: TextStyle(
                                        color: Colors.white
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      height: screenHeight*(1-share),
                      width: screenWidth,
                      decoration: BoxDecoration(
                        color: bottomColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(80),
                        ),
                      ),
                      child: PageView(
                        children: lessonTypes.map((type) {
                          switch (type) {
                            case "Video":
                              return Container(
                                height: screenHeight * (1 - share - 0.1),
                                width: screenWidth,
                                child: VideoLesson(videoString: "https://www.youtube.com/watch?v=URALwXz7q8k&list=PL5q2T2FxzK7W1ynSrFh9E8eKQvdwTgXbm"),
                              );
                            case "Flashcard":
                              return Container(
                                height: screenHeight * (1 - share - 0.1),
                                width: screenWidth,
                                child: Flashcard(isPressedCourse: widget.isPressedCourse, isPressedLessons: widget.isPressedLessons),
                              );
                            case "Write correct answer":
                              return Container(
                                height: screenHeight * (1 - share - 0.1),
                                width: screenWidth,
                                child: WriteCorrectAnswer(isPressedCourse: widget.isPressedCourse, isPressedLessons: widget.isPressedLessons),
                              );
                            case "Choose correct answer":
                              return Container(
                                height: screenHeight * (1 - share - 0.1),
                                width: screenWidth,
                                child: ChooseCorrectAnswer(isPressedCourse: widget.isPressedCourse, isPressedLessons: widget.isPressedLessons),
                              );
                            default:
                              return Container();
                          }
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ],
            )
        )
    );
  }
}



