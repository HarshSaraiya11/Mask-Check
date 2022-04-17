import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:login_signup_ui_starter/theme.dart';
import 'package:login_signup_ui_starter/screens/mainpage.dart';
import 'package:intl/intl.dart';


class Guest extends StatefulWidget{
  @override
  GuestProfile createState() => GuestProfile();
}


class GuestProfile extends State<Guest> {

  void initState() {
    super.initState();
    // FirebaseMessaging messaging = FirebaseMessaging.instance;
    // messaging.getToken().then((value){
    //   print(value);
    // });
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   // print("message recieved while on foreground");
    //   // print('Message data: ${message.data}');
    //   // print(message.notification.body);
    //   var received = message.data;
    //   @override
    //   Widget build(BuildContext context) {
    //     return Scaffold(
    //       body: Padding(
    //         padding: kDefaultPadding,
    //         child: SingleChildScrollView(
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               SizedBox(
    //                 height: 50,
    //               ),
    //               Text(received['name'])
    //             ],
    //           ),
    //         ),
    //       ),
    //     );
    //   }
    // });

    // FirebaseMessaging.onMessageOpenedApp.listen((message)  {
    //   var received = message.data;
    //   @override
    //   Widget build(BuildContext context) {
    //     return Scaffold(
    //       body: Padding(
    //         padding: kDefaultPadding,
    //         child: SingleChildScrollView(
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               SizedBox(
    //                 height: 50,
    //               ),
    //               Text(received['name'])
    //             ],
    //           ),
    //         ),
    //       ),
    //     );
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    // final  Map<String, dynamic>rcvdData = ModalRoute.of(context).settings.arguments;
    List<dynamic> rcvdData = ModalRoute.of(context).settings.arguments;
    // Map<String, dynamic>stream = ModalRoute.of(context).settings.arguments;
    // List<dynamic> stream = ModalRoute.of(context).settings.arguments;
    // var datetime = DateFormat.yMd().add_jm().format(stream[0].toDate);
    // print(datetime);
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
                        child: CircleAvatar(
                          foregroundImage: NetworkImage(rcvdData[0]['profilepicurl']),
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
                        '${rcvdData[0]['name']}',
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
                            title: Text('${rcvdData[0]['designation']}',textAlign: TextAlign.right,),
                          ),
                          Divider(indent:10,endIndent: 10,),
                          ListTile(
                            leading: Text("Moodle ID", textAlign: TextAlign.left,),
                            title: Text('${rcvdData[0]['moodle id']}',textAlign: TextAlign.right,),
                          ),
                          Divider(thickness: 1,indent:10,endIndent: 10,),
                          ListTile(
                            leading: Text("Email", textAlign: TextAlign.left,),
                            title: Text('${rcvdData[0]['email']}',textAlign: TextAlign.right,),
                          ),
                          Divider(thickness: 1,indent:10,endIndent: 10,),
                          ListTile(
                            leading: Text("Phone", textAlign: TextAlign.left,),
                            title: Text('${rcvdData[0]['phone']}',textAlign: TextAlign.right,),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: kDefaultPadding,
                      child: Text(
                        'on ${rcvdData[1]}',
                        style: subTitle,
                      ),
                    ),
                  ],
                ),
              ),

    );
  }
}