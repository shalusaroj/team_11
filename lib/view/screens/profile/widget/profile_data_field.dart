import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileDataField extends StatelessWidget {
  final String title;
  final String subTitle;
  const ProfileDataField(
      {Key? key, required this.title, required this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            width: Get.width,
            height: 50,
            decoration: BoxDecoration(
                color: const Color(0xffffefef),
                borderRadius: BorderRadius.circular(8)),
            child: Text(
              subTitle,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
