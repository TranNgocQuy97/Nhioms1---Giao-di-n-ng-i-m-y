import 'package:athena/Classes/Functions.dart';
import 'package:athena/LoginAndSignup/Components/LoginTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class LoginForm extends StatefulWidget{
  @override
  State<LoginForm> createState() => _LoginAndSighupFormState();
}

class _LoginAndSighupFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Center(
        child: GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  height: 550,
                  width: screenWidth - 16*2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Color.fromRGBO(248, 250, 255, 0.95),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 4,
                        blurRadius: 8,
                        offset: Offset(4, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Login",
                            style: TextStyle(
                              fontFamily: 'Playwrite GB S',
                              color: Colors.black,
                              decoration: TextDecoration.none,
                              fontSize: 40,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 260,
                            child: LoginTextFormField(),
                          ),
                        ],
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                              height: 160,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      height: 30,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: 1,
                                            width: 100,
                                            color: Color.fromRGBO(210, 210, 210, 1),
                                          ),
                                          Text(
                                            "OR",
                                            style: TextStyle(
                                              decoration: TextDecoration.none,
                                              fontFamily: 'Playwrite GB S',
                                              fontWeight: FontWeight.w400,
                                              color: Color.fromRGBO(200, 200, 200, 1),
                                              fontSize: 15,
                                            ),
                                          ),
                                          Container(
                                            height: 1,
                                            width: 100,
                                            color: Color.fromRGBO(210, 210, 210, 1),
                                          ),
                                        ],
                                      )
                                  ),

                                  Text(
                                    textAlign: TextAlign.center,
                                    "Sign up with Email, Apple or create a new account manually.",
                                    style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontFamily: 'Playwrite GB S',
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(150, 150, 150, 1),
                                      fontSize: 14,
                                    ),
                                  ),

                                  Container(
                                    height: 45,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Material(
                                          shape: CircleBorder(),
                                          clipBehavior: Clip.hardEdge,
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () async {
                                              if (await Vibration.hasVibrator() ?? false) {
                                                Vibration.vibrate(duration: 50);
                                              }
                                              print("click email");
                                            },

                                            child: Container(
                                                width: 45,
                                                child: Center(
                                                  child: Stack(
                                                    children: [
                                                      Center(
                                                        child: Container(
                                                          child: Image.asset(
                                                            'assets/icons/hexagonWborder.png',
                                                            height: 45,
                                                            width: 45,
                                                          ),
                                                        ),
                                                      ),

                                                      Center(
                                                        child: Container(
                                                          child: ImageIcon(
                                                            AssetImage('assets/icons/email.png'),
                                                            size: 18.0,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                            ),
                                          ),
                                        ),


                                        Material(
                                          shape: CircleBorder(),
                                          clipBehavior: Clip.hardEdge,
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () async {
                                              if (await Vibration.hasVibrator() ?? false) {
                                                Vibration.vibrate(duration: 50);
                                              }
                                              print("click apple");
                                            },
                                            child: Container(
                                                width: 45,
                                                child: Center(
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        child: ImageIcon(
                                                          AssetImage('assets/icons/hexagonWborder.png'),
                                                          size: 45.0,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Center(
                                                        child: Container(
                                                          child: ImageIcon(
                                                            AssetImage('assets/icons/apple.png'),
                                                            size: 22.0,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                            ),
                                          ),
                                        ),

                                        Material(
                                          shape: CircleBorder(),
                                          clipBehavior: Clip.hardEdge,
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () async {
                                              if (await Vibration.hasVibrator() ?? false) {
                                                Vibration.vibrate(duration: 50);
                                              }
                                              print("click new manually");
                                              Navigator.pop(context);
                                              await Future.delayed(Duration(milliseconds: 300));
                                              Functions.showSignUpGeneralDialog(context);
                                            },

                                            child: Container(
                                                width: 45,
                                                child: Center(
                                                  child: Stack(
                                                    children: [
                                                      Center(
                                                        child: Container(
                                                          child: Image.asset(
                                                            'assets/icons/hexagon.png',
                                                            height: 45,
                                                            width: 45,
                                                          ),
                                                        ),
                                                      ),
                                                      Center(
                                                        child: Container(
                                                          child: Image.asset(
                                                            'assets/icons/plus.png',
                                                            height: 20,
                                                            width: 20,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )
        )
    );
  }
}








