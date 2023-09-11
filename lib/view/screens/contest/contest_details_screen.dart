import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:team11/data/model/response/match_model.dart';
import 'package:team11/data/model/response/prize_model.dart';
import 'package:team11/view/screen/contest/contest_join_screen.dart';

import '../../../controller/contest_controller.dart';
import '../../../controller/tournament_controller.dart';
import '../../../data/model/response/contest_model.dart';
import '../../../data/model/response/participant_model.dart';
import '../../../data/model/response/team_model.dart';

class ContestDetailsScreen extends StatefulWidget {
  final MatchModel matchModel;
  final ContestModel contestModel;
  const ContestDetailsScreen({
    Key? key,
    required this.matchModel,
    required this.contestModel,
  }) : super(key: key);

  @override
  State<ContestDetailsScreen> createState() => _ContestDetailsScreenState();
}

class _ContestDetailsScreenState extends State<ContestDetailsScreen> {
  late ContestModel contestModel;
  late TeamModel team1;
  late TeamModel team2;
  late List<PrizeModel> prizeList;
  late List<ParticipantModel> participantList;

  TournamentController tournamentController = Get.find<TournamentController>();
  ContestController contestController = Get.find<ContestController>();
  @override
  void initState() {
    super.initState();
    contestModel = contestController.getMatchHighestPrizePool(
        matchId: widget.matchModel.id!);
    participantList = contestController.getParticipantList(
        contestId: widget.contestModel.id!);
    prizeList =
        contestController.getPrizeList(contestId: widget.contestModel.id!);
    team1 = tournamentController.getTeam(teamId: widget.matchModel.team1Id!);
    team2 = tournamentController.getTeam(teamId: widget.matchModel.team2Id!);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Row(
            children: [
              Text(
                team1.name!,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                width: 5,
              ),
              const Text(
                "vs",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                team2.name!,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Prize Pool",
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    "Rs.${contestModel.prizePool!}",
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: Get.width,
                    child: LinearPercentIndicator(
                      animation: true,
                      lineHeight: 4.0,
                      animationDuration: 2000,
                      percent: 0.7,
                      progressColor: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${contestModel.spotLeft!} Spot left",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 12),
                      ),
                      Text(
                        "${contestModel.maxSpot!} Spot ",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0)), //this right here
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              height: 300,
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Confirmation",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            icon: const FaIcon(
                                              FontAwesomeIcons.xmark,
                                              color: Colors.black,
                                            ))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Entry",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          "Rs. ${contestModel.entryFee!}",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Cash Bonus",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          "- Rs. 0",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Divider(
                                      color: Colors.grey,
                                      height: 1,
                                      thickness: 1,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "To Pay",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          "Rs. ${contestModel.entryFee!}",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.to(() => ContestJoinScreen(
                                            matchModel: widget.matchModel));
                                      },
                                      child: Container(
                                        height: 35,
                                        width: Get.width / 3,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color:
                                                Theme.of(context).primaryColor),
                                        child: const Center(
                                          child: Text(
                                            "Join Contest",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Theme.of(context).primaryColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Join",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.currency_rupee,
                            size: 16,
                          ),
                          Text(
                            contestModel.entryFee!.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              width: Get.width,
              height: 40,
              color: Colors.grey[100],
              child: Row(
                children: [
                  Container(
                    height: 18,
                    width: 18,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(color: Theme.of(context).primaryColor)),
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.one,
                        color: Theme.of(context).primaryColor,
                        size: 10,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Rs.${prizeList[0].prize}",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 12),
                  ),
                  const Spacer(),
                  Container(
                    height: 18,
                    width: 18,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(color: Theme.of(context).primaryColor)),
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.check,
                        color: Theme.of(context).primaryColor,
                        size: 10,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Guaranteed",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 12),
                  ),
                ],
              ),
            ),
            TabBar(
              labelColor: Theme.of(context).primaryColor,
              indicatorColor: Theme.of(context).primaryColor,
              tabs: const [
                Tab(text: "Winnings"),
                Tab(text: "Leaderboard"),
              ],
            ),
            Expanded(
              child: TabBarView(children: [
                ListView(
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                      child: Text(
                        "Be the first in your network to join this contest.",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.black26,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Rank",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          Text(
                            "Winnings",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.black26,
                    ),
                    GetBuilder<ContestController>(builder: (contestController) {
                      contestController.getPrizeList(
                          contestId: widget.contestModel.id!);
                      return ListView.builder(
                          itemCount: prizeList.length,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "#${prizeList[index].rankTo}",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Rs.${prizeList[index].prize}",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  thickness: 1,
                                  color: Colors.black26,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                              ],
                            );
                          });
                    })
                  ],
                ),
                ListView(
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                      child: Text(
                        "Be the first in your network to join this contest.",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.black26,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            "All Teams",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          Text(
                            "(89)",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.black26,
                    ),
                    GetBuilder<ContestController>(builder: (contestController) {
                      contestController.getParticipantList(
                          contestId: widget.contestModel.id!);
                      return ListView.builder(
                          itemCount: participantList.length,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ClipOval(
                                          child: Image.network(
                                        participantList[index].image!,
                                        fit: BoxFit.cover,
                                        width: 50,
                                        height: 50,
                                      )),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        participantList[index].name!,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  thickness: 1,
                                  color: Colors.black26,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                              ],
                            );
                          });
                    })
                  ],
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
