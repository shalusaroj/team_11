import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:team11/data/model/response/match_model.dart';

import '../../../../controller/contest_controller.dart';
import '../../../../controller/tournament_controller.dart';
import '../../../../data/model/response/contest_model.dart';
import '../../../../data/model/response/prize_model.dart';
import '../../../../data/model/response/team_model.dart';
import '../../../../data/model/response/tournament_model.dart';
import '../contest_details_screen.dart';

class ContestCard extends StatefulWidget {
  final ContestModel contestModel;
  final MatchModel matchModel;
  const ContestCard({
    Key? key,
    required this.contestModel,
    required this.matchModel,
  }) : super(key: key);

  @override
  State<ContestCard> createState() => _ContestCardState();
}

class _ContestCardState extends State<ContestCard> {
  late TournamentModel tournamentModel;
  late ContestModel contestModel;
  late TeamModel team1;
  late TeamModel team2;
  late List<PrizeModel> prizeList;

  TournamentController tournamentController = Get.find<TournamentController>();
  ContestController contestController = Get.find<ContestController>();
  @override
  void initState() {
    super.initState();
    contestModel = contestController.getMatchHighestPrizePool(
        matchId: widget.matchModel.id!);

    prizeList =
        contestController.getPrizeList(contestId: widget.contestModel.id!);
    team1 = tournamentController.getTeam(teamId: widget.matchModel.team1Id!);
    team2 = tournamentController.getTeam(teamId: widget.matchModel.team2Id!);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => ContestDetailsScreen(
              matchModel: widget.matchModel,
              contestModel: widget.contestModel,
            ));
      },
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        width: Get.width,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400, width: 1),
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "Prize Pool",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 12),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Rs ${contestModel.prizePool!}",
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Winners",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 12),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        widget.contestModel.winners!.toString(),
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Entry",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 12),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        height: 30,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Theme.of(context).primaryColor),
                        child: InkWell(
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                              Get.to(() => ContestDetailsScreen(
                                                    matchModel:
                                                        widget.matchModel,
                                                    contestModel:
                                                        widget.contestModel,
                                                  ));
                                            },
                                            child: Container(
                                              height: 35,
                                              width: Get.width / 3,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                              child: const Center(
                                                child: Text(
                                                  "Join Contest",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.currency_rupee,
                                size: 12,
                              ),
                              Text(
                                contestModel.entryFee.toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            SizedBox(
              width: Get.width,
              child: LinearPercentIndicator(
                animation: true,
                lineHeight: 6.0,
                animationDuration: 2000,
                percent: 0.5,
                progressColor: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              "${widget.contestModel.spotLeft!} Spot left",
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 12),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(12),
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
            )
          ],
        ),
      ),
    );
  }
}
