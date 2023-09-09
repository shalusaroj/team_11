import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../dashboard/dashboard_screen.dart';

class MyContestScreen extends StatelessWidget {
  const MyContestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          const Center(
            child: Text(
              "You have not joined contest yet!",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Image.network(
            "https://creazilla-store.fra1.digitaloceanspaces.com/cliparts/79553/cricket-stadium-clipart-xl.png",
            width: Get.width,
            height: Get.width / 1.5,
          ),
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Text(
              "What Are you waiting for?",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Get.to(() => const DashBoardScreen());
            },
            child: Container(
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).primaryColor,
              ),
              height: 50,
              child: const Center(
                child: Text(
                  "Join Contest",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
