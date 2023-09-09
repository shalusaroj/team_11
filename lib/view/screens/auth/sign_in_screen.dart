import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team11/utill/images.dart';
import 'package:team11/view/screens/auth/login_with_phone.dart';
import 'package:team11/view/screens/auth/widget/slider_view.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 40),
                width: 120,
                height: 120,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      Images.logo,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SliderView(),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Get.to(() => const LoginScreen());
              },
              child: Container(
                width: Get.width,
                height: 55,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: const Center(
                  child: Text(
                    "Login With Phone",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
