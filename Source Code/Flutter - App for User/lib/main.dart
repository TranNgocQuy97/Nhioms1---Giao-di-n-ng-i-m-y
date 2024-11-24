import 'package:athena/LoginAndSignup/LoginAndSignup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
        '/': (context) => LoginAndSignup(), // Trang đăng ký
        '/home': (context) => HomeLog(), // Trang Home
      },
    );
  }
}


class HomeLog extends StatefulWidget {
  const HomeLog({Key? key}) : super(key:key);
  @override
  State<HomeLog> createState() => _HomeLog();
}

class _HomeLog extends State<HomeLog> {

  Future<FirebaseApp> _initializeFirebase() async{
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeFirebase(),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          return LoginAndSignup();
        }
        return const Center( child: CircularProgressIndicator(),);
      } ,
    );
  }
}

