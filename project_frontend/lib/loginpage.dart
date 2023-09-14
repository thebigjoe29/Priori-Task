import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_frontend/signup_page.dart';
import 'package:project_frontend/taskpage.dart';
import 'networking_api.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool pass=false;
  var result;
  var logintoken;
  var firstname;
  bool isAuthentication = false;
  bool showMessage = false;
  void showToast(String poop) {
    Fluttertoast.showToast(
      msg: poop,
      toastLength: Toast.LENGTH_LONG, // Duration of the toast (short or long)
      gravity: ToastGravity.CENTER_LEFT, // Toast position (top, center, bottom)
      //timeInSecForIosWeb: 1, // Duration for iOS (in seconds)
      // backgroundColor: Colors.black.withOpacity(0.8), // Background color
      // textColor: Colors.white, // Text color
      // fontSize: 16.0, // Font size
    );
  }

  // void showMessagefunc() {
  //   setState(() {
  //     showMessage = !showMessage;
  //   });
  //   Timer(Duration(seconds: 3), () {
  //     setState(() {
  //       showMessage = !showMessage;
  //     });
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isAuthentication = false;
  }

//Color.fromARGB(190, 1, 23, 33)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: Stack(
        children: [
          Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Priori-Task",
                      style: TextStyle(
                        fontFamily: "Myfont",
                        fontSize: 80,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      )),
                  SizedBox(
                    width: 40,
                  ),
                  Icon(
                    Icons.task_alt,
                    size: 50,
                    color: Colors.teal,
                  )
                ],
              )),
          Positioned(
            top: 200,
            left: 580,
            right: 580,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white.withOpacity(0.9),
              ),
              height: 450,
              width: 25,
            ),
          ),
          Positioned(
              top: 140,
              left: 580,
              right: 580,
              child: Icon(
                CupertinoIcons.circle_fill,
                color: Colors.black,
                size: 130,
              )),
          Positioned(
              top: 160,
              left: 580,
              right: 580,
              child: Icon(
                CupertinoIcons.person_fill,
                size: 80,
                color: Colors.white.withOpacity(0.7),
              )),
          // const Positioned(
          //     top: 220, left: 580,right: 580,child: Center(child: Text("LOGIN",style: TextStyle(fontFamily: "Myfont",fontWeight: FontWeight.normal,fontSize: 30,color: Colors.white),))),
          Positioned(
            top: 330,
            left: 620,
            right: 620,
            child: Center(
              child: TextSelectionTheme(
                data: TextSelectionThemeData(
                  cursorColor:
                      Colors.black, // Change this to your desired cursor color
                  selectionHandleColor: Colors
                      .black, // Change this to your desired selection handle color
                ),
                child: TextField(
                  controller: usernamecontroller,
                  decoration: InputDecoration(

                      // filled: true,
                      // fillColor: Colors.transparent,
                      icon: Container(
                          color: Colors.transparent,
                          child: Icon(
                            CupertinoIcons.person_circle_fill,
                            color: const Color.fromARGB(120, 0, 0, 0),
                          )),
                      labelText: "Username",
                      labelStyle: TextStyle(
                          fontFamily: 'Myfont',
                          color: Color.fromARGB(164, 0, 0, 0)),
                      border: UnderlineInputBorder(),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Color.fromARGB(164, 0, 0, 0),
                      ))),
                ),
              ),
            ),
          ),

          Positioned(
            top: 410,
            left: 620,
            right: 620,
            child: Center(
              child: TextSelectionTheme(
                data: TextSelectionThemeData(
                  cursorColor:
                      Colors.black, // Change this to your desired cursor color
                  selectionHandleColor: Colors
                      .black, // Change this to your desired selection handle color
                ),
                child: TextField(
                  obscureText: !pass,
                  controller: passwordcontroller,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      color: Color.fromARGB(155, 0, 0, 0),
                      iconSize: 20,
                          icon: Icon(
                            pass ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              pass = !pass;
                            });
                          },
                        ),
                      icon: Container(
                          color: Colors.transparent,
                          child: Icon(
                            Icons.lock,
                            color: const Color.fromARGB(120, 0, 0, 0),
                          )),
                      labelText: "Password",
                      labelStyle: TextStyle(
                          fontFamily: 'Myfont',
                          color: Color.fromARGB(164, 0, 0, 0)),
                      border: UnderlineInputBorder(),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Color.fromARGB(164, 0, 0, 0),
                      ))),
                ),
              ),
            ),
          ),

          Positioned(
              top: 510,
              left: 620,
              right: 620,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                  minimumSize: Size(20, 50),
                  visualDensity: VisualDensity.comfortable,
                  backgroundColor: Colors.black.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(18))),
                ),
                onPressed: () async {
                  result = await authenticateUser(
                      usernamecontroller.text, passwordcontroller.text);
                  //showMessagefunc();

                  setState(() {
                    if (result is Authentication) {
                      isAuthentication = true;
                      logintoken = result.Token;
                      firstname = result.Name;
                    } else {
                      isAuthentication = false;
                    }
                  });
                  //showToast("gattu");
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Center(child: Text(
                            isAuthentication
                                ? result?.Message ?? ''
                                : result ?? '',
                            style: TextStyle(fontFamily: "Myfont"),
                          )),
                    behavior: SnackBarBehavior.floating,
                    duration: Duration(seconds: 2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    backgroundColor: Colors.black,

                  ));
                  // if (isAuthentication && logintoken != null) {
                  //   Get.toNamed("/tasks", arguments: logintoken);
                  // }
                },
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                      fontFamily: 'Myfont',
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              )),

          Positioned(
              top: 580,
              left: 640,
              right: 640,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed("/signup");
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account yet? ",
                      style: TextStyle(
                        fontFamily: 'Myfont',
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: "Sign up",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Myfont',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
          // Positioned(
          //   top: 600,
          //   left: 0,
          //   right: 0,
          //   child: Center(
          //       child: AnimatedSwitcher(
          //           duration: Duration(milliseconds: 300),
          //           child: showMessage
          //               ? Text(
          //                   isAuthentication
          //                       ? result?.Message ?? ''
          //                       : result ?? '',
          //                   style: TextStyle(fontFamily: "Myfont"),
          //                 )
          //               : SizedBox.shrink())),
          // )
        ],
      ),
    );
  }
}
//