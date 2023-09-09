// To parse this JSON data, do
//
//     final contestModel = contestModelFromJson(jsonString);

import 'dart:convert';

ContestModel contestModelFromJson(String str) =>
    ContestModel.fromJson(json.decode(str));

String contestModelToJson(ContestModel data) => json.encode(data.toJson());

class ContestModel {
  ContestModel({
    this.id,
    this.tournamentId,
    this.matchId,
    this.prizePool,
    this.entryFee,
    this.matchType,
    this.isGuaranteed,
    this.maxSpot,
    this.spotLeft,
    this.winners,
    this.firstPrize,
  });

  int? id;
  int? tournamentId;
  int? matchId;
  int? prizePool;
  int? entryFee;
  String? matchType;
  bool? isGuaranteed;
  int? maxSpot;
  int? spotLeft;
  int? winners;
  int? firstPrize;

  factory ContestModel.fromJson(Map<String, dynamic> json) => ContestModel(
        id: json["id"] ?? 0,
        tournamentId: json["tournament_id"] ?? 0,
        matchId: json["match_id"] ?? 0,
        prizePool: json["prize_pool"] ?? 0,
        entryFee: json["entry_fee"] ?? 0,
        matchType: json["match_type"] ?? "",
        isGuaranteed: json["is_guaranteed"],
        maxSpot: json["max_spot"] ?? 0,
        spotLeft: json["spot_left"] ?? 0,
        firstPrize: json["first_prize"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tournament_id": tournamentId,
        "match_id": matchId,
        "prize_pool": prizePool,
        "entry_fee": entryFee,
        "match_type": matchType,
        "is_guaranteed": isGuaranteed,
        "max_spot": maxSpot,
        "spot_left": spotLeft,
        "winners": winners,
        "first_prize": firstPrize,
      };
}
