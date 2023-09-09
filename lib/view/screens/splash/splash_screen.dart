import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team11/utill/images.dart';
import 'package:team11/view/screens/auth/sign_in_screen.dart';
import 'package:team11/view/screens/dashboard/dashboard_screen.dart';
 // Import your home screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _checkTokenAndRedirect(); // Check token and redirect accordingly
  }

  Future<void> _checkTokenAndRedirect() async {
    // Delay for a few seconds
    await Future.delayed(const Duration(seconds: 3));

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token != null) {
      // If token is found, navigate to home screen
      Get.off(() => DashBoardScreen());
    } else {
      // If token is not found, navigate to sign-in screen
      Get.off(() => SignInScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            Images.logo,
            width: 150,
            height: 150,
          ),
        ),
      ),
    );
  }
}
