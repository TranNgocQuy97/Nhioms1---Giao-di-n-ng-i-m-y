import 'package:flutter/material.dart';

<<<<<<< HEAD
class KoreanContent extends StatefulWidget {
  @override
  State<KoreanContent> createState() => _KoreanContentState();
}

class _KoreanContentState extends State<KoreanContent> {
  int selectedValue = 0;

  List<String> icons = [
    "assets/icons/video-lesson.png",
    "assets/icons/homework.png",
    "assets/icons/game.png",
    "assets/icons/mixed.png"
  ];
  List<String> title = ["Lesson", "Exercise", "Game", "Mixed"];

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
            onTap: () => onButtonTap(index),
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

=======
class KoreanContent extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: 100,
      )
    );
  }
}
>>>>>>> 36acb6c6c9dd7993626cf3e40f6ea83819079e4f
