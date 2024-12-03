import 'package:flutter/material.dart';

class ChineseContent extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(15, 100, 15, 20),
                child: ClipOval(
                  child: Container(
                    width: 200.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Image.asset(
                      'assets/backgrounds/HomePage/China/China.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )

            ],
          )
        ],
      ),
    );
  }
}