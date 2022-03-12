import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signup_ui_starter/theme.dart';

import '../screens/mainpage.dart';

class LogInForm extends StatefulWidget {
  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email, _password;
  checkAuthentication() async
  {
    _auth.authStateChanges().listen((user) {

      if(user!= null){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Mainpage()));
      }
    });

    @override
    void initState() {
      super.initState();
      this.checkAuthentication();
    }
  }


  bool _isObscure = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildInputForm('Email', false),
          buildInputForm('Password', true),
        ],
      ),
    );
  }

  Padding buildInputForm(String label, bool pass) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: pass ? passController : emailController,
        obscureText: pass ? _isObscure : false,
        decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              color: kTextFieldColor,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor),
            ),
        ),
      ),
    );
  }
}
