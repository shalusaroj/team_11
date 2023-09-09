import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team11/utill/images.dart';
import 'package:team11/view/screens/auth/login_with_phone.dart';
import 'package:team11/view/screens/auth/widget/input_field.dart';
import 'package:team11/view/screens/dashboard/dashboard_screen.dart';


class RegisteredScreen extends StatefulWidget {
  final String phoneNumber;
  final String otp;

  RegisteredScreen({required this.phoneNumber, required this.otp, required Text});

  @override
  State<RegisteredScreen> createState() => _RegisteredScreenState();
}

class _RegisteredScreenState extends State<RegisteredScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();


  // Variable to track whether all fields are filled
  bool allFieldsFilled = true;
  Future<void> _registerUser(BuildContext context) async {
    // Debugging: Print the values of the controllers
    print("Name: ${_nameController.text}");
    print("Email: ${_emailController.text}");
    print("Password: ${_passwordController.text}");
    print("Confirm Password: ${_confirmPasswordController.text}");

    // Check if any field is empty
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      setState(() {
        allFieldsFilled = false;
      });
      print("One or more fields are empty.");
      return;
    }

    // Reset the error message if all fields are filled
    setState(() {
      allFieldsFilled = true;
    });

    final Map<String, dynamic> requestBody = {
      "name": _nameController.text, // Use the entered name
      "email": _emailController.text, // Use the entered email
      "password": _passwordController.text,
      "confirmPassword": _confirmPasswordController.text,
      "city": "Sample City",
      "state": "Sample State",
      "pincode": "123456",
      "otp": widget.otp,
      "mobile": widget.phoneNumber,
    };

    final Uri uri = Uri.parse(
        "https://aio.thebyteiq.com/server/api/mobile/v1/user/register");

    print("Sending registration request with data:");
    print(requestBody);

    final response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode(requestBody),
    );

    print(
        "Received registration response with status code: ${response.statusCode}");
    print("Response data:");
    print(response.body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData.containsKey('data') && responseData['data'] != null) {
        final String token = responseData['data']['token'];

        final prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);

        print("Registration successful");
        print("Token: $token");
        print("Navigating to DashboardScreen");
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) =>
                DashBoardScreen(), // Replace with your DashboardScreen class
          ),
        );
      } else {
        print("Registration response does not contain a valid token");
      }
    } else {
      print("Registration failed with response: ${response.body}");
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 80),
              width: 80,
              height: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  Images.logo,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            height: Get.height,
            padding: const EdgeInsets.all(22),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: ListView(
              children: [
                const Center(
                  child: Text(
                    "Enter Your Details For Register",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 35,),
                const SizedBox(
                  height: 16,
                ),
                InputField(
                  title: 'Name',
                  icon: Icons.person,
                    controller: _nameController,
                ),
                InputField(
                  title: 'Email',
                  icon: Icons.mail,
                  controller: _emailController,
                ),
                InputField(
                  title: 'State',
                  icon: Icons.map,
                ),
                InputField(
                  title: 'City',
                  icon: Icons.maps_home_work,
                ),
                InputField(
                  title: 'Pin code',
                  icon: Icons.pin_drop,
                ),
                InputField(
                  title: 'Password',
                  icon: Icons.lock,
                  controller: _passwordController,
                  isPassword: true,
                ),
                InputField(
                  title: 'Confirm Password',
                  icon: Icons.lock,
                  controller: _confirmPasswordController,
                  isPassword: true,
                ),

                SizedBox(height: 30,),

                Center(
                  child: InkWell(
                    onTap: () {
                      print("Register button tapped");
                      _registerUser(context);
                    },
                    child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).primaryColor,
                      ),
                      height: 50,
                      constraints: const BoxConstraints(minWidth: 100, maxWidth: 500),
                      child: const Center(
                        child: Text(
                          "Register",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Display an error message if any field is empty
                if (!allFieldsFilled)
                  Center(
                    child: Text(
                      "All fields are required!",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}

