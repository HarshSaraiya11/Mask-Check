import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_signup_ui_starter/screens/addusers.dart';
import 'package:login_signup_ui_starter/screens/login.dart';
import 'package:login_signup_ui_starter/theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'guestprofile.dart';

class Mainpage extends StatefulWidget{
  @override
  _MainScreen createState() => _MainScreen();
}

class _MainScreen extends State<Mainpage>{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin= false;
  Stream collectionStream = FirebaseFirestore.instance.collection('notifications').orderBy('time', descending: true).snapshots();

  checkAuthentication() async{

    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));      }
    });
  }

  getUser() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  signOut() async {
    _auth.signOut();

    // final googleSignIn = GoogleSignIn();
    // await googleSignIn.signOut();
  }

  adduser() async {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> AddUser()));
  }

  catchData() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message)
    {
      print("message received while on foreground");
      print('Message data: ${message.data}');
      print(message.notification.body);
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
    this.getUser();
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value){
      print(value);
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("message received while on foreground");
      print('Message data: ${message.data}');
      print(message.notification.body);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) async{
      var received = message.data;
      var time = message.sentTime;
      Navigator.pushNamed(context, '/guest', arguments: received);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: !isloggedin? Center(
            child: CircularProgressIndicator()):
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(title: Text("Hello ${user.displayName}"),
              backgroundColor: kPrimaryColor,
                actions: [PopupMenuButton(icon: Icon(Icons.more_horiz),itemBuilder: (context) =>
                  [PopupMenuItem(value: 1,child: TextButton(onPressed: adduser,child: Text("Add entries", style: TextStyle(color: kBlackColor),),)),
                  PopupMenuItem(value: 2,child: TextButton(onPressed: signOut,child: Text("SignOut", style: TextStyle(color: kBlackColor),),))]),],
              ),
              Flexible(
                child: StreamBuilder<QuerySnapshot>(
                    stream: collectionStream,
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                      if (!snapshot.hasData) {
                        return Container(
                          padding: kDefaultPadding,
                          child: Center(child: Text("No one is detected without mask",style: subTitle)),);
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return ListView(scrollDirection: Axis.vertical,shrinkWrap: true,
                          children: snapshot.data.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                        return ListTile(
                            leading: CircleAvatar(
                                      backgroundImage: AssetImage("assets/images/profile_image.png"),
                                      foregroundImage: NetworkImage(data['profilepicurl']),
                                      backgroundColor: kPrimaryColor,
                                      radius: 25,
                                    ),
                          title: Text(data['name']),
                          subtitle: Column(
                            children: [
                              Text(data['text']),
                              // Text(DateFormat.yMd().add_jm().add_E().format(data['time'].toDate())),
                            ],
                          ),
                        trailing: Text(DateFormat.Md().add_jm().format(data['time'].toDate())),
                        onTap: () => Navigator.pushNamed(context, '/guest', arguments: data));
                      }).toList(),
                      );
                    },
                ),
              )
              ],
          ),
      ),
    );
  }

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    print("Handling a background message: ${message.messageId}");
  }
}