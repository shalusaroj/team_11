import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team11/view/screens/auth/registered.dart';
import 'package:team11/view/screens/dashboard/dashboard_screen.dart';

class BlankScreen extends StatefulWidget {

  const BlankScreen({Key? key}) : super(key: key);

  @override
  State<BlankScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<BlankScreen> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  bool isProcessing = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void navigateToUpdateProfileScreen(bool userStatus) {
    if (userStatus) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => DashBoardScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 44,
      height: 44,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: Colors.white),
      ),
    );
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            if (isProcessing)
              CircularProgressIndicator(),
            Text(
              errorMessage ?? '', // Display the error message, if available
              style: TextStyle(
                color: Colors.white, // Text color for error message
              ),
            ),
          ],
        ),
      ),
    );
  }
}
