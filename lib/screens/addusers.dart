import 'dart:io';
import 'package:path/path.dart';
import 'package:login_signup_ui_starter/screens/mainpage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_signup_ui_starter/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/primary_button.dart';

class AddUser extends StatefulWidget{
  @override
  AddUserScreen createState() => AddUserScreen();
}

class AddUserScreen extends State<AddUser> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String designation = "Student";
  String profilepicurl;
  var _name, _email, _phone, _moodle;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final moodleController = TextEditingController();

  File _imageFile;
  final picker = ImagePicker();
  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

   adduser() {
    if (_formKey.currentState.validate()) {
      setState(() {
        _name = nameController.text;
        _email = emailController.text;
        _phone = phoneController.text;
        _moodle = moodleController.text;

        Map<String, dynamic> data = {
          "name": _name,
          "email": _email,
          "phone": _phone,
          "moodle id": _moodle,
          "designation": designation,
          "profilepicurl" : profilepicurl
        };
        CollectionReference collectionReference = FirebaseFirestore.instance
            .collection('users');
        collectionReference.add(data);
        cleartext();
      });

    }
  }

  cleartext(){
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    moodleController.clear();
  }

  Future<String> uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_imageFile.path);
    String value;
    Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(
        'profilepictures/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    /*taskSnapshot.ref.getDownloadURL().then(
          (value) => print("Don   e: $value"),
    );*/

    taskSnapshot.ref.getDownloadURL().then((fileURL) {
      value = fileURL;
    });

    return value;

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
                  height: 50,
                ),
                Padding(
                  padding: kDefaultPadding,
                  child: Text(
                    'Add Users',
                    style: titleText,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.zero,
                  child: Form(
                    key: _formKey,
                    child: Column(
                        children: [
                          Container(height: 250,
                            child: ClipRRect(
                              child: _imageFile != null
                                  ? Image.file(_imageFile)
                                  : TextButton(onPressed: pickImage, child: Icon(Icons.add_a_photo,size: 50, color: kPrimaryColor,)),
                            ),
                          ),
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
                            controller: nameController,
                            // onSaved: (input) => _name = input,
                          ),
                          TextFormField(
                            validator: (input) {
                              if (input == null || input.isEmpty) {
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
                            controller: emailController,
                            // onSaved: (input) => _email = input,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.numberWithOptions(),
                            maxLength: 10,
                            obscureText: false,
                            validator: (input) {
                              if (input.length < 6) {
                                return 'Provide Minimum 6 Character';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              counterText: "",
                              labelText: "Phone Number",
                              prefixIcon: Icon(Icons.phone),
                              labelStyle: TextStyle(
                                color: kTextFieldColor,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: kPrimaryColor),
                              ),
                            ),
                            controller: phoneController,
                            // onSaved: (input) => _phone = input,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.numberWithOptions(),
                            maxLength: 10,
                            obscureText: false,
                            validator: (input) {
                              if (input.length < 6) {
                                return 'Provide Minimum 6 Character';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              counterText: "",
                              labelText: "Moodle ID",
                              prefixIcon: Icon(Icons.badge),
                              labelStyle: TextStyle(
                                color: kTextFieldColor,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: kPrimaryColor),
                              ),
                            ),
                            controller: moodleController,
                            // onSaved: (input) => _moodle = input,
                          ),
                          RadioListTile(
                            title: Text('Student'),
                            value: "Student",
                            groupValue: designation,
                            onChanged: (value) {
                              setState(() {
                                designation = value.toString();
                              });
                            },
                          ),
                          RadioListTile(
                            title: Text('Staff'),
                            value: "Staff",
                            groupValue: designation,
                            onChanged: (value) {
                              setState(() {
                                designation = value.toString();
                              });
                            },
                          ),
                        ]
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.zero,
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () async{
                            String url = await uploadImageToFirebase(context);
                            print(url);
                            await adduser();
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: PrimaryButton(buttonText: 'Add $designation')
                      )
                    ],
                  ),
                ),

              ],
          ),
      ),
    ),
    );
  }
}


