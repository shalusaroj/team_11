// To parse this JSON data, do
//
//     final tournamentModel = tournamentModelFromJson(jsonString);

import 'dart:convert';

TournamentModel tournamentModelFromJson(String str) =>
    TournamentModel.fromJson(json.decode(str));

String tournamentModelToJson(TournamentModel data) =>
    json.encode(data.toJson());

class TournamentModel {
  TournamentModel({
    this.id,
    this.name,
    this.date,
  });

  int? id;
  String? name;
  double? date;

  factory TournamentModel.fromJson(Map<String, dynamic> json) =>
      TournamentModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        date: json["date"] ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "date": date,
      };
}
