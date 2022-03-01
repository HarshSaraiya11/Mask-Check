import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_signup_ui_starter/screens/login.dart';
import 'package:login_signup_ui_starter/theme.dart';
import 'package:login_signup_ui_starter/widgets/checkbox.dart';
import 'package:login_signup_ui_starter/widgets/login_option.dart';
import 'package:login_signup_ui_starter/widgets/primary_button.dart';
import 'package:login_signup_ui_starter/widgets/signup_form.dart';

class MainScreen extends StatelessWidget{
  @override
  
  Widget build(BuildContext context) {
    var list = List<String>.generate(100, (i) => 'Item $i');
    return Scaffold(
      body: Container(
        color: Colors.white,
        child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(title: Text("Unmasked Persons"),
              backgroundColor: kPrimaryColor,
              ),
              Padding(
                padding: kDefaultPadding
              ),

              Flexible(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  // shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context, index)
                  {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/profile_image.png'),
                        backgroundColor: kPrimaryColor,
                      ),
                      title: Text(list[index]),
                      subtitle: Text("was seen not wearing a mask in the college premises!"),
                    );
                  },
                ),
              )
              
            ],
          ),
      ),
    );
  }
}