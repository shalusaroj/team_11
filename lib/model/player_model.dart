// To parse this JSON data, do
//
//     final playerModel = playerModelFromJson(jsonString);

import 'dart:convert';

PlayerModel playerModelFromJson(String str) =>
    PlayerModel.fromJson(json.decode(str));

String playerModelToJson(PlayerModel data) => json.encode(data.toJson());

class PlayerModel {
  PlayerModel({
    this.id,
    this.name,
    this.position,
    this.image,
    this.teamId,
    this.credits,
    this.points,
    this.status,
    this.odiMatch,
    this.odiRuns,
    this.odiWickets,
    this.t20Match,
    this.t20Runs,
    this.t20Wickets,
    this.iplMatch,
    this.iplRuns,
    this.iplWickets,
    this.testMatch,
    this.testRuns,
    this.testWickets,
  });

  int? id;
  String? name;
  String? position;
  String? image;
  int? teamId;
  int? credits;
  int? points;
  bool? status;
  int? odiMatch;
  int? odiRuns;
  int? odiWickets;
  int? t20Match;
  int? t20Runs;
  int? t20Wickets;
  int? iplMatch;
  int? iplRuns;
  int? iplWickets;
  int? testMatch;
  int? testRuns;
  int? testWickets;

  factory PlayerModel.fromJson(Map<String, dynamic> json) => PlayerModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        position: json["position"] ?? "",
        image: json["image"] ?? "",
        teamId: json["team_id"] ?? 0,
        credits: json["credits"] ?? 0,
        points: json["points"] ?? 0,
        status: json["status"],
        odiMatch: json["odi_match"] ?? 0,
        odiRuns: json["odi_runs"] ?? 0,
        odiWickets: json["odi_wickets"] ?? 0,
        t20Match: json["t20_match"] ?? 0,
        t20Runs: json["t20_runs"] ?? 0,
        t20Wickets: json["t20_wickets"] ?? 0,
        iplMatch: json["ipl_match"] ?? 0,
        iplRuns: json["ipl_runs"] ?? 0,
        iplWickets: json["ipl_wickets"] ?? 0,
        testMatch: json["test_match"] ?? 0,
        testRuns: json["test_runs"] ?? 0,
        testWickets: json["test_wickets"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "position": position,
        "image": image,
        "team_id": teamId,
        "credits": credits,
        "points": points,
        "status": status,
        "odi_match": odiMatch,
        "odi_runs": odiRuns,
        "odi_wickets": odiWickets,
        "t20_match": t20Match,
        "t20_runs": t20Runs,
        "t20_wickets": t20Wickets,
        "ipl_match": iplMatch,
        "ipl_runs": iplRuns,
        "ipl_wickets": iplWickets,
        "test_match": testMatch,
        "test_runs": testRuns,
        "test_wickets": testWickets,
      };
}
