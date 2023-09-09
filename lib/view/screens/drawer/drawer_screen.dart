import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utill/images.dart';
import '../auth/sign_in_screen.dart';
import '../profile/update_profile_screen.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          Container(
            height: (Get.width / 2) - 20,
            width: Get.width,
            color: Theme.of(context).primaryColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 25,
                ),
                IconButton(
                  onPressed: () {
                    // Navigate to the next page when the IconButton is pressed
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          // Replace 'NextPage' with the actual name of your next page's class
                          return UpdateProfileScreen();
                        },
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(boxShadow: const [
                          BoxShadow(
                            blurRadius: 3,
                            color: Colors.white,
                          )
                        ], borderRadius: BorderRadius.circular(45)),
                        child: CircleAvatar(
                          radius: (Get.width / 9),
                          child: ClipOval(
                              child: Image.network(
                            "https://play-lh.googleusercontent.com/BMryS7Cn454jIAVrchF9as-7WOG07H97Lugr62ISdJSo7wj1cC-0MTUm3SqSZffc7IQ",
                            fit: BoxFit.cover,
                            width: (Get.width / 4.5),
                            height: (Get.width / 4.5),
                          )),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Expanded(
                        child: Text(
                          "Abhishek Maheshwari",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            onTap: () {
              //Get.to(() => const WalletScreen());
            },
            title: const Text(
              "My Wallet",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            leading: const Icon(
              Icons.wallet,
              color: Colors.black,
            ),
            trailing: const Icon(
              Icons.chevron_right,
              color: Colors.black,
              size: 26,
            ),
          ),
          ListTile(
            onTap: () {
              //Get.to(() => const NotificationScreen());
            },
            title: const Text(
              "Notification",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            leading: const Icon(
              Icons.notifications,
              color: Colors.black,
            ),
            trailing: const Icon(
              Icons.chevron_right,
              color: Colors.black,
              size: 26,
            ),
          ),
          ListTile(
            onTap: () {},
            title: const Text(
              "Privacy Policy",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            leading: const Icon(
              Icons.policy,
              color: Colors.black,
            ),
            trailing: const Icon(
              Icons.chevron_right,
              color: Colors.black,
              size: 26,
            ),
          ),
          ListTile(
            onTap: () {},
            title: const Text(
              "Term And Conditions",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            leading: const FaIcon(
              FontAwesomeIcons.fileContract,
              color: Colors.black,
            ),
            trailing: const Icon(
              Icons.chevron_right,
              color: Colors.black,
              size: 26,
            ),
          ),
          ListTile(
            onTap: () {
              //Get.to(() => const SettingScreen());
            },
            title: const Text(
              "Settings",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            leading: const Icon(
              Icons.settings,
              color: Colors.black,
            ),
            trailing: const Icon(
              Icons.chevron_right,
              color: Colors.black,
              size: 26,
            ),
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20.0)), //this right here
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColor,
                      ),
                      height: 280,
                      width: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              Images.logo,
                              height: 120,
                            ),
                            const Text(
                              "Do you want to logout?",
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: const Center(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    final prefs = await SharedPreferences.getInstance();
                                    await prefs.remove('auth_token'); // Remove the 'auth_token' key from SharedPreferences

                                    Get.offAll(() => SignInScreen()); // Navigate to the login screen and remove all previous routes
                                  },
                                  child: const Text(
                                    "Logout",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            title: const Text(
              "Logout",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            leading: const Icon(
              Icons.exit_to_app,
              color: Colors.black,
            ),
            trailing: const Icon(
              Icons.chevron_right,
              color: Colors.black,
              size: 26,
            ),
          ),
        ],
      ),
    );
  }
}
