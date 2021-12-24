// To parse this JSON data, do
//
//     final goods = goodsFromJson(jsonString);

import 'dart:convert';

class Goods {
  Goods({
    this.name,
    this.count,
    this.volume,
    this.weight,
    required this.classification,
  });

  String? name;
  int? count;
  double? volume;
  double? weight;
  Classification classification = Classification();

  factory Goods.fromRawJson(String str) => Goods.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Goods.fromJson(Map<String, dynamic> json) => Goods(
        name: json["name"],
        count: json["count"] ?? 0,
        volume: json["volume"] != null ? json["volume"].toDouble() : 0.0,
        weight: json["weight"] != null ? json["weight"].toDouble() : 0.0,
        classification: Classification.fromJson(json["classification"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "count": count,
        "volume": volume,
        "weight": weight,
        "classification": classification.toJson(),
      };
}

class Classification {
  Classification({
    this.name,
  });

  String? name;

  factory Classification.fromRawJson(String str) =>
      Classification.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Classification.fromJson(Map<String, dynamic> json) => Classification(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
