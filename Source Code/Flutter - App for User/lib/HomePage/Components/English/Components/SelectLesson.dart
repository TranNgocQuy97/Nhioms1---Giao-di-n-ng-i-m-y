import 'package:flutter/material.dart';



class SelectLesson extends StatelessWidget {
  List<String> typeLess = ["ABC", "ABC", "READING", "SPEAKING", "GRAMMAR"];
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
                    color: Colors.blue,
                    child:
                        ListView(scrollDirection: Axis.horizontal, children: [
                      Stack(
                        children: [
                          Container(
                            width: 500,
                            height: 40,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [

                              ],
                            ),
                          ),
                          Row(
                              children: List.generate(
                                  5,
                                  (index) => GestureDetector(
                                        onTap: () {
                                          print(index);
                                        },
                                        child: Container(
                                          width: 120,
                                          height: 33,
                                          color: Colors.yellow,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                typeLess[index],
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )))
                        ],
                      )
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
                child:
                ListView(
                  padding: EdgeInsets.symmetric(vertical: 0),
                  children: List.generate(4,
                      (index) => Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                        height: 160,
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(20)
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