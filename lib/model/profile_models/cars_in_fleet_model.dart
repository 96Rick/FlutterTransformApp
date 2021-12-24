// To parse this JSON data, do
//
//     final carsInFleetModel = carsInFleetModelFromJson(jsonString);

import 'dart:convert';

class CarsInFleetModel {
  CarsInFleetModel({
    required this.transportation,
  });

  List<Transportation> transportation;

  factory CarsInFleetModel.fromRawJson(String str) =>
      CarsInFleetModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CarsInFleetModel.fromJson(Map<String, dynamic> json) =>
      CarsInFleetModel(
        transportation: List<Transportation>.from(
            json["transportation"].map((x) => Transportation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "transportation":
            List<dynamic>.from(transportation.map((x) => x.toJson())),
      };
}

class Transportation {
  Transportation({
    this.id,
    this.companyId,
    this.transportationId,
  });

  int? id;
  String? companyId;
  String? transportationId;

  factory Transportation.fromRawJson(String str) =>
      Transportation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Transportation.fromJson(Map<String, dynamic> json) => Transportation(
        id: json["id"],
        companyId: json["company_id"],
        transportationId: json["transportation_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "transportation_id": transportationId,
      };

  Map<String, dynamic> toOnlyCompanyIDAndTransportationIDJson() => {
        "company_id": companyId,
        "transportation_id": transportationId,
      };
}
