// To parse this JSON data, do
//
//     final prizeModel = prizeModelFromJson(jsonString);

import 'dart:convert';

PrizeModel prizeModelFromJson(String str) =>
    PrizeModel.fromJson(json.decode(str));

String prizeModelToJson(PrizeModel data) => json.encode(data.toJson());

class PrizeModel {
  PrizeModel({
    this.id,
    this.contestId,
    this.prize,
    this.rankTo,
    this.rankFrom,
  });

  int? id;
  int? contestId;
  int? prize;
  int? rankTo;
  int? rankFrom;

  factory PrizeModel.fromJson(Map<String, dynamic> json) => PrizeModel(
        id: json["id"] ?? 0,
        contestId: json["contest_id"] ?? 0,
        prize: json["prize"] ?? 0,
        rankTo: json["rank_to"] ?? 0,
        rankFrom: json["rank_from"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contest_id": contestId,
        "prize": prize,
        "rank_to": rankTo,
        "rank_from": rankFrom,
      };
}
