import 'package:athena/LoginAndSignup/Components/ChangePasswordTextFormField.dart';
import 'package:flutter/material.dart';


class ChangePasswordForm extends StatelessWidget{
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
                height: 600,
                width: screenWidth - 16*2,
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                          "Change Password",
                          style: TextStyle(
                            fontFamily: 'Playwrite GB S',
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 460,
                          child: ChangePasswordTextFormField(),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}