// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

TeamModel teamModelFromJson(String str) => TeamModel.fromJson(json.decode(str));

String teamModelToJson(TeamModel data) => json.encode(data.toJson());

class TeamModel {
  TeamModel({
    this.id,
    this.name,
    this.image,
    this.shortName,
  });

  int? id;
  String? name;
  String? image;
  String? shortName;

  factory TeamModel.fromJson(Map<String, dynamic> json) => TeamModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        image: json["image"] ?? "",
        shortName: json["short_name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "short_name": shortName,
      };
}
