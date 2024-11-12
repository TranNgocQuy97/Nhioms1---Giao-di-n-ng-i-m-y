import 'package:athena/Classes/Functions.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';


class SignUpTextFormField extends StatefulWidget {
  const SignUpTextFormField({
    Key ? key,
  }) : super(key:key);
  @override
  State<SignUpTextFormField> createState() => _SignUpTextFormFieldState();
}

class _SignUpTextFormFieldState extends State<SignUpTextFormField> {
  final TextEditingController _name_controller = TextEditingController();
  final TextEditingController _email_controller = TextEditingController();
  final TextEditingController _phoneNumber_controller = TextEditingController();
  final TextEditingController _password_controller = TextEditingController();
  final TextEditingController _passwordAgain_controller = TextEditingController();

  bool _isPressedLogin = false;
  bool _isPressedSignUp = false;

  @override
  void dispose() {
    _name_controller.dispose();
    _email_controller.dispose();
    _phoneNumber_controller.dispose();
    _password_controller.dispose();
    _passwordAgain_controller.dispose();
    super.dispose();
  }


  bool _isObscured = true;
  @override
  void _toggleObscureText() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }
  bool _isObscured2 = true;
  void _toggleObscureText2() {
    setState(() {
      _isObscured2 = !_isObscured2;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 250, 255, 0),
      resizeToAvoidBottomInset: false,
      body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                            "Name",
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
                              controller: _name_controller,
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
                                        "assets/icons/user.png",
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
                Container(
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Phone Number",
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
                              controller: _phoneNumber_controller,
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
                                        "assets/icons/phoneNumber.png",
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
                Container(
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Password again",
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
                              obscureText: _isObscured,
                              controller: _password_controller,
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
                                suffixIcon: IconButton(
                                  icon: Icon(_isObscured ? Icons.visibility : Icons.visibility_off,),
                                  onPressed: () async {
                                    if (await Vibration.hasVibrator() ?? false) {
                                      Vibration.vibrate(duration: 50);
                                    }
                                    _toggleObscureText();
                                  },
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
                                        "assets/icons/key2.png",
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
                Container(
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Password again",
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
                              obscureText: _isObscured2,
                              controller: _passwordAgain_controller,
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
                                suffixIcon: IconButton(
                                  icon: Icon(_isObscured2 ? Icons.visibility : Icons.visibility_off,),
                                  onPressed: () async {
                                    if (await Vibration.hasVibrator() ?? false) {
                                      Vibration.vibrate(duration: 50);
                                    }
                                    _toggleObscureText2();
                                  },
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
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTapDown: (TapDownDetails details) async {
                        if (await Vibration.hasVibrator() ?? false) {
                          Vibration.vibrate(duration: 50);
                        }
                        setState(() {
                          _isPressedLogin = true;
                        });
                        await Future.delayed(Duration(milliseconds: 200));
                        Navigator.pop(context);
                        await Future.delayed(Duration(milliseconds: 300));
                        Functions.showLoginGeneralDialog(context);
                        setState(() {
                          _isPressedLogin = false;
                        });
                        print("Click login");
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 50),
                        width: 100,
                        height: 55,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(74, 98, 138, 1),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Login",
                              style: TextStyle(
                                fontSize: _isPressedLogin ? 17 :18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTapDown: (TapDownDetails details) async {
                        if (await Vibration.hasVibrator() ?? false) {
                          Vibration.vibrate(duration: 50);
                        }
                        setState(() {
                          _isPressedSignUp = true;
                        });
                        await Future.delayed(Duration(milliseconds: 100));

                        setState(() {
                          _isPressedSignUp = false;
                        });
                        print("Click Sign Up");
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 50),
                        width: 150,
                        height: 55,
                        decoration: BoxDecoration(
                          color: _isPressedSignUp ? Color.fromRGBO(142, 172, 205, 1) : Color.fromRGBO(152, 182, 215, 1),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(25),
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: _isPressedSignUp ? 17 :18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}