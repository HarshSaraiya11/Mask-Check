import 'package:flutter/material.dart';
import 'package:login_signup_ui_starter/screens/guestprofile.dart';
import 'package:login_signup_ui_starter/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_signup_ui_starter/screens/mainpage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: Mainpage(),
      routes: {
        '/guest': (context) => Guest(),
      },
    );
  }
}
