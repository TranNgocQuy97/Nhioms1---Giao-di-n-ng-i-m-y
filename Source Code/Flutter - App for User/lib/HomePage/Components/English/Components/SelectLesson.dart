import 'package:flutter/material.dart';
import '../../FirebaseRealTimeDataBase/FirebaseRealTimeDataBase.dart';



class SelectLesson extends StatefulWidget {
  final List<String> courseNames;
  const SelectLesson({super.key, required this.courseNames});
  @override
  State<SelectLesson> createState() => _SelectLessonState();
}

class _SelectLessonState extends State<SelectLesson> {

  int? numCourse;
  int? numLesson;
  int isPressedCourse = 0;
  List<String> lessonNames = [];
  void loadCourseNames() async {
    List<String> names = await FireBaseRealTimeDataBase.fetchCourseNames("languages/0/courses/$isPressedCourse/lessons");
    setState(() {
      lessonNames = names;
      numLesson = lessonNames.length;
    });
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
      body: Container(
        padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
        height: screenHeight,
        width: screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  width: 260,
                padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 3,
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
                  padding: EdgeInsets.symmetric(vertical: 0),
                  children: List.generate(numLesson ?? 0,
                      (index) => Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                        height: 160,
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Text(
                          lessonNames[index],
                        ),
                      )
                  )
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