import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:vibration/vibration.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:athena/Classes/Functions.dart';
import 'package:athena/Classes/ShowNotification.dart';

class RecoverPasswordTextFormField extends StatefulWidget {
  const RecoverPasswordTextFormField({
    Key? key,
  }) : super(key: key);

  @override
  State<RecoverPasswordTextFormField> createState() =>
      _RecoverPasswordTextFormFieldState();
}

class _RecoverPasswordTextFormFieldState
    extends State<RecoverPasswordTextFormField> {
  final TextEditingController _emailController = TextEditingController();
  bool isValidEmail(String email) {
    return isEmail(email);
  }

  Future<void> sendPasswordResetEmail(BuildContext context, String email) async {
    try {
      List<String> signInMethods =
      await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (signInMethods.isNotEmpty) {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        ShowNotification.showAnimatedSnackBar(
          context,
          "Password recovery link has been sent to your email.",
          0,
        );
      } else {
        ShowNotification.showAnimatedSnackBar(
          context,
          "Email does not exist.\n",
          0,
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = "The email address is not valid.";
          break;
        case 'user-not-found':
          errorMessage = "Email does not exist in our records.";
          break;
        default:
          errorMessage = "Unexpected error: ${e.message}";
      }
      ShowNotification.showAnimatedSnackBar(context, errorMessage, 0);
    } catch (e) {
      // Xử lý lỗi không mong muốn
      ShowNotification.showAnimatedSnackBar(
        context,
        "An unexpected error occurred: $e",
        3,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
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
                    children: const [
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
                          controller: _emailController,
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(210, 210, 210, 1),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
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
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTapDown: (TapDownDetails details) async {
                      if (await Vibration.hasVibrator() ?? false) {
                        Vibration.vibrate(duration: 50);
                      }
                      await Future.delayed(const Duration(milliseconds: 200));
                      Navigator.pop(context);
                      await Future.delayed(const Duration(milliseconds: 300));
                      Functions.showLoginGeneralDialog(context);
                      print("Click login");
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 50),
                      width: 100,
                      height: 55,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(74, 98, 138, 1),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTapDown: (TapDownDetails details) async {
                      if (await Vibration.hasVibrator() ?? false) {
                        Vibration.vibrate(duration: 50);
                      }
                      print("Click Send");
                      await sendPasswordResetEmail(
                          context, _emailController.text.trim());
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 50),
                      width: 150,
                      height: 55,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(142, 172, 205, 1),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(25),
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "Send",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
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
