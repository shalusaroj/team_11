// To parse this JSON data, do
//
//     final matchModel = matchModelFromJson(jsonString);

import 'dart:convert';

MatchModel matchModelFromJson(String str) =>
    MatchModel.fromJson(json.decode(str));

String matchModelToJson(MatchModel data) => json.encode(data.toJson());

class MatchModel {
  MatchModel({
    this.id,
    this.sportsId,
    this.tournamentId,
     this.team1Id,
     this.team2Id,
     this.date,
     this.status,
     this.matchType,
     this.isLineupOut,
  });

  int? id;
  int? sportsId;
  int? tournamentId;
  int? team1Id;
  int? team2Id;
  int? date;
  String? status;
  String? matchType;
  bool? isLineupOut;

  factory MatchModel.fromJson(Map<String, dynamic> json) => MatchModel(
      id: json["id"] ?? 0,
      sportsId: json["sportsId"] ?? 0,
      tournamentId:  0,
      team1Id: 0,
      team2Id: 0,
      date: 1678023000,
      status: "",
      matchType:"",
      isLineupOut: false,
  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sportsId": sportsId,
        "tournamentId": 1,
        "team1Id": 1,
        "team2Id": 2,
        "date": 1678023000,
        "status": "",
        "matchType": "",
        "isLineupOut": false
      };
}
