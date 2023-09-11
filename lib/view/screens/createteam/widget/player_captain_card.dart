import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/my_team_controller.dart';
import '../../../../controller/tournament_controller.dart';
import '../../../../data/model/response/player_model.dart';
import '../../../../data/model/response/team_model.dart';

class PlayerCaptainCard extends StatefulWidget {
  final PlayerModel playerModel;
  const PlayerCaptainCard({Key? key, required this.playerModel})
      : super(key: key);

  @override
  State<PlayerCaptainCard> createState() => _PlayerCaptainCardState();
}

class _PlayerCaptainCardState extends State<PlayerCaptainCard> {
  late TeamModel team;

  TournamentController tournamentController = Get.find<TournamentController>();

  @override
  void initState() {
    super.initState();
    team = tournamentController.getTeam(teamId: widget.playerModel.teamId!);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyTeamController>(builder: (myTeamController) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        color: Colors.white,
        width: Get.width,
        child: Row(
          children: [
            Stack(
              children: [
                ClipOval(
                    child: Image.network(
                  widget.playerModel.image!,
                  fit: BoxFit.fill,
                  width: 60,
                  height: 60,
                )),
                Positioned(
                  bottom: 0,
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 10,
                        color: Theme.of(context).primaryColor,
                        child: Center(
                          child: Text(
                            team.shortName!,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        width: 20,
                        height: 10,
                        color: Colors.black,
                        child: Center(
                          child: Text(
                            widget.playerModel.position!.toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              children: [
                Text(
                  widget.playerModel.name!,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 6,
                ),
                const Text(
                  "0 pts",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    myTeamController.setCaptain(widget.playerModel.id!);
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color:
                            myTeamController.captainID == widget.playerModel.id!
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                        border: Border.all(
                          color: myTeamController.captainID ==
                                  widget.playerModel.id!
                              ? Colors.white
                              : Colors.black,
                        )),
                    child: Center(
                        child: Text(
                      "C",
                      style: TextStyle(
                          color: myTeamController.captainID ==
                                  widget.playerModel.id!
                              ? Colors.white
                              : Colors.black,
                          fontSize: 12),
                    )),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                const Text(
                  "79.5 %",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(
              width: 60,
            ),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    myTeamController.setViceCaptain(widget.playerModel.id!);
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: myTeamController.viceCaptainID ==
                                widget.playerModel.id!
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                        border: Border.all(
                          color: myTeamController.viceCaptainID ==
                                  widget.playerModel.id!
                              ? Colors.white
                              : Colors.black,
                        )),
                    child: Center(
                        child: Text(
                      "VC",
                      style: TextStyle(
                          color: myTeamController.viceCaptainID ==
                                  widget.playerModel.id!
                              ? Colors.white
                              : Colors.black,
                          fontSize: 12),
                    )),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                const Text(
                  "62.5 %",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
