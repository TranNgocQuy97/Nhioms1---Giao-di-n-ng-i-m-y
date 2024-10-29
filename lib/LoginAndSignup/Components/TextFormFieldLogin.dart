import 'package:athena/screen/homepage.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';



class TextFormFieldLogin extends StatefulWidget{
  const TextFormFieldLogin({
    Key ? key,
  }) : super(key:key);
  @override
  State<TextFormFieldLogin> createState() => _TextFormFieldLoginState();
}

class _TextFormFieldLoginState extends State<TextFormFieldLogin> {

  final TextEditingController _username_controller = TextEditingController();
  final TextEditingController _password_controller = TextEditingController();

  bool _isObscured = true;

  void _toggleObscureText() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  void dispose() {
    _username_controller.dispose();
    _password_controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 250, 255, 0),
      resizeToAvoidBottomInset: false,
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
                        "Username",
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
                          controller: _username_controller,
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
            SizedBox(height: 10,),
            /******************************************************************************/
            Container(
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Password",
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
                              icon: Icon(
                                _isObscured ? Icons.visibility : Icons.visibility_off,
                              ),
                              onPressed: () async {
                                print(
                                  "click hide password"
                                );
                                if (await Vibration.hasVibrator() ?? false) {
                                  Vibration.vibrate(duration: 50); // Rung máy trong 50ms
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

            GestureDetector(
              onTap: () async {
                if (await Vibration.hasVibrator() ?? false) {
                  Vibration.vibrate(duration: 50);
                }
                print("click login");
                Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()), // Thay Homepage() bằng widget của bạn
                      );
              },
              child:Container(
                height: 55,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(152, 182, 215, 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 0.5,
                      blurRadius: 2,
                      offset: Offset(1, 1),
                    ),
                  ],
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
                    ImageIcon(
                      AssetImage('assets/icons/rArrow.png'),
                      size: 20.0,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




