import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'networking_api.dart';
import 'package:get/get.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  
  State<signup> createState() => _signupState();
}


class _signupState extends State<signup> {
  @override
  
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController firstname = TextEditingController();
  var message="";
  var result;
  var success;
  String passwordStrength = '';


  Color getPasswordStrengthColor(String strength) {
  if (strength == 'Strong') {
    return Colors.green;
    
  } else if (strength == 'Medium') {
    return Color.fromARGB(255, 213, 194, 19);
  } else {
    return Colors.red;
  }
}
 bool pass=false;
String passwordStrengthfunc (String password) {
  // Define rules for password complexity
  bool hasLengthRule = password.length > 4;
  bool hasDigitRule = password.contains(RegExp(r'[0-9]'));
  bool hasUppercaseRule = password.contains(RegExp(r'[A-Z]'));
  bool hasLowercaseRule = password.contains(RegExp(r'[a-z]'));
  
 // bool hasSpecialCharRule = password.contains(RegExp(r'[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>?/~]'));

  // Calculate the complexity score
  int complexityScore = [
    hasLengthRule,
    hasDigitRule,
    hasUppercaseRule,
    hasLowercaseRule,
   // hasSpecialCharRule
  ].where((rule) => rule).length;

  // Classify the password
  if (complexityScore < 3) {
    return "Weak";
  } else if (complexityScore == 3) {
    return "Medium";
  } else {
    return "Strong";
  }
}
 bool isLoading=false;
  @override
 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: Stack(
        children: [
           Positioned.fill(
            child: Image.asset(
              "images/bg4.jpg", // Replace with your image asset path
              fit: BoxFit.cover, // Cover the entire stack with the image
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: ElevatedButton(
  onPressed: () {
    Navigator.pop(context);
  },
  child: Icon(Icons.arrow_back),
  
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.black.withOpacity(0.5),
    minimumSize: Size(50, 60),
    elevation: 5, // Adjust the elevation for shadow
    shadowColor: Colors.grey, // Shadow color
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10), // Rounded corners
    ),
  ),
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
          const Positioned(
              top: 220, left: 580,right: 580 ,child: Center(child: Text("Let's get to know you", style: TextStyle(
                      fontFamily: 'Myfont',
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.normal
                      )))),
         Positioned(
            top: 290,
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
                  controller: username,
                  decoration: InputDecoration(

                      // filled: true,
                      // fillColor: Colors.transparent,
                      icon: Container(
                          color: Colors.transparent,
                          child: Icon(
                            CupertinoIcons.person_circle_fill,
                            color: const Color.fromARGB(120, 0, 0, 0),
                          )),
                      labelText: "Enter username",
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
            top: 370,
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
                  controller: password,
                  onChanged:(String newPasswordValue){
                    String strength=passwordStrengthfunc(newPasswordValue);
                    setState(() {
                      passwordStrength=strength;
                    });
                  },
                  obscureText: !pass,
                  decoration: InputDecoration(
                      
                      suffixText: passwordStrength,
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
                      suffixStyle: TextStyle(fontFamily: "Myfont",fontSize: 13,color:getPasswordStrengthColor(passwordStrength) ),
                      icon: Container(
                          color: Colors.transparent,
                          child: Icon(
                            Icons.lock,
                            color: const Color.fromARGB(120, 0, 0, 0),
                          )),
                      labelText: "Create your password",
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
            top: 450,
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
                  controller: firstname,
                  decoration: InputDecoration(

                     
                      icon: Container(
                          color: Colors.transparent,
                          child: Icon(
                            Icons.email,
                            color: const Color.fromARGB(120, 0, 0, 0),
                          )),
                      labelText: "Enter your Email-ID",
                     
                      hintText: "qwerty@domain.com",
                      hintStyle: TextStyle(fontFamily: "Myfont",fontSize: 10,color: Colors.grey),
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
              top: 550,
              left: 620,
              right: 620,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                  minimumSize: Size(20, 50),
                  visualDensity: VisualDensity.comfortable,
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                ),
                onPressed: () async {
                  result = await signupUser(
                      username.text, password.text, firstname.text);
                      setState(() {
                        
                        message=result.data;
                        success=result.success;
                        isLoading=!isLoading;
                        
                      });
                      
                      await Future.delayed(Duration(seconds: 1));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Center(child: Text(result.data,style: TextStyle(fontFamily: "Myfont"),)),
                    behavior: SnackBarBehavior.floating,
                    duration: Duration(seconds: 2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    backgroundColor: Colors.black,

                  ));
                  setState(() {
                    isLoading=!isLoading;
                  });
                  if(result.success==true){
                    
                     await Future.delayed(Duration(seconds: 2));
                      Get.toNamed("/");}
                      // else{
                      //   setState(() {
                      //     isLoading=!isLoading;
                      //   });
                        
                      // }
                      
                },
                child: isLoading? Container(
                  height: 15,
                  width: 15,
                  child: CircularProgressIndicator(strokeWidth: 2,color: Colors.white,)):Text("SIGN UP!", style: TextStyle(
                      fontFamily: 'Myfont',
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              )),
          // Positioned(
          //   top: 610,
          //   left: 0,
          //   right: 0,
          //   child: Center(child: Text(result,style: TextStyle(fontFamily: "Myfont"),)),
          // ),
        ],
      ),
    );
  }
}
