// To parse this JSON data, do
//
//     final participantModel = participantModelFromJson(jsonString);

import 'dart:convert';

ParticipantModel participantModelFromJson(String str) =>
    ParticipantModel.fromJson(json.decode(str));

String participantModelToJson(ParticipantModel data) =>
    json.encode(data.toJson());

class ParticipantModel {
  ParticipantModel({
    this.id,
    this.contestId,
    this.name,
    this.points,
    this.image,
  });

  int? id;
  int? contestId;
  String? name;
  double? points;
  String? image;

  factory ParticipantModel.fromJson(Map<String, dynamic> json) =>
      ParticipantModel(
        id: json["id"] ?? 0,
        contestId: json["contest_id"] ?? 0,
        name: json["name"] ?? "",
        points: json["points"] ?? 0.0,
        image: json["image"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contest_id": contestId,
        "name": name,
        "points": points,
        "image": image,
      };
}
