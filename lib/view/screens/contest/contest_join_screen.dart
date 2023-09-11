import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:team11/view/screen/contest/widget/contest_card.dart';
import 'package:team11/view/screen/contest/widget/my_team_card.dart';
import '../../../controller/contest_controller.dart';
import '../../../controller/tournament_controller.dart';
import '../../../data/model/response/contest_model.dart';
import '../../../data/model/response/match_model.dart';
import '../../../data/model/response/team_model.dart';
import '../../../data/model/response/tournament_model.dart';
import '../createteam/create_team_screen.dart';
import 'contest_create.dart';
import 'my_contest_screen.dart';

class ContestJoinScreen extends StatefulWidget {
  final MatchModel matchModel;
  const ContestJoinScreen({
    Key? key,
    required this.matchModel,
  }) : super(key: key);

  @override
  State<ContestJoinScreen> createState() => _ContestJoinScreenState();
}

class _ContestJoinScreenState extends State<ContestJoinScreen> {
  late TournamentModel tournamentModel;
  late ContestModel contestModel;
  late TeamModel team1;
  late TeamModel team2;

  TournamentController tournamentController = Get.find<TournamentController>();
  ContestController contestController = Get.find<ContestController>();
  @override
  void initState() {
    super.initState();
    tournamentModel = tournamentController.getTournament(
        tournamentId: widget.matchModel.tournamentId!);
    contestModel = contestController.getMatchHighestPrizePool(
        matchId: widget.matchModel.id!);

    team1 = tournamentController.getTeam(teamId: widget.matchModel.team1Id!);
    team2 = tournamentController.getTeam(teamId: widget.matchModel.team2Id!);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(tournamentModel.name!),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Image.network(
                    team1.image!,
                    height: 25,
                    width: 25,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    team1.name!,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text("vs"),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    team2.name!,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Image.network(
                    team2.image!,
                    height: 25,
                    width: 25,
                  ),
                  const Spacer(),
                  Text(DateFormat('dd/MM/yyyy').format(
                      DateTime.fromMillisecondsSinceEpoch(
                          widget.matchModel.date! * 1000))),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              child: AppBar(
                backgroundColor: Colors.white,
                bottom: TabBar(
                  labelColor: Theme.of(context).primaryColor,
                  indicatorColor: Theme.of(context).primaryColor,
                  tabs: const [
                    Tab(text: "Contest"),
                    Tab(text: "My Contest"),
                    Tab(text: "My Team"),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(children: [
                Stack(
                  children: [
                    GetBuilder<ContestController>(builder: (contestController) {
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        itemCount: contestController.getContestAllList().length,
                        itemBuilder: (context, index) {
                          return ContestCard(
                            contestModel: contestModel,
                            matchModel: widget.matchModel,
                          );
                        },
                      );
                    }),
                    Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          margin: const EdgeInsets.only(
                              bottom: 18, right: 70, left: 70),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 50,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(25)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(() => const ContestCreate());
                                },
                                child: Row(
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.trophy,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Create Contest",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              const VerticalDivider(
                                indent: 10,
                                endIndent: 10,
                                color: Colors.white,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => CreateTeamScreen(
                                        matchModel: widget.matchModel,
                                      ));
                                },
                                child:  Row(
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Create Team",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
                const MyContestScreen(),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView.builder(
                        itemCount: 2,
                        itemBuilder: (BuildContext context, int index) {
                          return const MyTeamCard();
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 100,
                      left: 100,
                      child: InkWell(
                        onTap: () {
                          Get.to(() => CreateTeamScreen(
                                matchModel: widget.matchModel,
                              ));
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.add),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Create Team",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
