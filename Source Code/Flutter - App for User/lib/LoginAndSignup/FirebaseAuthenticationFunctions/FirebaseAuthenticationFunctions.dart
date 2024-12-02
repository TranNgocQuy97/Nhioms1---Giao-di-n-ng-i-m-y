import 'package:flutter/material.dart';


class FirebaseAuthenticationFunctions {
  static bool arePasswordsIdentical(String password1, String password2) {
    return password1 == password2;
  }
  static bool isPasswordStrong(String password) {
    if (password.length < 6 || password.length > 16 ) return false;
    bool hasUpperCase = password.contains(RegExp(r'[A-Z]'));
    bool hasNumber = password.contains(RegExp(r'[0-9]'));
    return hasUpperCase && hasNumber;
  }
}