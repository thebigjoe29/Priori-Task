import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_frontend/loginpage.dart';
import 'package:get/get.dart';
import 'package:project_frontend/signup_page.dart';
import 'package:project_frontend/taskpage.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.leftToRight,
      //customTransition: Transition.fade,
      //initialRoute: "/tasks",
      initialRoute: "/",
      debugShowCheckedModeBanner: false,
       routes: {
        "/": (context) => loginpage(), // Define your login page route
        "/signup": (context) => signup(), 
  //       "/tasks": (context) {
  //   final logintoken = ModalRoute.of(context)?.settings.arguments;
  //   return Tasks(logintoken);
  // }, 
      },
     
    );
  }
}