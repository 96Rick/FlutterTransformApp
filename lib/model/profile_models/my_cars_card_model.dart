// To parse this JSON data, do
//
//     final serviceModel = serviceModelFromJson(jsonString);

import 'dart:convert';

class MyCarCardInfoModel {
  MyCarCardInfoModel({
    this.license_plate_number,
    this.license_color,
    this.status,
    this.id,
  });

  String? license_plate_number;
  int? license_color;
  String? status;
  String? id;

  factory MyCarCardInfoModel.fromRawJson(String str) =>
      MyCarCardInfoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyCarCardInfoModel.fromJson(Map<String, dynamic> json) =>
      MyCarCardInfoModel(
        license_plate_number: json["license_plate_number"],
        license_color: json["license_color"],
        status: json["status"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "license_plate_number": license_plate_number,
        "license_color": license_color,
        "status": status,
        "id": id,
      };
}
