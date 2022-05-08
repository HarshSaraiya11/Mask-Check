import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:login_signup_ui_starter/theme.dart';
import 'package:login_signup_ui_starter/screens/mainpage.dart';
import 'package:intl/intl.dart';
import 'mainpage.dart';
class Guest extends StatefulWidget{
  @override
  GuestProfile createState() => GuestProfile();
}
class GuestProfile extends State<Guest> {
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> rcvdData = ModalRoute.of(context).settings.arguments;
    return Scaffold(
          body: Container(
              padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    AppBar(title: Text("Notification Alert"),
                      backgroundColor: kPrimaryColor,),
                    Flexible(
                      child: Container(
                        color: kPrimaryColor,
                        padding: EdgeInsets.fromLTRB(125, 30, 125, 50),
                        child: CircleAvatar(foregroundImage: NetworkImage(rcvdData['profilepicurl']),
                          radius: 75,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: kDefaultPadding,
                      child: Text(
                        '${rcvdData['name']}',
                        style: primary,
                      ),
                    ),
                    Text("was caught without wearing a mask."),
                    SizedBox(
                      height: 20,
                    ),
                    Card(
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      shadowColor: Colors.black,
                      elevation: 5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Text("Designation", textAlign: TextAlign.left,),
                            title: Text('${rcvdData['designation']}',textAlign: TextAlign.right,),
                          ),
                          Divider(indent:10,endIndent: 10,),
                          ListTile(
                            leading: Text("Moodle ID", textAlign: TextAlign.left,),
                            title: Text('${rcvdData['moodle id']}',textAlign: TextAlign.right,),
                          ),
                          Divider(thickness: 1,indent:10,endIndent: 10,),
                          ListTile(
                            leading: Text("Email", textAlign: TextAlign.left,),
                            title: Text('${rcvdData['email']}',textAlign: TextAlign.right,),
                          ),
                          Divider(thickness: 1,indent:10,endIndent: 10,),
                          ListTile(
                            leading: Text("Phone", textAlign: TextAlign.left,),
                            title: Text('${rcvdData['phone']}',textAlign: TextAlign.right,),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
    );
  }
}