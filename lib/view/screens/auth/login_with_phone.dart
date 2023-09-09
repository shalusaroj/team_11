import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:team11/utill/images.dart';
import 'otp_screen.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  String countryDialCode = '+91';

  bool showError = false;
  bool isProcessing = false;

  Future<void> sendOTPRequest(String phoneNumber) async {
    if (phoneNumber.isEmpty) {
      setState(() {
        showError = true; // Show error if phone number is empty
      });
      return;
    }

    setState(() {
      isProcessing = true; // Start processing
      showError = false; // Reset error flag
    });

    final requestData = {"mobile": phoneNumber};

    try {
      final response = await http.post(
        Uri.parse('https://aio.thebyteiq.com/server/api/mobile/v1/send/otp'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body); // Parse response as JSON
        final otp = responseData['message']; // Extract the OTP from the response

        print("OTP request successful: $otp");
        Get.to(() => OtpScreen(phoneNumber: phoneNumber, otp: otp)); // Pass OTP as a parameter
      } else {
        print("Failed to send OTP. Response code: ${response.statusCode}");
      }
    } catch (error) {
      print("Network error: $error");
    } finally {
      setState(() {
        isProcessing = false; // Finish processing
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Exit Confirmation"),
              content: Text("Do you want to exit the app?"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Pop the dialog
                    SystemNavigator.pop(); // Exit the app
                  },
                  child: Text("Yes"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Pop the dialog
                  },
                  child: Text("No"),
                ),
              ],
            );
          },
        );
        return false;
      },
      child: Scaffold(
        body: ListView(
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 80),
                width: 120,
                height: 120,
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
                      "Enter Your Phone Number",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Center(
                    child: Text(
                      "We’ll send you a verification code on the same number.",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Center(
                    child: Container(
                      constraints:
                      const BoxConstraints(minWidth: 100, maxWidth: 700),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IntlPhoneField(
                            controller: _phoneController,
                            dropdownIcon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                            pickerDialogStyle:
                            PickerDialogStyle(backgroundColor: Colors.black),
                            dropdownTextStyle:
                            const TextStyle(color: Colors.black),
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              counterStyle: TextStyle(color: Colors.black),
                              hintText: 'Phone Number',
                              hintStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            initialCountryCode: 'IN',
                            onChanged: (phone) {
                              countryDialCode = phone.countryCode;
                            },
                          ),
                          if (showError)
                            const Padding(
                              padding: EdgeInsets.only(top: 8, left: 6),
                              child: Text(
                                "Please enter your phone number",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          Visibility(
                            visible: isProcessing,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        print("Send OTP button tapped");
                        sendOTPRequest(_phoneController.text);
                      },
                      child: Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Theme.of(context).primaryColor,
                        ),
                        height: 50,
                        constraints:
                        const BoxConstraints(minWidth: 100, maxWidth: 500),
                        child: const Center(
                          child: Text(
                            "Send OTP",
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}





/*void login(AuthController authController) async {
    String phone = _phoneController.text.trim();
    String numberWithCountryCode = countryDialCode + phone;
    bool isValid = GetPlatform.isWeb ? true : false;
    if (!GetPlatform.isWeb) {
      try {
        var phoneNumber = await PhoneNumberUtil().parse(numberWithCountryCode);
        numberWithCountryCode =
        '+${phoneNumber.countryCode}${phoneNumber.nationalNumber}';
        isValid = true;
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    }
    if (phone.isEmpty) {
      showCustomSnackBar("Enter Your Phone Number");
    } else if (!isValid) {
      showCustomSnackBar("Invalid Phone Number");
    } else {
      authController
          .login(numberWithCountryCode, countryDialCode)
          .then((status) async {
        if (status.isSuccess) {
          Get.to(() => const OtpField());
        } else {
          showCustomSnackBar(status.message);
        }
      });
    }
  }*/

