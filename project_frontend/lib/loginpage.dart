import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_frontend/signup_page.dart';
import 'package:project_frontend/taskpage.dart';
import 'networking_api.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  var result;
  var logintoken;
  
  bool isAuthentication = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
              top: 290,
              left: 150,
              right: 150,
              child: Container(
                  color: Colors.grey.withOpacity(1),
                  child: const SizedBox(
                    height: 300,
                    width: 50,
                  ))),
          const Positioned(
              top: 300, left: 370, child: Center(child: Text("Login"))),
          Positioned(
            top: 330,
            left: 200,
            right: 200,
            child: Center(
              child: TextField(
                controller: usernamecontroller,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  filled: true,
                ),
              ),
            ),
          ),
          Positioned(
            top: 420,
            left: 200,
            right: 200,
            child: Center(
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  filled: true,
                ),
                controller: passwordcontroller,
              ),
            ),
          ),
          Positioned(
              top: 500,
              left: 200,
              right: 200,
              child: ElevatedButton(
                onPressed: () async {
                  result = await authenticateUser(
                      usernamecontroller.text, passwordcontroller.text);
                 
                  setState(() {
                    if (result is Authentication) {
                      isAuthentication = true;
                      logintoken=result.Token;
                    } else {
                      isAuthentication = false;
                    }
                  });
                  if (isAuthentication && logintoken!=null) {
                    Get.toNamed("/tasks", arguments: logintoken);
                  }
                 
                },
                child: Text("press me"),
              )),
          Positioned(
              top: 550,
              left: 270,
              right: 200,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed("/signup");
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account yet? ",
                      children: <TextSpan>[
                        TextSpan(
                          text: "Sign up",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
          Positioned(
            top: 600,
            left: 270,
            right: 270,
            child:
                Text(isAuthentication ? result?.Message ?? '' : result ?? ''),
          )
        ],
      ),
    );
  }
}
//