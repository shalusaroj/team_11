import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/contest_controller.dart';
import '../../../../controller/my_team_controller.dart';
import '../../../../controller/tournament_controller.dart';
import '../../../../data/model/response/player_model.dart';
import '../../../../data/model/response/team_model.dart';
import '../../playerprofile/player_profile_screen.dart';

class PlayerCard extends StatefulWidget {
  final PlayerModel playerModel;
  const PlayerCard({Key? key, required this.playerModel}) : super(key: key);

  @override
  State<PlayerCard> createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  late TeamModel team;

  TournamentController tournamentController = Get.find<TournamentController>();
  ContestController contestController = Get.find<ContestController>();

  @override
  void initState() {
    super.initState();
    team = tournamentController.getTeam(teamId: widget.playerModel.teamId!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 8),
      width: Get.width,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: () {
                Get.to(() => PlayerProfileScreen(
                      playerModel: widget.playerModel,
                    ));
              },
              child: Row(
                children: [
                  ClipOval(
                      child: Image.network(
                    widget.playerModel.image!,
                    fit: BoxFit.fill,
                    width: 50,
                    height: 50,
                  )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.playerModel.name!,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          Text(
                            team.shortName!,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 8),
                          ),
                          Text(
                            "-${widget.playerModel.position!.toUpperCase()}",
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 8),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 5,
                            width: 5,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          const Text(
                            "Playing",
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 8,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "0.0",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black.withOpacity(.4),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.playerModel.credits!.toString(),
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  width: 16,
                ),
                const SizedBox(
                  height: 40,
                  width: 1,
                  child: VerticalDivider(
                    thickness: 1,
                    color: Colors.black12,
                  ),
                ),
                GetBuilder<MyTeamController>(builder: (myTeamController) {
                  return IconButton(
                    onPressed: () {
                      if (myTeamController.checkPlayer(widget.playerModel)) {
                        myTeamController.removePlayer(widget.playerModel);
                      } else {
                        myTeamController.addPlayer(widget.playerModel);
                      }
                    },
                    icon: Icon(
                      myTeamController.checkPlayer(widget.playerModel)
                          ? Icons.remove
                          : Icons.add,
                      color: myTeamController.checkPlayer(widget.playerModel)
                          ? Colors.red
                          : Colors.green,
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
