import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_frontend/signup_page.dart';
import 'networking_api.dart';
import 'package:get/get.dart';

class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  var logintoken;

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
                  logintoken = authenticateUser(
                      usernamecontroller.text, passwordcontroller.text);
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
                  
                  onTap: (){
                    Get.to(signup());
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
              ))
        ],
      ),
    );
  }
}
