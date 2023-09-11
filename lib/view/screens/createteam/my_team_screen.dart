import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team11/view/screen/createteam/widget/player_captain_card.dart';
import 'package:team11/view/screen/preview/preview_screen.dart';

import '../../../controller/my_team_controller.dart';
import '../../../data/model/response/player_model.dart';
import '../../../data/model/response/player_model.dart';
import '../dashboard/dashboard_screen.dart';

class MyTeamScreen extends StatefulWidget {
  const MyTeamScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MyTeamScreen> createState() => _MyTeamScreenState();
}

class _MyTeamScreenState extends State<MyTeamScreen> {
  late List<PlayerModel> playerList;

  MyTeamController myTeamController = Get.find<MyTeamController>();

  @override
  void initState() {
    super.initState();
    playerList = myTeamController.getMyTeam();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "Create Team 1",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade200,
            child:  Column(
              children: [
                Text(
                  "Choose your Captain and Vice Captain",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "C gets 2x points and VC gets 1.5x points",
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ],
            ),
          ),
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            color: Theme.of(context).primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 10),
                Text(
                  "Type",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                SizedBox(width: 50),
                Text(
                  "Points",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Spacer(),
                Text(
                  "% C By",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                SizedBox(width: 50),
                Text(
                  "% VC By",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: playerList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    PlayerCaptainCard(
                      playerModel: playerList[index],
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.black12,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Get.to(() => const PreviewScreen());
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                ),
                width: Get.width / 3,
                height: 40,
                child: Center(
                  child: Text(
                    "Preview",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            InkWell(
              onTap: () {
                Get.to(() => const DashBoardScreen());
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                ),
                width: Get.width / 3,
                height: 40,
                child: const Center(
                  child: Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


