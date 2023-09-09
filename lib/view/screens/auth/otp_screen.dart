import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team11/view/screens/auth/registered.dart';

import '../dashboard/dashboard_screen.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  final String otp;

  const OtpScreen({Key? key, required this.phoneNumber, required this.otp}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  bool isProcessing = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();

    // Use Future.delayed to show the OTP in a Snackbar after a delay
    Future.delayed(Duration(milliseconds: 100), () {
      showSnackBar(widget.otp);
    });
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

  void navigateToRegisteredScreen(bool userStatus) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => RegisteredScreen(
          phoneNumber: widget.phoneNumber,
          otp: pinController.text, Text: null,
        ),
      ),
    );
  }

  void showSnackBar(String otp) {
    final snackBar = SnackBar(
      content: Text(
        '$otp',
        style: TextStyle(
          color: Colors.white, // Text color
        ),
      ),
      duration: Duration(seconds: 10), // Adjust the duration as needed
      backgroundColor: Colors.black, // Background color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0), // Border radius
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<bool> verifyOtp(String enteredOtp) async {
    print("Verifying OTP...");
    setState(() {
      isProcessing = true; // Start processing
      errorMessage = null; // Clear any previous error message
    });

    final apiUrl = Uri.parse('https://aio.thebyteiq.com/server/api/mobile/v1/otp-verify');

    try {
      final response = await http.post(
        apiUrl,
        body: {
          'otp': enteredOtp,
          'mobile': widget.phoneNumber,
        },
      );

      print("Response status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final apiResponse = json.decode(response.body);
        final userStatus = apiResponse['userStatus'];

        if (userStatus) {
          print("Routing to UpdateProfileScreen");
          navigateToUpdateProfileScreen(true);

          // Save the token to SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          final token = apiResponse['userData']['token'];
          await prefs.setString('auth_token', token);
          return true; // OTP is correct
        } else {
          print("Routing to RegisteredScreen");
          navigateToRegisteredScreen(false);
          return false; // OTP is incorrect
        }
      } else {
        print("API call failed with status code: ${response.statusCode}");
        setState(() {
          errorMessage = 'Invalid OTP'; // Set the error message
        });
        return false; // OTP is incorrect
      }
    } catch (e) {
      print("An error occurred: $e");
      setState(() {
        errorMessage = "Invalid OTP"; // Set the error message
      });
      return false; // OTP is incorrect
    } finally {
      setState(() {
        isProcessing = false; // Finish processing
      });
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
            Center(
              child: Pinput(
                controller: pinController,
                focusNode: focusNode,
                defaultPinTheme: defaultPinTheme,
                length: 6,
                onCompleted: (pin) async {
                  debugPrint('onCompleted: $pin');

                  final isOtpValid = await verifyOtp(pin); // Verify OTP from API response

                  if (isOtpValid) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 30,
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                              const SizedBox(height: 13),
                              const Center(
                                child: Text(
                                  'Success',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              Container(
                                width: 100,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'OK',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        );
                      },
                    );
                  }
                },
                onChanged: (value) {
                  debugPrint('onChanged: $value');
                },
                cursor: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 9),
                      width: 22,
                      height: 1,
                      color: Colors.white,
                    ),
                  ],
                ),
                focusedPinTheme: const PinTheme(
                  width: 44,
                  height: 44,
                  textStyle: TextStyle(color: Colors.white),
                ),
                submittedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(color: Colors.white),
                  ),
                ),
                errorPinTheme: defaultPinTheme.copyWith(
                  // border: Border.all(color: Colors.redAccent),
                ),
              ),
            ),
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

void main() {
  runApp(const MaterialApp(
    home: OtpScreen(
        phoneNumber: '1234567890',
        otp: '123456'
    ), // Replace with your actual phone number and OTP
  ));
}
