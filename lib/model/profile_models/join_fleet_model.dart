// To parse this JSON data, do
//
//     final serviceModel = serviceModelFromJson(jsonString);

import 'dart:convert';

import 'package:ttm/model/profile_models/attached_model.dart';

class JoinFleetModel {
  JoinFleetModel({
    this.id,
    this.company_name,
  });

  String? id;
  String? company_name;

  factory JoinFleetModel.fromRawJson(String str) =>
      JoinFleetModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory JoinFleetModel.fromJson(Map<String, dynamic> json) => JoinFleetModel(
        id: json["id"],
        company_name: json["company_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_name": company_name,
      };
}
