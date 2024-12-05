import 'package:athena/HomePage/HomePage.dart';
import 'package:athena/LoginAndSignup/LoginAndSignup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase App',
      initialRoute: '/',
      routes: {
        '/': (context) => CheckAuth(), // Trang kiểm tra trạng thái đăng nhập
        '/login': (context) => LoginAndSignup(), // Trang đăng nhập
        '/home': (context) => HomePage(), // Trang Home
      },
    );
  }
}

/// Kiểm tra trạng thái đăng nhập và điều hướng
class CheckAuth extends StatefulWidget {

  @override
  State<CheckAuth> createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {


  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    bool isLoading = true;
    // Kiểm tra nếu người dùng đã đăng nhập
    if (user != null) {
      Future.microtask(() {
        Navigator.pushReplacementNamed(context, '/home');
      });
    } else {
      Future.microtask(() {
        Navigator.pushReplacementNamed(context, '/login');
      });
    }

    return Scaffold(
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Text("Redirecting..."),
      ),
    );
  }
}

