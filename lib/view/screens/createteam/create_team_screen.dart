import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:team11/data/dummy_data/tournament_data.dart';
import 'package:team11/view/screen/createteam/widget/player_card.dart';
import 'package:team11/view/screen/createteam/widget/player_text_widget.dart';

import '../../../controller/contest_controller.dart';
import '../../../controller/my_team_controller.dart';
import '../../../controller/tournament_controller.dart';
import '../../../data/model/response/match_model.dart';
import '../../../data/model/response/player_model.dart';
import '../../../data/model/response/team_model.dart';
import '../../../data/model/response/tournament_model.dart';
import '../preview/preview_screen.dart';
import 'my_team_screen.dart';

class CreateTeamScreen extends StatefulWidget {
  final MatchModel matchModel;
  const CreateTeamScreen({
    Key? key,
    required this.matchModel,
  }) : super(key: key);

  @override
  State<CreateTeamScreen> createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends State<CreateTeamScreen> {
  late TournamentModel tournamentModel;
  late TeamModel team1;
  late TeamModel team2;
  late List<PlayerModel> playerList;
  late List<PlayerModel> wkList;
  late List<PlayerModel> batList;
  late List<PlayerModel> arList;
  late List<PlayerModel> bowlList;

  TournamentController tournamentController = Get.find<TournamentController>();
  MyTeamController myTeamController = Get.find<MyTeamController>();
  ContestController contestController = Get.find<ContestController>();
  @override
  void initState() {
    super.initState();
    myTeamController.reset();
    playerList =
        tournamentController.getPlayerList(teamId: widget.matchModel.team1Id!);
    playerList.addAll(
        tournamentController.getPlayerList(teamId: widget.matchModel.team2Id!));

    wkList = playerList
        .where((element) => element.position! == Positions.wk.name)
        .toList();
    wkList.sort((a, b) => b.credits!.compareTo(a.credits!));
    batList = playerList
        .where((element) => element.position! == Positions.bat.name)
        .toList();
    batList.sort((a, b) => b.credits!.compareTo(a.credits!));
    bowlList = playerList
        .where((element) => element.position! == Positions.bowl.name)
        .toList();
    bowlList.sort((a, b) => b.credits!.compareTo(a.credits!));
    arList = playerList
        .where((element) => element.position! == Positions.ar.name)
        .toList();
    arList.sort((a, b) => b.credits!.compareTo(a.credits!));
    tournamentModel = tournamentController.getTournament(
        tournamentId: widget.matchModel.tournamentId!);

    team1 = tournamentController.getTeam(teamId: widget.matchModel.team1Id!);
    team2 = tournamentController.getTeam(teamId: widget.matchModel.team2Id!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 160,
                    width: Get.width,
                    decoration:
                        BoxDecoration(color: Theme.of(context).primaryColor),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              color: Colors.white,
                              onPressed: () {
                                Get.back();
                              },
                              icon: const Icon(Icons.arrow_back),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              DateFormat('EEE, d MMM').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      widget.matchModel.date! * 1000)),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const Text(
                          "Max 7 players from a team",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Players",
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(.8),
                                      fontSize: 14,
                                    ),
                                  ),
                                  GetBuilder<MyTeamController>(
                                      builder: (myTeamController) {
                                    return Row(
                                      children: [
                                        Text(
                                          myTeamController
                                              .getMyTeam()
                                              .length
                                              .toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          "/11",
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(.8),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    );
                                  })
                                ],
                              ),
                              const Spacer(),
                              Text(
                                team1.name!,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Image.network(
                                team1.image!,
                                height: 35,
                                width: 35,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Image.network(
                                team2.image!,
                                height: 35,
                                width: 35,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                team2.name!,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              GetBuilder<MyTeamController>(
                                  builder: (myTeamController) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Credit Left",
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(.8),
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      myTeamController
                                          .getCreditsLeft()
                                          .toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                );
                              })
                            ],
                          ),
                        ),
                        GetBuilder<MyTeamController>(
                            builder: (myTeamController) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: StepProgressIndicator(
                              totalSteps: 11,
                              currentStep: myTeamController.getMyTeam().length,
                              size: 18,
                              selectedColor: Colors.green,
                              unselectedColor: Colors.white,
                              customStep: (index, color, _) =>
                                  color == Colors.green
                                      ? Container(
                                          color: color,
                                          child: Center(
                                            child: Text(
                                              (index + 1).toString(),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )
                                      : Container(
                                          color: color,
                                          child: const Center(
                                            child: Text(
                                              "",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                  GetBuilder<MyTeamController>(builder: (myTeamController) {
                    return TabBar(
                      labelColor: Theme.of(context).primaryColor,
                      indicatorColor: Theme.of(context).primaryColor,
                      tabs: [
                        Tab(text: "WK(${myTeamController.wkCount})"),
                        Tab(text: "BAT(${myTeamController.batCount})"),
                        Tab(text: "AR(${myTeamController.arCount})"),
                        Tab(text: "BOWL(${myTeamController.bowlCount})"),
                      ],
                    );
                  }),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Column(
                          children: [
                            const PlayerTextWidget(
                              title: 'Pick 1-2 Wicket Keeper',
                            ),
                            GetBuilder<TournamentController>(
                                builder: (tournamentController) {
                              return Expanded(
                                child: ListView.builder(
                                  padding: const EdgeInsets.only(bottom: 80),
                                  itemCount: wkList.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        PlayerCard(
                                          playerModel: wkList[index],
                                        ),
                                        const Divider(
                                          thickness: 1,
                                          color: Colors.black12,
                                        )
                                      ],
                                    );
                                  },
                                ),
                              );
                            })
                          ],
                        ),
                        Column(
                          children: [
                            const PlayerTextWidget(
                              title: 'Pick 3-5 Batsmen',
                            ),
                            Expanded(
                              child: ListView.builder(
                                padding: const EdgeInsets.only(bottom: 80),
                                itemCount: batList.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      PlayerCard(
                                        playerModel: batList[index],
                                      ),
                                      const Divider(
                                        thickness: 1,
                                        color: Colors.black12,
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const PlayerTextWidget(
                              title: 'Pick 1-3 All-Rounders',
                            ),
                            Expanded(
                              child: ListView.builder(
                                padding: const EdgeInsets.only(bottom: 80),
                                itemCount: arList.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      PlayerCard(
                                        playerModel: arList[index],
                                      ),
                                      const Divider(
                                        thickness: 1,
                                        color: Colors.black12,
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const PlayerTextWidget(
                              title: 'Pick 3-5 Bowlers',
                            ),
                            Expanded(
                              child: ListView.builder(
                                padding: const EdgeInsets.only(bottom: 80),
                                itemCount: bowlList.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      PlayerCard(
                                        playerModel: bowlList[index],
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
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: 10,
                right: 0,
                left: 0,
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
                                width: 2)),
                        width: Get.width / 3,
                        height: 40,
                        child: Center(
                          child: Text(
                            "Preview",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => const MyTeamScreen());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 2)),
                        width: Get.width / 3,
                        height: 40,
                        child: const Center(
                          child: Text(
                            "Continue",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
