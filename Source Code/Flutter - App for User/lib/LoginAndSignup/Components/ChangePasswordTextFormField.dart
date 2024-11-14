import 'package:athena/Classes/Functions.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';


class ChangePasswordTextFormField extends StatelessWidget{

  final TextEditingController _email_controller = TextEditingController();
  final TextEditingController _oldPassword_controller = TextEditingController();
  final TextEditingController _newPassword_controller = TextEditingController();
  final TextEditingController _reNewPassword_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 250, 255, 0),
      body: Form(
        child: Column(
          children: [
            Container(
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Email",
                        style: TextStyle(
                          color: Color.fromRGBO(150, 150, 150, 1),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 60,
                    child: Stack(
                      children: [
                        TextFormField(
                          controller: _email_controller,
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Color.fromRGBO(210, 210, 210, 1),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 53,
                              width: 50,
                              child: Center(
                                child: Container(
                                  width: 25,
                                  child: Image.asset(
                                    "assets/icons/emailTextForm.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),

            Container(
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Old Password",
                        style: TextStyle(
                          color: Color.fromRGBO(150, 150, 150, 1),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 60,
                    child: Stack(
                      children: [
                        TextFormField(
                          controller: _oldPassword_controller,
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Color.fromRGBO(210, 210, 210, 1),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 53,
                              width: 50,
                              child: Center(
                                child: Container(
                                  width: 25,
                                  child: Image.asset(
                                    "assets/icons/key.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "New Password",
                        style: TextStyle(
                          color: Color.fromRGBO(150, 150, 150, 1),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 60,
                    child: Stack(
                      children: [
                        TextFormField(
                          controller: _oldPassword_controller,
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Color.fromRGBO(210, 210, 210, 1),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 53,
                              width: 50,
                              child: Center(
                                child: Container(
                                  width: 25,
                                  child: Image.asset(
                                    "assets/icons/key.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "New Password",
                        style: TextStyle(
                          color: Color.fromRGBO(150, 150, 150, 1),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 60,
                    child: Stack(
                      children: [
                        TextFormField(
                          controller: _oldPassword_controller,
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Color.fromRGBO(210, 210, 210, 1),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 53,
                              width: 50,
                              child: Center(
                                child: Container(
                                  width: 25,
                                  child: Image.asset(
                                    "assets/icons/key.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}