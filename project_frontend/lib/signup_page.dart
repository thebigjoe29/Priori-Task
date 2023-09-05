import 'package:flutter/material.dart';
import 'networking_api.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController firstname = TextEditingController();
  var message="";
  var result="";
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
              top: 300, left: 370, child: Center(child: Text("Signup"))),
          Positioned(
            top: 330,
            left: 200,
            right: 200,
            child: Center(
              child: TextField(
                controller: username,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  filled: true,
                ),
              ),
            ),
          ),
          Positioned(
            top: 400,
            left: 200,
            right: 200,
            child: Center(
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  filled: true,
                ),
                controller: password,
              ),
            ),
          ),
          Positioned(
            top: 480,
            left: 200,
            right: 200,
            child: Center(
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  filled: true,
                ),
                controller: firstname,
              ),
            ),
          ),
          Positioned(
              top: 550,
              left: 200,
              right: 200,
              child: ElevatedButton(
                onPressed: () async {
                  message = await signupUser(
                      username.text, password.text, firstname.text);
                      setState(() {
                        result=message;
                      });
                },
                child: Text("press me"),
              )),
          Positioned(
            top: 600,
            left: 270,
            right: 200,
            child: Text(result),
          ),
        ],
      ),
    );
  }
}
