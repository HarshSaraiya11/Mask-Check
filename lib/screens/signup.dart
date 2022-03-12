import 'package:flutter/material.dart';
import 'package:login_signup_ui_starter/screens/login.dart';
import 'package:login_signup_ui_starter/theme.dart';
import 'package:login_signup_ui_starter/widgets/primary_button.dart';
import 'package:login_signup_ui_starter/widgets/signup_form.dart';
import 'package:login_signup_ui_starter/screens/mainpage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget{
  @override
  SignUpScreen createState() => SignUpScreen();
}
class SignUpScreen extends State<SignUp> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name, _email, _password;

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

  signUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        if (user != null) {
          // UserUpdateInfo updateuser = UserUpdateInfo();
          // updateuser.displayName = _name;
          //  user.updateProfile(updateuser);
          await _auth.currentUser.updateProfile(displayName: _name);
          // await Navigator.pushReplacementNamed(context,"/") ;

        }
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
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
              ),
              Padding(
                padding: kDefaultPadding,
                child: Image.asset('assets/images/itdeptlogo.png'),
              ),
              Padding(
                padding: kDefaultPadding,
                child: Text(
                  'Create Account',
                  style: titleText,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: kDefaultPadding,
                child: Row(
                  children: [
                    Text(
                      'Already a member?',
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
                                builder: (context) => Login()));
                      },
                      child: Text(
                        'Log In',
                        style: textButton.copyWith(
                          decoration: TextDecoration.underline,
                          decorationThickness: 1,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: kDefaultPadding,
                child: Form(
                  key: _formKey,
                  child:Column(
                      children: [
                        TextFormField(
                          validator: (input) {
                            if (input.isEmpty) return 'Enter Name';
                            return null;
                          },
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: "Name",
                            prefixIcon: Icon(Icons.person),
                            labelStyle: TextStyle(
                              color: kTextFieldColor,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: kPrimaryColor),
                            ),
                          ),
                          onSaved: (input) => _name = input,
                        ),
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
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: kDefaultPadding,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: signUp,
                        child: PrimaryButton(buttonText: 'Sign Up')

                    )
                  ],
                ),
              ),
              // SizedBox(
              //   height: 20,
              // ),
              // Padding(
              //   padding: kDefaultPadding,
              //   child: Text(
              //     'Or log in with:',
              //     style: subTitle.copyWith(color: kBlackColor),
              //   ),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // Padding(
              //   padding: kDefaultPadding,
              //   child: LoginOption(),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
