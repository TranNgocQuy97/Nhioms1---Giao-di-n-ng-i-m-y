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
<<<<<<< HEAD
                      'assets/backgrounds/HomePage/China/China.jpg',
=======
                      'assets/backgrounds/HomePage/English/English.jpg',
>>>>>>> 36acb6c6c9dd7993626cf3e40f6ea83819079e4f
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