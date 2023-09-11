import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayerTextWidget extends StatelessWidget {
  final String title;
  const PlayerTextWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
          width: Get.width,
          color: Colors.grey.shade200,
          child: Center(
              child: Text(
            title,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w700),
          )),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
          width: Get.width,
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  "Players",
                  style: TextStyle(
                      color: Colors.black.withOpacity(.4),
                      fontWeight: FontWeight.w700),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Points",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black.withOpacity(.4),
                      fontWeight: FontWeight.w700),
                ),
              ),
              const Expanded(
                flex: 1,
                child: Text(
                  "Credits",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          height: 1,
          thickness: 1,
          color: Colors.black12,
        ),
      ],
    );
  }
}
