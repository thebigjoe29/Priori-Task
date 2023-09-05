import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_frontend/loginpage.dart';
import 'package:get/get.dart';
import 'package:project_frontend/signup_page.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      
      debugShowCheckedModeBanner: false,
      home: loginpage(),
    );
  }
}