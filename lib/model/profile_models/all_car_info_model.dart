// To parse this JSON data, do
//
//     final serviceModel = serviceModelFromJson(jsonString);

import 'dart:convert';

import 'package:ttm/model/profile_models/attached_model.dart';

class AllCarInfoModel {
  AllCarInfoModel({
    this.id,
    this.status,
    this.user_created,
    this.date_created,
    this.user_updated,
    this.date_updated,
    this.license_plate_number,
    this.energy_types,
    this.reason,
    this.resident_city,
    this.owner,
    this.vehicle_identification_code,
    this.last_survey_validity,
    this.audit_validity,
    required this.attached,
    required this.driver,
    this.del,
    this.van_type,
    this.van_species,
    this.load,
    this.loadDouble,
    this.license_color,
    this.owner_driver,
    this.owner_company,
    // this.execution,
    // this.driver,
    // this.company,
    // this.intention,
  });

  String? id;
  String? status;
  String? user_created;
  String? date_created;
  String? user_updated;
  String? date_updated;
  String? license_plate_number;
  String? energy_types;
  String? reason;
  String? resident_city;
  String? owner;
  String? vehicle_identification_code;
  String? last_survey_validity;
  String? audit_validity;
  AttachedModel attached = AttachedModel();
  int? del;
  String? van_type;
  String? van_species;
  String? load;
  double? loadDouble;
  int? license_color;
  String? owner_driver;
  String? owner_company;
  List<Driver> driver;
  // List<dynamic>? execution;
  // List<AllCarInfoDriverModel?>? driver;
  // List<>String? company;
  // String? intention;

  factory AllCarInfoModel.fromRawJson(String str) =>
      AllCarInfoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AllCarInfoModel.fromJson(Map<String, dynamic> json) =>
      AllCarInfoModel(
        id: json["id"],
        status: json["status"],
        user_created: json["user_created"],
        date_created: json["date_created"],
        user_updated: json["user_updated"],
        date_updated: json["date_updated"],
        license_plate_number: json["license_plate_number"],
        energy_types: json["energy_types"],
        reason: json["reason"],
        resident_city: json["resident_city"],
        owner: json["owner"],
        vehicle_identification_code: json["vehicle_identification_code"],
        last_survey_validity: json["last_survey_validity"],
        audit_validity: json["audit_validity"],
        attached: json["attached"] != null
            ? json["attached"] is String
                ? AttachedModel.fromJson(jsonDecode(json["attached"]))
                : AttachedModel.fromJson(json["attached"])
            : AttachedModel(),
        del: json["del"],
        van_type: json["van_type"],
        van_species: json["van_species"],
        load: json["load"],
        license_color: json["license_color"],
        owner_driver: json["owner_driver"] != null
            ? json["owner_driver"] is Map<String, dynamic>
                ? json["owner_driver"]["id"]
                : json["owner_driver"]
            : null,
        owner_company: json["owner_company"] != null
            ? json["owner_company"]["company_name"]
            : null,
        driver: json["driver"] != null
            ? List<Driver>.from(json["driver"].map((x) => Driver.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toUpdateJson() => {
        // "id": id,
        "status": status,
        // "user_created": user_created,
        // "date_created": date_created,
        // "user_updated": user_updated,
        // "date_updated": date_updated,
        "license_plate_number": license_plate_number,
        "energy_types": energy_types,
        // "reason": reason,
        "resident_city": resident_city,
        "owner": owner,
        "vehicle_identification_code": vehicle_identification_code,
        "last_survey_validity": last_survey_validity,
        "audit_validity": audit_validity,
        "attached": attached.toJson(),
        // "del": del,
        "van_type": van_type,
        "van_species": van_species,
        "load": load,
        "license_color": license_color,
        "owner_driver": owner_driver,
        // "owner_company": {"company_name": owner_company},
      };

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (id != null) {
      json["id"] = id;
    }
    if (status != null) {
      json["status"] = status;
    }
    if (user_created != null) {
      json["user_created"] = user_created;
    }
    if (date_created != null) {
      json["date_created"] = date_created;
    }
    if (user_updated != null) {
      json["user_updated"] = user_updated;
    }
    if (date_updated != null) {
      json["date_updated"] = date_updated;
    }
    if (license_plate_number != null) {
      json["license_plate_number"] = license_plate_number;
    }
    if (energy_types != null) {
      json["energy_types"] = energy_types;
    }
    if (reason != null) {
      json["reason"] = reason;
    }
    if (resident_city != null) {
      json["resident_city"] = resident_city;
    }
    if (owner != null) {
      json["owner"] = owner;
    }
    if (vehicle_identification_code != null) {
      json["vehicle_identification_code"] = vehicle_identification_code;
    }
    if (last_survey_validity != null) {
      json["last_survey_validity"] = last_survey_validity;
    }
    if (audit_validity != null) {
      json["audit_validity"] = audit_validity;
    }
    if (del != null) {
      json["del"] = del;
    }
    if (van_type != null) {
      json["van_type"] = van_type;
    }
    if (van_species != null) {
      json["van_species"] = van_species;
    }
    if (load != null) {
      json["load"] = load;
    }
    if (license_color != null) {
      json["license_color"] = license_color;
    }
    if (owner_driver != null) {
      json["owner_driver"] = owner_driver;
    }
    if (owner_company != null) {
      json["owner_company"] = owner_company;
    }
    if (attached != null) {
      json["attached"] = attached.toJson();
    }
    return json;
  }
}

class Driver {
  Driver({
    this.driverId,
  });

  String? driverId;

  factory Driver.fromRawJson(String str) => Driver.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        driverId: json["driver_id"],
      );

  Map<String, dynamic> toJson() => {
        "driver_id": driverId,
      };
}


// class AllCarInfoDriverModel {
//   AllCarInfoDriverModel({
//     this.id,
//     this.transportation_id,
//     this.driver_id,
//   });

//   String? id;
//   String? transportation_id;
//   String? driver_id;

//   factory AllCarInfoDriverModel.fromRawJson(String str) =>
//       AllCarInfoDriverModel.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory AllCarInfoDriverModel.fromJson(Map<String, dynamic> json) =>
//       AllCarInfoDriverModel(
//         id: json["id"],
//         transportation_id: json["transportation_id"],
//         driver_id: json["driver_id"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "transportation_id": transportation_id,
//         "driver_id": driver_id,
//       };
// }
