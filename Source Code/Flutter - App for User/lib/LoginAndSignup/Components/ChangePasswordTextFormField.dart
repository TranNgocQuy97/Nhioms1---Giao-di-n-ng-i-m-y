import 'package:athena/Classes/Functions.dart';
import 'package:athena/Classes/ShowNotification.dart';
import 'package:athena/LoginAndSignup/FirebaseAuthenticationFunctions/FirebaseAuthenticationFunctions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';


class ChangePasswordTextFormField extends StatefulWidget{
  const ChangePasswordTextFormField({super.key});
  @override
  State<ChangePasswordTextFormField> createState() => _ChangePasswordTextFormFieldState();
}

class _ChangePasswordTextFormFieldState extends State<ChangePasswordTextFormField> {
  final TextEditingController _email_controller = TextEditingController();
  final TextEditingController _oldPassword_controller = TextEditingController();
  final TextEditingController _newPassword_controller = TextEditingController();
  final TextEditingController _confirmNewPassword_controller = TextEditingController();
  bool _isPressedLogin = false;
  bool _isObscured = true;
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
  bool _isObscured3 = true;
  void _toggleObscureText3() {
    setState(() {
      _isObscured3 = !_isObscured3;
    });
  }

  Future<void> changePasswordWithEmail({
    required String email,
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('Không có người dùng đăng nhập.');
        return;
      }
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(credential);
      print('Xác thực thành công.');
      await user.updatePassword(newPassword);
      print('Đổi mật khẩu thành công.');
      await FirebaseAuth.instance.signOut();
      print('Người dùng đã được đăng xuất.');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        print('Mật khẩu hiện tại không đúng.');
      } else if (e.code == 'user-not-found') {
        print('Không tìm thấy người dùng với email này.');
      } else if (e.code == 'requires-recent-login') {
        print('Yêu cầu đăng nhập lại để đổi mật khẩu.');
      } else {
        print('Đổi mật khẩu thất bại: ${e.message}');
      }
    } catch (e) {
      print('Có lỗi xảy ra: $e');
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(248, 250, 255, 0),
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
                        "Old password",
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
                          obscureText: _isObscured3,
                          controller: _oldPassword_controller,
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
                              icon: Icon(_isObscured3 ? Icons.visibility : Icons.visibility_off,),
                              onPressed: () async {
                                if (await Vibration.hasVibrator() ?? false) {
                                  Vibration.vibrate(duration: 50);
                                }
                                _toggleObscureText3();
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
                                    "assets/icons/oldkey.png",
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
                        "New password",
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
                          controller: _newPassword_controller,
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
                        "Confirm new password ",
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
                          controller: _confirmNewPassword_controller,
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
            SizedBox(height: 10,),
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

                      // onTap: (){
                      //   testSaveToDatabase();
                      // },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 50),
                        width: 100,
                        height: 55,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(142, 172, 205, 1) ,

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
                      onTap: () async {

                        if (!FirebaseAuthenticationFunctions.arePasswordsIdentical(_newPassword_controller.text,_confirmNewPassword_controller.text) ) {
                          ShowNotification.showAnimatedSnackBar(context,"Password and Confirm password again are not the same.", 0);
                          if(!FirebaseAuthenticationFunctions.isPasswordStrong(_confirmNewPassword_controller.text)){
                            ShowNotification.showAnimatedSnackBar(
                                context,
                                "Password required: \n"
                                    "At least 1 uppercase character\n"
                                    "At least 1 digit\n"
                                    "6–16 characters",
                                1
                            );
                            return;
                          }
                          return;
                        }

                        await changePasswordWithEmail(
                          email: _email_controller.text,
                          currentPassword: _oldPassword_controller.text,
                          newPassword: _newPassword_controller.text,
                        );

                        Navigator.pop(context);


                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 50),
                        width: 150,
                        height: 55,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(74, 98, 138, 1),
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
                              "Confirm",
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
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}