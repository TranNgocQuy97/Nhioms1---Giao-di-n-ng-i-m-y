import 'package:athena/LoginAndSignup/Components/LoginForm.dart';
import 'package:athena/LoginAndSignup/Components/SignUpForm.dart';
import 'package:flutter/material.dart';

class Functions {
  static void showLoginGeneralDialog(BuildContext context) {
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "Login",
      context: context,
      transitionDuration: Duration(milliseconds: 500),
      transitionBuilder: (_, animation, __, child) {
        Tween<Offset> tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        return SlideTransition(
          position: tween.animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          ),
          child: child,
        );
      },
      pageBuilder: (context, _, __) => LoginForm(),
    );
  }
  static void showSignUpGeneralDialog(BuildContext context) {
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "Sign Up",
      context: context,
      transitionDuration: Duration(milliseconds: 500),
      transitionBuilder: (_, animation, __, child) {
        Tween<Offset> tween = Tween(begin: Offset(0, -1), end: Offset.zero);
        return SlideTransition(
          position: tween.animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          ),
          child: child,
        );
      },
      pageBuilder: (context, _, __) => SignUpForm(),
    );
  }
}
