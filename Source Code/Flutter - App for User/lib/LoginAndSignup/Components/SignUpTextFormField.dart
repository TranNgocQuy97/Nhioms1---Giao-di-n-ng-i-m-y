import 'package:athena/Classes/Functions.dart';
import 'package:athena/Classes/ShowNotification.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:validators/validators.dart';

class SignUpTextFormField extends StatefulWidget {
  const SignUpTextFormField({
    Key ? key,
  }) : super(key:key);
  @override
  State<SignUpTextFormField> createState() => _SignUpTextFormFieldState();
}

class _SignUpTextFormFieldState extends State<SignUpTextFormField> {
  final TextEditingController _name_controller = TextEditingController();
  final TextEditingController _email_controller = TextEditingController();
  final TextEditingController _phoneNumber_controller = TextEditingController();
  final TextEditingController _password_controller = TextEditingController();
  final TextEditingController _passwordAgain_controller = TextEditingController();
  bool _isPressedLogin = false;
  bool _isPressedSignUp = false;

  // check pass và passagain
  bool arePasswordsIdentical(String password1, String password2) {
    return password1 == password2;
  }
  bool isPasswordStrong(String password) {
    if (password.length < 6 || password.length > 16 ) return false;
    bool hasUpperCase = password.contains(RegExp(r'[A-Z]'));
    bool hasNumber = password.contains(RegExp(r'[0-9]'));
    return hasUpperCase && hasNumber;
  }

  bool isValidEmail(String email) {
    return isEmail(email);
  }



  int checkValidPhoneNumber(String phoneNumber) {
    if (phoneNumber.length < 9 || phoneNumber.length > 11) {
      return 911;
    }
    if (!RegExp(r'^(03|05|07|08|09)').hasMatch(phoneNumber)) {
      return 305;
    }
    return 1;
  }







  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  void testSaveToDatabase() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/test_user");
    await ref.set({
      "name": "Test User",
      "email": "testuser@example.com",
      "phoneNumber": "123456789",
      "createdAt": DateTime.now().toIso8601String(),
    }).then((_) {
      print("Test data saved successfully!");
    }).catchError((error) {
      print("Failed to save test data: $error");
    });
  }

  Future<String?> signUpWithEmailAndPass(String email, String pass, String name, String phoneNum) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      User? user = credential.user;
      if (user != null) {
        await user.updateDisplayName(name);
        await user.reload();
        await _database.child("users/${user.uid}").set({
          "uid": user.uid,
          "email": email,
          "name": name,
          "phoneNumber": phoneNum,
          "createdAt": DateTime.now().toIso8601String(),
        }).then((_) {
          print("User data saved to /users/${user.uid}");
        }).catchError((error) {
          print("Failed to save user data: $error");
        });
        return null;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        ShowNotification.showAnimatedSnackBar(context, "Email đã được sử dụng bởi tài khoản khác", 0);
        return 'Email đã được sử dụng bởi tài khoản khác.';
      } else if (e.code == 'weak-password') {
        return 'Mật khẩu quá yếu.';
      } else if (e.code == 'invalid-email') {
        return 'Email không hợp lệ.';
      } else {
        return 'Đã xảy ra lỗi: ${e.message}';
      }
    } catch (e) {
      return 'Đã xảy ra lỗi không xác định: $e';
    }
    return 'Đăng ký không thành công. Vui lòng thử lại.';
  }




  @override
  void dispose() {
    _name_controller.dispose();
    _email_controller.dispose();
    _phoneNumber_controller.dispose();
    _password_controller.dispose();
    _passwordAgain_controller.dispose();
    super.dispose();
  }


  bool _isObscured = true;
  @override
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 250, 255, 0),
      resizeToAvoidBottomInset: false,
      body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                            "Name",
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
                              controller: _name_controller,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(25),
                              ],
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
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(100),
                              ],
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
                Container(
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Phone Number",
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
                              controller: _phoneNumber_controller,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(11),
                              ],
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
                                        "assets/icons/phoneNumber.png",
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
                Container(
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Password again",
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
                              controller: _passwordAgain_controller,
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
              ],
            ),
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
                        if(isValidEmail == false) {
                          ShowNotification.showAnimatedSnackBar(context,"Invalid email \n", 0);
                          return;
                        }
                        if (!arePasswordsIdentical(_password_controller.text, _passwordAgain_controller.text)) {
                          ShowNotification.showAnimatedSnackBar(context,"Password and Password \n again are not the same.", 0);
                          if(isPasswordStrong(_passwordAgain_controller.text)){
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
                        if(checkValidPhoneNumber(_phoneNumber_controller.text) != 1){
                          if (checkValidPhoneNumber(_phoneNumber_controller.text) == 911) {
                            ShowNotification.showAnimatedSnackBar(context, "Phone number: Minimum 9 numbers and maximum 11 numbers", 0);
                            return;
                          }
                          if (checkValidPhoneNumber(_phoneNumber_controller.text) == 305) {
                            ShowNotification.showAnimatedSnackBar(context, "Phone number must start \n with numbers: 03|05|07|08|09", 0);
                            return;
                          }
                          return;
                        }

                        signUpWithEmailAndPass(
                          _email_controller.text.trim(),
                          _password_controller.text.trim(),
                          _name_controller.text.trim(),
                          _phoneNumber_controller.text.trim(),
                        );
                        ShowNotification.showAnimatedSnackBar(context, "Create account successfully", 3);
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
                              "Sign Up",
                              style: TextStyle(
                                fontSize: _isPressedSignUp ? 17 : 18,
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