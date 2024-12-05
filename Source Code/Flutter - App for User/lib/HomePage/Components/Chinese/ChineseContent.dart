import 'package:flutter/material.dart';
import 'dart:async';
import 'Components/SelectLesson.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:athena/HomePage/Components/FirebaseRealTimeDataBase/FirebaseRealTimeDataBase.dart';
class ChineseContent extends StatefulWidget {
  @override
  _ChineseContentState createState() => _ChineseContentState();
}

class _ChineseContentState extends State<ChineseContent> {
  Timer? _timer;
  StreamSubscription? _subscription;

  final BoxShadow chineseBoxShadow = BoxShadow(
    color: Colors.black.withOpacity(0.1),
    spreadRadius: 1,
    blurRadius: 4,
    offset: Offset(1, 1),
  );

  final Color colorSchemeOfChinese = Color.fromRGBO(20, 52, 106, 1);

  List<String> courseNames = [];

  @override
  void initState() {
    super.initState();
    loadCourseNames();

    // Khởi tạo Timer
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          // Cập nhật trạng thái
        });
      }
    });

    // Giả sử bạn có một Stream
    Stream<int> someStream = Stream.periodic(Duration(seconds: 1), (count) => count);
    _subscription = someStream.listen((data) {
      if (mounted) {
        setState(() {
          // Cập nhật trạng thái với dữ liệu từ stream
        });
      }
    });
  }

  void loadCourseNames() async {
    try {
      List<String> names = await FireBaseRealTimeDataBase.fetchCourseNames('languages/1/courses');
      setState(() {
        courseNames = names;
      });
    } catch (e) {
      print("Error fetching course names: $e");
      // Xử lý lỗi nếu cần
    }
  }

  @override
  void dispose() {
    // Hủy bỏ Timer
    _timer?.cancel();

    // Hủy bỏ lắng nghe Stream
    _subscription?.cancel();

    super.dispose();
  }

  static void showClass(BuildContext context, List<String> courseNames) {
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "showClass",
      context: context,
      transitionDuration: Duration(milliseconds: 200),
      transitionBuilder: (_, animation, __, child) {
        Tween<Offset> tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        return SlideTransition(
          position: tween.animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          ),
          child: child,
        );
      },
      pageBuilder: (context, _, __) => SelectLesson(courseNames: courseNames),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    List<String> icons = [
      "assets/icons/video-lesson.png",
      "assets/icons/homework.png",
      "assets/icons/game.png",
      "assets/icons/mixed.png"
    ];
    List<String> title = ["Lesson", "Exercise", "Game", "Mixed"];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(15, 100, 15, 20),
                child: ClipOval(
                  child: Container(
                    width: 200.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Image.asset(
                      'assets/backgrounds/HomePage/China/China.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            width: screenWidth * 0.9,
            height: 45,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Text(
                "Search",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              4,
              (index) => GestureDetector(
                onTap: () {
                  if (index == 0) { // Assuming the first box is for lessons
                    showClass(context, courseNames);
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  height: 100,
                  width: 80,
                  decoration: BoxDecoration(
                      boxShadow: [chineseBoxShadow],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        child: Image.asset(
                          icons[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        title[index],
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 25),
            height: 87,
            child: Center(
              child: Image.asset(
                'assets/icons/up-arrow.png',
                width: 87,
                height: 87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}