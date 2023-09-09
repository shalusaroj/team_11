import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


import '../../../../model/match_model.dart';

class MatchCard extends StatefulWidget {
  final MatchModel matchModel;

  const MatchCard({super.key, required this.matchModel});

  @override
  State<MatchCard> createState() => _MatchCardState();
}

class _MatchCardState extends State<MatchCard> {
  //late TournamentModel tournamentModel;
  //late ContestModel contestModel;
  //late TeamModel team1;
  //late TeamModel team2;

  //TournamentController tournamentController = Get.find<TournamentController>();
  //ContestController contestController = Get.find<ContestController>();
  @override
  void initState() {
    super.initState();
    //tournamentModel = tournamentController.getTournament(
     //   tournamentId: widget.matchModel.tournamentId!);
    //contestModel = contestController.getMatchHighestPrizePool(
    //    matchId: widget.matchModel.id!);
    //team1 = tournamentController.getTeam(teamId: widget.matchModel.team1Id!);
    //team2 = tournamentController.getTeam(teamId: widget.matchModel.team2Id!);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () {
      //   log(json.encode(widget.matchModel.toJson()));
      //   Get.to(() => ContestJoinScreen(
      //        matchModel: widget.matchModel,
      //      ));
      // },
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        height: 190,
        width: Get.width,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[200]!, width: 2),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
              child: Row(
                children: [
                  Text(
                    "ICC World Cup",
                    style: const TextStyle(color: Colors.black87, fontSize: 12),
                  ),
                  const Spacer(),
                  FaIcon(
                    FontAwesomeIcons.peopleGroup,
                    color: Theme.of(context).primaryColor,
                    size: 16,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Lineups Out",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 12),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const FaIcon(
                    FontAwesomeIcons.bell,
                    color: Colors.black,
                    size: 16,
                  ),
                ],
              ),
            ),
            Divider(
              indent: 16,
              endIndent: 16,
              color: Colors.grey[350],
              thickness: 1,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "CSK",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "RCB",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
              child: Row(
                children: [
                  Image.network(
                    "https://static.vecteezy.com/system/resources/previews/011/571/359/original/circle-flag-of-new-zealand-free-png.png",
                    height: 50,
                    width: 50,
                  ),
                  const Spacer(),
                  Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    DateFormat('dd/MM/yyyy').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            widget.matchModel.date! * 1000)),
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  const Spacer(),
                  Image.network(
                    "https://static.vecteezy.com/system/resources/previews/011/571/359/original/circle-flag-of-new-zealand-free-png.png",
                    height: 50,
                    width: 50,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.grey[100],
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    height: 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            width: 1, color: Theme.of(context).primaryColor)),
                    child: Center(
                      child: Text(
                        "Mega",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Rs. 200",
                    style: const TextStyle(color: Colors.black),
                  ),
                  const Spacer(),
                  const FaIcon(
                    FontAwesomeIcons.tv,
                    color: Colors.black,
                    size: 16,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const FaIcon(
                    FontAwesomeIcons.bullhorn,
                    color: Colors.black,
                    size: 16,
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
