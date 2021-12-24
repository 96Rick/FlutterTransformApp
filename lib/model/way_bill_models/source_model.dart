// To parse this JSON data, do
//
//     final sourceModel = sourceModelFromJson(jsonString);

import 'dart:convert';

class ScoreModel {
  ScoreModel({
    this.score,
  });

  String? score;

  factory ScoreModel.fromRawJson(String str) =>
      ScoreModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ScoreModel.fromJson(Map<String, dynamic> json) => ScoreModel(
        score: json["score"] ?? "0.0",
      );

  Map<String, dynamic> toJson() => {
        "score": score,
      };
}
