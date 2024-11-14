import 'dart:async';
import 'dart:ui';
import 'package:athena/Classes/Functions.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoginAndSignup extends StatefulWidget {
  @override
  State<LoginAndSignup> createState() => _LoginAndSignupState();
}

class _LoginAndSignupState extends State<LoginAndSignup> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;
  List<String> texts = ["Hello", "你好","Bonjour", "こんにちは", "Xin chào", "안녕하세요"];
  int textIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.linear,
    );
    _controller!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(seconds: 2), () {
          _controller!.reverse();
        });
      } else if (status == AnimationStatus.dismissed) {
        setState(() {
          textIndex = (textIndex + 1) % texts.length;
        });
        _controller!.forward();
      }
    });
    _controller!.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool _isPressedStartTheCourse = false;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: screenHeight,
            width: screenWidth,
            color: Colors.black,
            child: RiveAnimation.asset(
              'assets/riveassets/c.riv',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            height: screenHeight,
            width: screenWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column (
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          height: 100,
                          width: screenWidth * 0.8,
                          child: FadeTransition(
                            opacity: _animation!,
                            child: Text(
                              texts[textIndex],
                              style: TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 100,
                          width: screenWidth * 0.8,
                          // color: Colors.red,
                          child: Text(
                            "Lingua Master is an app that supports learning multiple languages, provides vocabulary courses, and integrates gamification to motivate learning. ",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        )
                      ],
                    ),

                    Column (
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          height: 100,
                          width: screenWidth * 0.8,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            // color: Colors.red,
                            child: Stack(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                     Container(
                                       height: 70,
                                       width: 80,
                                       decoration: BoxDecoration(
                                         color: Colors.cyan,
                                         borderRadius: BorderRadius.only(
                                           topLeft: Radius.circular(10),
                                           topRight: Radius.circular(30),
                                           bottomLeft: Radius.circular(30),
                                           bottomRight: Radius.circular(10),
                                         ),
                                       ),
                                     )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InkWell(
                                        onTap: () async {
                                          await Future.delayed(Duration(milliseconds: 300));
                                          Functions.showLoginGeneralDialog(context);
                                          print('Start the course clicked!');
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 11),
                                          height: 60,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(30)
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              ImageIcon(
                                                AssetImage('assets/icons/rArrow.png'),
                                                size:  24,
                                                color: Colors.cyan,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Start the course",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ),
                        Container(
                          height: 100,
                          width: screenWidth * 0.8,
                          // color: Colors.red,
                          child: const Text(
                            "The app includes +4 languages, +35 lessons, +2 games, and more, relax and fly to the moon with me!",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}




