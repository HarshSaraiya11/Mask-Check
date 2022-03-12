import 'package:flutter/material.dart';
import 'package:login_signup_ui_starter/screens/reset_password.dart';
import 'package:login_signup_ui_starter/screens/signup.dart';
import 'package:login_signup_ui_starter/theme.dart';
import 'package:login_signup_ui_starter/widgets/login_form.dart';
import 'package:login_signup_ui_starter/widgets/primary_button.dart';
import 'package:login_signup_ui_starter/screens/mainpage.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Login extends StatefulWidget{
  @override
  LogInScreen createState() => LogInScreen();
}

class LogInScreen extends State<Login> {
  
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
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
  }

  login() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);
      } catch (e) {
        showError(e.message);
        print(e);
      }
    }
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: kDefaultPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 150,
              ),
              Image.asset('assets/images/itdeptlogo.png'),
              Text(
                'Welcome Back',
                style: titleText,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    'New to this app?',
                    style: subTitle,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUp(),
                        ),
                      );
                    },
                    child: Text(
                      'Sign In',
                      style: textButton.copyWith(
                        decoration: TextDecoration.underline,
                        decorationThickness: 1,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              // LogInForm(),
              Form(
                key: _formKey,
                child:Column(
                  children: [
                    TextFormField(
                    validator: (input) {
                      if ( input == null  || input.isEmpty){
                        return 'Enter Email';
                      }
                      return null;
                    },
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email),
                      labelStyle: TextStyle(
                        color: kTextFieldColor,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor),
                      ),
                    ),
                      onSaved: (input) => _email = input,
                  ),
                    TextFormField(
                      obscureText: true,
                      validator: (input) {
                        if (input.length < 6) {
                          return 'Provide Minimum 6 Character';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: Icon(Icons.lock),
                        labelStyle: TextStyle(
                          color: kTextFieldColor,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryColor),
                        ),
                      ),
                      onSaved: (input) => _password = input,
                    ),
                  ]
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResetPasswordScreen()));
                },
                child: Text(
                  'Forgot password?',
                  style: TextStyle(
                    color: kZambeziColor,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                    decorationThickness: 1,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            Padding(
              padding:kDefaultPadding,
              child: GestureDetector(
              onTap: login,
                child: PrimaryButton(buttonText: 'Log In'),
            ))],
          ),
        ),
      ),
    );
  }
}
