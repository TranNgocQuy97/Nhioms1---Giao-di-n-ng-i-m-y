import 'package:flutter/material.dart';

class SelectExercise extends StatefulWidget {
  const SelectExercise({super.key});

  @override
  State<SelectExercise> createState() => _SelectExerciseState();
}

class _SelectExerciseState extends State<SelectExercise> {
  Color topColor = Colors.white;
  Color bottomColor = Color.fromRGBO(28, 50, 91, 1);
  double share = 0.75;
  double border1 = 80;
  double border2 = 30;
  double border3 = 10;
  double border4 = 30;

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
                  width: screenWidth * 0.5,
                  color: topColor,
                ),
                Container(
                  height: screenHeight,
                  width: screenWidth * 0.5,
                  color: bottomColor,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(15, 30, 15, 15),
                  height: screenHeight * share,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: topColor,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(80),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 26,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 200,
                            width: 330,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.6),
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                  offset: Offset(2, 2),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(60),
                              color: bottomColor,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Image.asset(
                                'assets/backgrounds/HomePage/Japan/dongho.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Question:",
                        style: TextStyle(
                          fontSize: 30,
                          color: bottomColor,
                        ),
                      ),
                      Text(
                        "日の出は普通何時ごろですか？",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "答えを選んでください：",
                        style: TextStyle(
                          fontSize: 22,
                          color: bottomColor,
                        ),
                      ),
                      Text(
                        "A. 午前5時ごろ。\n"
                        "B. 午後12時ごろ。\n"
                        "C. 午前7時ごろ。\n"
                        "D. 午前10時ごろ。\n",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: screenHeight * (1 - share),
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: bottomColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(80),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      2,
                      (iCol) => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          2,
                          (iRow) => Container(
                            constraints: BoxConstraints(
                              minHeight: 78,
                            ),
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            width: 160,
                            decoration: BoxDecoration(
                              color: (iCol == 0 && iRow == 0)
                                  ? Colors.orange
                                  : (iCol == 0 && iRow == 1)
                                      ? Colors.blue
                                      : (iCol == 1 && iRow == 0)
                                          ? Colors.yellow
                                          : Colors.redAccent,
                              borderRadius: BorderRadius.only(
                                topLeft: (iCol == 0 && iRow == 0)
                                    ? Radius.circular(border1)
                                    : (iCol == 0 && iRow == 1)
                                        ? Radius.circular(border2)
                                        : (iCol == 1 && iRow == 0)
                                            ? Radius.circular(border4)
                                            : Radius.circular(border3),
                                topRight: (iCol == 0 && iRow == 0)
                                    ? Radius.circular(border2)
                                    : (iCol == 0 && iRow == 1)
                                        ? Radius.circular(border1)
                                        : (iCol == 1 && iRow == 0)
                                            ? Radius.circular(border3)
                                            : Radius.circular(border2),
                                bottomRight: (iCol == 0 && iRow == 0)
                                    ? Radius.circular(border3)
                                    : (iCol == 0 && iRow == 1)
                                        ? Radius.circular(border4)
                                        : (iCol == 1 && iRow == 0)
                                            ? Radius.circular(border2)
                                            : Radius.circular(border1),
                                bottomLeft: (iCol == 0 && iRow == 0)
                                    ? Radius.circular(border4)
                                    : (iCol == 0 && iRow == 1)
                                        ? Radius.circular(border3)
                                        : (iCol == 1 && iRow == 0)
                                            ? Radius.circular(border1)
                                            : Radius.circular(border4),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                (iCol == 0 && iRow == 0)
                                    ? "A"
                                    : (iCol == 0 && iRow == 1)
                                        ? "B"
                                        : (iCol == 1 && iRow == 0)
                                            ? "C"
                                            : "D",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: bottomColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 