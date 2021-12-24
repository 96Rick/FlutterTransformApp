// To parse this JSON data, do
//
//     final serviceModel = serviceModelFromJson(jsonString);

import 'dart:convert';

import 'package:ttm/model/profile_models/attached_model.dart';

class MyDetailInfoModel {
  MyDetailInfoModel({
    this.status,
    this.driver_start,
    this.driver_end,
    this.name,
    this.id_card,
    this.id_card_start,
    this.id_card_end,
    this.police_station,
    this.certificate,
    required this.ownerTransportation,
    required this.attached,
    required this.company,
    required this.driverAudit,
  });

  // 车队
  List<CompanyElement> company;
  List<DriverAudit> driverAudit;

  String? status;
  // 驾驶证
  String? driver_start;
  String? driver_end;

  List<String> ownerTransportation = [];

  // 身份证
  String? name;
  String? id_card;
  String? id_card_start;
  String? id_card_end;
  String? police_station;
  String? certificate;
  // 附件
  AttachedModel attached = AttachedModel();

  factory MyDetailInfoModel.fromRawJson(String str) =>
      MyDetailInfoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyDetailInfoModel.fromJson(Map<String, dynamic> json) =>
      MyDetailInfoModel(
          ownerTransportation: json["owner_transportation"] == null
              ? []
              : List<String>.from(json["owner_transportation"].map((x) => x)),
          driver_start: json["driver_start"],
          driver_end: json["driver_end"],
          name: json["name"],
          status: json["status"],
          id_card: json["id_card"],
          id_card_start: json["id_card_start"],
          id_card_end: json["id_card_end"],
          police_station: json["police_station"],
          certificate: json["certificate"],
          attached: json["attached"] != null
              ? AttachedModel.fromJson(json["attached"])
              : AttachedModel(),
          company: json["company"] != null
              ? json["company"] is List
                  ? List<CompanyElement>.from(
                      json["company"].map((x) => CompanyElement.fromJson(x)))
                  : []
              : [],
          driverAudit: json["driver_audit"] != null
              ? json["driver_audit"] is List
                  ? List<DriverAudit>.from(
                      json["driver_audit"].map((x) => DriverAudit.fromJson(x)))
                  : []
              : []);

  Map<String, dynamic> toJson() => {
        "driver_start": driver_start,
        "driver_end": driver_end,
        "name": name,
        "id_card": id_card,
        "id_card_start": id_card_start,
        "id_card_end": id_card_end,
        "police_station": police_station,
        "certificate": certificate,
        "owner_transportation": ownerTransportation,
        "attached": attached.toJson(),
      };
}

class CompanyElement {
  CompanyElement({
    required this.companyId,
  });

  CompanyName companyId;

  factory CompanyElement.fromRawJson(String str) =>
      CompanyElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyElement.fromJson(Map<String, dynamic> json) => CompanyElement(
        companyId: json["company_id"] != null
            ? CompanyName.fromJson(json["company_id"])
            : CompanyName(),
      );

  Map<String, dynamic> toJson() => {
        "company_id": companyId.toJson(),
      };
}

class CompanyName {
  CompanyName({
    this.id,
    this.companyName,
  });
  String? id;
  String? companyName;

  factory CompanyName.fromRawJson(String str) =>
      CompanyName.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyName.fromJson(Map<String, dynamic> json) =>
      CompanyName(companyName: json["company_name"], id: json["id"]);

  Map<String, dynamic> toJson() => {"company_name": companyName, "id": id};
}

class DriverAudit {
  DriverAudit({
    this.status,
    required this.company,
  });

  String? status;
  DriverAuditCompany company;

  factory DriverAudit.fromRawJson(String str) =>
      DriverAudit.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DriverAudit.fromJson(Map<String, dynamic> json) => DriverAudit(
        status: json["status"],
        company: json["company"] != null
            ? DriverAuditCompany.fromJson(json["company"])
            : DriverAuditCompany(),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "company": company.toJson(),
      };
}

class DriverAuditCompany {
  DriverAuditCompany({
    this.companyName,
  });

  String? companyName;

  factory DriverAuditCompany.fromRawJson(String str) =>
      DriverAuditCompany.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DriverAuditCompany.fromJson(Map<String, dynamic> json) =>
      DriverAuditCompany(
        companyName: json["company_name"],
      );

  Map<String, dynamic> toJson() => {
        "company_name": companyName,
      };
}
