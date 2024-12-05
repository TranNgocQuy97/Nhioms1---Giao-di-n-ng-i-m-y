import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'Components/SelectLesson.dart';
import 'Components/SelectExercise.dart';

class KoreanContent extends StatefulWidget {
  @override
  State<KoreanContent> createState() => _KoreanContentState();
}

class _KoreanContentState extends State<KoreanContent> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  int selectedValue = 0;

  List<String> icons = [
    "assets/icons/video-lesson.png",
    "assets/icons/homework.png",
    "assets/icons/game.png",
    "assets/icons/mixed.png"
  ];
  List<String> title = ["Lesson", "Exercise", "Game", "Mixed"];

  void updateCourseStartData(String language) async {
    User? user = _auth.currentUser;
    if (user != null) {
      String userId = user.uid;
      String timestamp = DateTime.now().toIso8601String();

      await _database.child('users/$userId/courseStart').set({
        'language': language,
        'timestamp': timestamp,
      }).then((_) {
        print('Data updated successfully');
      }).catchError((error) {
        print('Failed to update data: $error');
      });
    } else {
      print('No user is signed in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backgrounds/HomePage/Korean/Korean.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 90.0, left: 16.0, right: 16.0, bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Korean for",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                      Text(
                        "Daily Use",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 130,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(17),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          child: Image.asset(
                            "assets/icons/verify.png",
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            3,
                            (index) => Icon(
                              Icons.star_rounded,
                              color: Color.fromRGBO(255, 227, 26, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _MainContentWidget(
              icons: icons,
              title: title,
              onButtonTap: (index) {
                setState(() {
                  selectedValue = index;
                });
                if (title[index] == "Exercise") {
                  updateCourseStartData('KOREAN'); // Cập nhật dữ liệu khi nhấn vào Exercise
                }
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _MainContentWidget extends StatelessWidget {
  final List<String> icons;
  final List<String> title;
  final Function(int) onButtonTap;

  const _MainContentWidget({
    required this.icons,
    required this.title,
    required this.onButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1.5,
        ),
        itemCount: icons.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onButtonTap(index);
              if (title[index] == "Lesson") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectLesson(
                      courseNames: ["Giao Tiếp", "Phát Âm"], // Pass the actual course names here
                    ),
                  ),
                );
              } else if (title[index] == "Exercise") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectExercise(),
                  ),
                );
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    icons[index],
                    height: 35,
                    width: 35,
                  ),
                  SizedBox(height: 10),
                  Text(
                    title[index],
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

