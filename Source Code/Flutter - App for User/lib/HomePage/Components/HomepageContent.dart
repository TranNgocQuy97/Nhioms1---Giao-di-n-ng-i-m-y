import 'package:athena/HomePage/Components/English/EnglishContent.dart';
import 'package:athena/HomePage/Components/Korean/KoreanContent.dart';
import 'package:athena/HomePage/Components/Chinese/ChineseContent.dart';
import 'package:athena/HomePage/Components/Japanese/JapaneseContent.dart';
import 'package:flutter/material.dart';

class HomepageContent extends StatefulWidget {
  final bool isRoundedCorners;
  HomepageContent({required this.isRoundedCorners});
  @override
  State<HomepageContent> createState() => _HomepageContentState();
}

class _HomepageContentState extends State<HomepageContent> {
  PageController _pageController = PageController();
  double percentScroll = 0.0;
  EdgeInsets paddingSymmetricHomepage = EdgeInsets.symmetric(horizontal: 14, vertical: 100);


  @override
  void initState() {
    super.initState();
    _pageController.addListener(updateScrollPercentage);
  }

  void updateScrollPercentage() {
    double screenHeight = MediaQuery.of(context).size.height;
    double newPercentScrolled = (_pageController.position.pixels / screenHeight) * 100;
    if (percentScroll != newPercentScrolled) {
      setState(() {
        percentScroll = newPercentScrolled;
      });
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(updateScrollPercentage);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
        children: [
          AnimatedContainer(
            height: screenHeight,
            width: screenWidth,
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: widget.isRoundedCorners ? BorderRadius.circular(30) : BorderRadius.circular(0),
              color:percentScroll >= 199.99 ? Colors.black : ((percentScroll >= 99.99) ? Colors.white : Color.fromRGBO(130, 183, 229,1)) ,
            ),
          ),
          AnimatedContainer(
            height: (percentScroll >= 199.99) ? screenHeight : screenHeight*0.6,
            width: screenWidth,
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: widget.isRoundedCorners ? BorderRadius.circular(30) : BorderRadius.circular(0),
              image: DecorationImage(
                image:AssetImage("assets/backgrounds/HomePage/wave4.png"),
                fit: BoxFit.cover,
              ) ,
            ),
          ),
          AnimatedContainer(
            height: (percentScroll >= 99.99) ? screenHeight*0.99 : screenHeight*0.6,
            width: screenWidth,
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: widget.isRoundedCorners ? BorderRadius.circular(30) : BorderRadius.circular(0),
              image: (percentScroll <= 199.99) ? DecorationImage(
                image:AssetImage("assets/backgrounds/HomePage/wave3.png"),
                fit: BoxFit.cover,
              ) : null,
            ),
          ),

          AnimatedContainer(
            height: (percentScroll >= 99.99) ? screenHeight*0.9 : screenHeight,
            width: screenWidth,
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: widget.isRoundedCorners ? BorderRadius.circular(30) : BorderRadius.circular(0),
              image: (percentScroll <= 99.99) ? DecorationImage(
                image:AssetImage("assets/backgrounds/HomePage/wave2.png"),
                fit: BoxFit.cover,
              ) : null,
            ),
          ),



          Container(
            height: screenHeight,
            width: screenWidth,
            child:  PageView(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              children: [
                Column(
                  children: [
                    Container(
                      height: screenHeight,
                      width: screenWidth,
                      padding: paddingSymmetricHomepage,
                      decoration: BoxDecoration(
                        borderRadius: widget.isRoundedCorners ? BorderRadius.circular(30) : BorderRadius.circular(0),
                        image: DecorationImage(
                          image: AssetImage("assets/backgrounds/HomePage/wave1.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: EnglishContent(),
                    ),
                  ],
                ),
                Column(
                  children: [
                    AnimatedContainer(
                      height: (percentScroll >= 99.99) ? screenHeight*0.93 : screenHeight,
                      width: screenWidth,
                      duration: Duration(milliseconds: 100),
                      decoration: BoxDecoration(
                        borderRadius: widget.isRoundedCorners ? BorderRadius.circular(30) : BorderRadius.circular(0),
                        image: (percentScroll >= 99.99) ? DecorationImage(
                          image:AssetImage("assets/backgrounds/HomePage/wave2.png"),
                          fit: BoxFit.cover,
                        ) : null,
                      ),
                      child: JapaneseContent(),
                    ),
                  ],
                ),

                Column(
                  children: [
                    AnimatedContainer(
                      height: (percentScroll >= 199.99) ? screenHeight*0.93 : screenHeight,
                      width: screenWidth,
                      duration: Duration(milliseconds: 100),
                      decoration: BoxDecoration(
                        borderRadius: widget.isRoundedCorners ? BorderRadius.circular(30) : BorderRadius.circular(0),
                        image: (percentScroll >= 199.99) ? DecorationImage(
                          image:AssetImage("assets/backgrounds/HomePage/wave3.png"),
                          fit: BoxFit.cover,
                        ) : null,
                      ),
                      child: ChineseContent(),
                    ),
                  ],
                ),
                Container(
                  height: screenHeight,
                  width: screenWidth,
                  child: KoreanContent(),
                )
              ],
            ),
          ),

        ],
      );

  }
}


