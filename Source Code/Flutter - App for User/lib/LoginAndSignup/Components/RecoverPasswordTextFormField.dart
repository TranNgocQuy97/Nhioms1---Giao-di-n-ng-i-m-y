import 'package:athena/Classes/Functions.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';


class RecoverPasswordTextFormField extends StatefulWidget{
  const RecoverPasswordTextFormField({
    Key ? key,
  }) : super(key:key);
  @override
  State<RecoverPasswordTextFormField> createState() => _RecoverPasswordTextFormFieldState();
}

class _RecoverPasswordTextFormFieldState extends State<RecoverPasswordTextFormField> {

  final TextEditingController _email_controller = TextEditingController();
  final TextEditingController _code_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                          "Code",
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
                            controller: _code_controller,
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
                              suffixIcon:
                              GestureDetector(
                                onTap: (){
                                  print("Send Code");
                                },
                                child: Container(
                                width: 90,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(126, 96, 191, 1),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(0),
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(25),
                                    bottomRight: Radius.circular(20),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "Send",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),  
                                  ),
                                )),
                              ),
                        ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 60,
                                width: 50,
                                child: Center(
                                  child: Container(
                                    width: 30,
                                    child: Image.asset(
                                      "assets/icons/code.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                height: 60,
                decoration: BoxDecoration(
                    // color: Colors.green
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTapDown: (TapDownDetails details) async {
                        if (await Vibration.hasVibrator() ?? false) {
                          Vibration.vibrate(duration: 50);
                        }
                        await Future.delayed(Duration(milliseconds: 200));
                        Navigator.pop(context);
                        await Future.delayed(Duration(milliseconds: 300));
                        Functions.showLoginGeneralDialog(context);
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
                                fontSize: 18,
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
                        print("Click Send");
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 50),
                        width: 150,
                        height: 55,
                        decoration: BoxDecoration(
                          color:Color.fromRGBO(142, 172, 205, 1) ,
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
                              "Send",
                              style: TextStyle(
                                fontSize:18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
      ),
    );
  }
}