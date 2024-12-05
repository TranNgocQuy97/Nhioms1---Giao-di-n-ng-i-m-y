import 'dart:math';
import 'dart:ui';
import 'package:athena/HomePage/Components/English/Components/StartLesson.dart';
import 'package:flutter/material.dart';
import '../../FirebaseRealTimeDataBase/FirebaseRealTimeDataBase.dart';



class SelectLesson extends StatefulWidget {
  final List<String> courseNames;
  const SelectLesson({super.key, required this.courseNames});
  @override
  State<SelectLesson> createState() => _SelectLessonState();
}

class _SelectLessonState extends State<SelectLesson> {
  List<Color> lightColorList = [Colors.black, Colors.white];
  List<Color> darkColorList = [Colors.black, Colors.white];
  int? numCourse;
  int? numLesson;
  int isPressedLesson = 0;
  int isPressedCourse = 0;
  List<String> lessonNames = [];
  List<int> lessonLevel = [];
  List<Color> randomColors = [];
  List<Color> lessonCor = [
    Color.fromRGBO(242, 249, 255, 1),
    Color.fromRGBO(255, 245, 215, 1),
    Color.fromRGBO(255, 200, 100, 1),
    Color.fromRGBO(168, 136, 181, 1),
    Color.fromRGBO(251, 251, 251, 1),
    Color.fromRGBO(154, 191, 128, 1),
    Color.fromRGBO(168, 136, 181, 1),
    Color.fromRGBO(172, 188, 255, 1),
  ];
  List<String> randomBack = [];
  List<String> backLess = [
    "assets/backgrounds/HomePage/English/1.png",
    "assets/backgrounds/HomePage/English/2.png",
    "assets/backgrounds/HomePage/English/3.png",
    "assets/backgrounds/HomePage/English/4.png",
    "assets/backgrounds/HomePage/English/5.png",
    "assets/backgrounds/HomePage/English/6.png",
    "assets/backgrounds/HomePage/English/7.png",
    "assets/backgrounds/HomePage/English/8.png",
  ];
  void loadCourseNames() async {
    List<String> names = await FireBaseRealTimeDataBase.fetchCourse(
        "languages/0/courses/$isPressedCourse/lessons/", "name");
    List<int> levels = await FireBaseRealTimeDataBase.getList(
        "languages/0/courses/$isPressedCourse/lessons/", "level");
    setState(() {
      lessonNames = names;
      lessonLevel = levels;
      numLesson = lessonNames.length;
      randomColors = List.generate(numLesson ?? 0, (_) => getRandomLessonColor(lessonCor));
      randomBack = List.generate(numLesson ?? 0, (_) => getRandomLessonBackground(backLess));
    });
  }

  static void showCourse(BuildContext context, int isPressedCourse, int isPressedLessons ) {
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "showClass",
      context: context,
      transitionDuration: Duration(milliseconds: 350),
      transitionBuilder: (_, animation, __, child) {
        Tween<Offset> tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        return SlideTransition(
          position: tween.animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          ),
          child: child,
        );
      },
      pageBuilder: (context, _, __) =>StartLesson(isPressedCourse: isPressedCourse, isPressedLessons: isPressedLessons),
    );
  }

  Color getRandomLessonColor(List<Color> colorList) {
    Random random = Random();
    return colorList[random.nextInt(colorList.length)];
  }

  String getRandomLessonBackground(List<String> backLess) {
    Random random = Random();
    return backLess[random.nextInt(backLess.length)];
  }

  @override
  void initState() {
    super.initState();
    loadCourseNames();
    numCourse = widget.courseNames.length;
  }


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
        height: screenHeight,
        width: screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                    height: 50,
                    child: IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 26,
                        )
                    )
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(0, 40, 20, 0),
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
            ),
            Text(
                "Choose",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                color: Color.fromRGBO(31, 80, 154, 1)
              ),
            ),
            Text(
              "your first lesson",
              style: TextStyle(
                fontSize: 25,
                color: Colors.black
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RotatedBox(
                quarterTurns: 3,
                child: Container(
                    width: 500,
                    height: 40,
                    // color: Colors.blue,
                    child:
                        ListView(
                            scrollDirection: Axis.horizontal, children: [
                          Row(
                              children: List.generate(
                                  numCourse ?? 0,
                                  (index) =>
                                      GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isPressedCourse = index;
                                            });
                                            print("is pressed ${widget.courseNames[index]}");
                                            print(isPressedCourse);
                                            print("$lessonNames $numLesson");
                                            loadCourseNames();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 10),
                                            height: 33,
                                            // color: Colors.yellow,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  widget.courseNames[index],
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: isPressedCourse == index ? Colors.black : Colors.grey,
                                                  ),
                                                ),
                                                Container(
                                                  height: 2.5,
                                                  width: 50,
                                                  decoration:isPressedCourse == index ? BoxDecoration(
                                                    color: Colors.redAccent,
                                                    borderRadius:BorderRadius.circular(30),
                                                  ) : null,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                              ))
                    ])),
              ),
              Container(
                  height: 599,
                  width: screenWidth*0.75,
                padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(2, 2),
                    ),
                  ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    ),
                  ),
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                  children: List.generate(numLesson ?? 0,
                      (index) => GestureDetector(
                        onTap: (){
                          setState(() {
                            print(screenWidth*0.75);
                          });
                        },
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              isPressedLesson = index;
                            });
                            showCourse(context,isPressedCourse, isPressedLesson);
                          },
                          child: Container(
                            constraints: BoxConstraints(
                              minHeight: 200,
                            ),
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.3),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child:
                            Stack(
                              children: [
                                Container(
                                  constraints: BoxConstraints(
                                    minHeight: 200,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: randomColors[index],
                                  ),
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                    minHeight: 200,
                                  ),
                                  child:  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      randomBack[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 15,
                                        width: 15,
                                        decoration: BoxDecoration(
                                            color: Color.fromRGBO(0, 0, 0, 0.8),
                                          borderRadius: BorderRadius.circular(50)
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(25, 0, 0, 0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(0, 0, 0, 0.8),
                                                borderRadius: BorderRadius.circular(10)
                                              ),
                                              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                              padding: EdgeInsets.all(5),
                                              child: Text(
                                                lessonNames[index],
                                                style: TextStyle(
                                                  color: Colors.white
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text("Contributors: "),
                                                Row(
                                                  children: List.generate(2, (index)
                                                  => Container(
                                                    margin: EdgeInsets.symmetric(horizontal: 2),
                                                    height: 30,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(50),
                                                      border: Border.all(
                                                        color: Colors.black,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(50),
                                                      child: Image.network(
                                                          index == 1 ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjKiLTZODsQbeA9ViUROoMQ4WwMfqAbpIm1A&s"
                                                        : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0e0W0z9LGb3MT8z6GZw7zqTM9c_6st7U3EA&s",
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  )
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text("Level: "),
                                                Text("${lessonLevel[index]}"),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ),
                              ],
                            ),
                                                ),
                        )
                      ))
                ),
                )
              ],
            )
          ],
        ),
      )
    );
  }
}

