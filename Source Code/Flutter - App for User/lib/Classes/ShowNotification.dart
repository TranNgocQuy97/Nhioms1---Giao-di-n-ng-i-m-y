import 'package:flutter/material.dart';



class ShowNotification {
  static void showAnimatedSnackBar(BuildContext context, String message, String Type) {
    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => _AnimatedSnackBar(
        errorMessage: message,
        overlayEntry: overlayEntry,
        Type: Type,
      ),
    );
    Overlay.of(context)?.insert(overlayEntry);
  }
}





class _AnimatedSnackBar extends StatefulWidget {
  final String errorMessage;
  final OverlayEntry overlayEntry;
  final String Type;
  const _AnimatedSnackBar({
    required this.errorMessage,
    required this.overlayEntry,
    required this.Type,
  });
  @override
  __AnimatedSnackBarState createState() => __AnimatedSnackBarState();
}

class __AnimatedSnackBarState extends State<_AnimatedSnackBar>
    with SingleTickerProviderStateMixin {

  double _rightPosition = -400;
  double _opacity = 1;

  @override
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      if (!mounted) return;
      setState(() {
        _rightPosition = 40;
      });
      Future.delayed(Duration(milliseconds: 300), () {
        if (!mounted) return;
        setState(() {
          _rightPosition = 10;
        });
      });
    });
    Future.delayed(Duration(milliseconds: 3000), () {
      Future.delayed(Duration(milliseconds: 300), () {
        if (!mounted) return;
        setState(() {
          _rightPosition = 40;
        });
        Future.delayed(Duration(milliseconds: 300), () {
          if (!mounted) return;
          setState(() {
            _opacity = 0.2;
          });
          Future.delayed(Duration(milliseconds: 300), () {
            if (!mounted) return;
            setState(() {
              _rightPosition = -400;
            });
          });
        });
      });
    });

    Future.delayed(Duration(milliseconds: 4000), () {
      if (!mounted) return;
      widget.overlayEntry.remove();
    });
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      top: MediaQuery.of(context).padding.top + 10,
      right: _rightPosition,
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 300),
        opacity: _opacity,
        child: Material(
          color: Colors.transparent,
          child: Container(
            height: 65,
            width: 230,
            child: Stack(
              children: [
                Container(
                  height: 65,
                  width: 230,
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(200, 0, 0, 1),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                        width: 30,
                        child: Image.asset(
                          "assets/backgrounds/Notifications/deadface.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Oh snap!",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              widget.errorMessage,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
