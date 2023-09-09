import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team11/helper/get_di.dart';
import 'package:team11/view/screens/splash/splash_screen.dart';
import 'package:team11/view/screens/theme/color.dart';

void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Team11',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home:  SplashScreen(),
    );
  }
}

