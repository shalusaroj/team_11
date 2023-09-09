import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team11/utill/images.dart';



class MyTeamCard extends StatelessWidget {
  const MyTeamCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16),
          height: Get.width / 3 + 20,
          width: Get.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                Images.ground,
                fit: BoxFit.cover,
              )),
        ),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              margin: const EdgeInsets.only(top: 16),
              height: 40,
              width: Get.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12)),
                color: Colors.black45,
              ),
              child: Row(
                children: const [
                  Text(
                    "Abhishek Maheshwari",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  Text(
                    "(T1)",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  Spacer(),
                  Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 18,
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                children: [
                  Column(
                    children: const [
                      Text(
                        "IND",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "7",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: const [
                      Text(
                        "NZ",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "4",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(20)),
                    child: const Center(
                      child: Text(
                        "C",
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      ClipOval(
                          child: Image.network(
                        "https://cricket.upcomingwiki.com/public/images/gallery/26551.png",
                        fit: BoxFit.cover,
                        width: 70,
                        height: 70,
                      )),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          color: Colors.black,
                          child: const Center(
                            child: Text(
                              "Rohit Sharma",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(20)),
                    child: const Center(
                      child: Text(
                        "VC",
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      ClipOval(
                          child: Image.network(
                        "https://img1.hscicdn.com/image/upload/f_auto,t_ds_square_w_320,q_50/lsci/db/PICTURES/CMS/316600/316605.png",
                        fit: BoxFit.cover,
                        width: 70,
                        height: 70,
                      )),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          color: Colors.black,
                          child: const Center(
                            child: Text(
                              "Virat Kohli",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
