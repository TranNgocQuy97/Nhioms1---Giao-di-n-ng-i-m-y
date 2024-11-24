import 'package:flutter/material.dart';

import 'Components/SelectLesson.dart';


class EnglishContent extends StatefulWidget{

  @override
  State<EnglishContent> createState() => _EnglishContentState();
}

class _EnglishContentState extends State<EnglishContent> {
  BoxShadow EnglishBoxShadow = BoxShadow(color: Colors.black.withOpacity(0.1), spreadRadius: 1, blurRadius: 4, offset: Offset(1, 1),);
  Color ColorSchemeOfEnglish = Color.fromRGBO(20, 52, 106, 1);
  int selectedValue = 0;

  static void showLoginGeneralDialog(BuildContext context) {
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "Login",
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
      pageBuilder: (context, _, __) => SelectLesson(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    List<String> icons = [""];
    List<String> title = ["Teacher", "Game", "Lesson", "Exercise"];
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "English for",
                    style: TextStyle(
                      color: ColorSchemeOfEnglish,
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                  Text(
                    "Daily Use",
                    style: TextStyle(
                      color: ColorSchemeOfEnglish,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
                Container(
                  width: 130,
                  height: 80,
                  decoration: BoxDecoration(
                      boxShadow: [EnglishBoxShadow],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(17)),
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
                          children: List.generate(
                            3, (index) => Icon(
                              Icons.star_rounded,
                            color: Color.fromRGBO(255, 227, 26, 1),
                            ),
                          )
                        )
                      ],
                    )),
            ],
          ),

          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            width: screenWidth,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 130,
                      decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Center(
                        child: Text(
                          "Search",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 260,
                width: 170,
                decoration: BoxDecoration(
                  boxShadow: [EnglishBoxShadow],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30)
                ),
                child: Stack(
                  children: [
                    Container(
                      height: 260,
                      width: 170,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30), // Bo góc cho hình ảnh
                        child: Image.asset(
                          "assets/backgrounds/HomePage/English/English.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                height: 260,
                width: 110,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                        4, (index) =>
                        InkWell(
                          onTap: (){
                            showLoginGeneralDialog(context);
                            print("Is press $index");
                          },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                height: 55,
                                decoration: BoxDecoration(
                                    boxShadow: [EnglishBoxShadow],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.abc,
                                      ),
                                      Text(
                                        "132",
                                        style: TextStyle(
                                          fontSize: 5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ))),
              ),
            ],
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
            )
          ),

        ],
      ),
    );
  }
}