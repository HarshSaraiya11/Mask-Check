import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_signup_ui_starter/screens/addusers.dart';
import 'package:login_signup_ui_starter/screens/login.dart';
import 'package:login_signup_ui_starter/theme.dart';
import 'package:login_signup_ui_starter/widgets/primary_button.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Mainpage extends StatefulWidget{
  @override
  _MainScreen createState() => _MainScreen();
}

class _MainScreen extends State<Mainpage>{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin= false;

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
      print(time);
      Navigator.pushNamed(context, '/guest', arguments: [received, time]);
    });
  }

  // Widget _buildStreamBuilder(){
  //   return Scaffold(
  //     body: Padding(
  //       padding: kDefaultPadding,
  //       child: SingleChildScrollView(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             SizedBox(
  //               height: 50,
  //             ),
  //             Text(received['name'])
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    var list = List<String>.generate(100, (i) => 'Item $i');
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
              Padding(
                padding: kDefaultPadding
              ),
              Flexible(
                child: Container(padding: kDefaultPadding,
                  child: Center(child: Text("No one is detected without mask!",style: subTitle)),),
              ),

              // Flexible(
              //   child: ListView.builder(
              //     scrollDirection: Axis.vertical,
              //     // shrinkWrap: true,
              //     itemCount: list.length,
              //     itemBuilder: (context, index)
              //     {
              //       return ListTile(
              //         leading: CircleAvatar(
              //           backgroundImage: AssetImage('assets/images/profile_image.png'),
              //           backgroundColor: kPrimaryColor,
              //           foregroundImage: AssetImage('assets/images/profile_image.png'),
              //         ),
              //         title: Text(list[index]),
              //         subtitle: Text("was seen not wearing a mask in the college premises!"),
              //       );
              //     },
              //   ),
              // )
              
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