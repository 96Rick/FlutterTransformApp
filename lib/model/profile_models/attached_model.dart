// To parse this JSON data, do
//
//     final serviceModel = serviceModelFromJson(jsonString);

import 'dart:convert';

class AttachedModel {
  AttachedModel({
    this.busLicensePic,
    this.idFront,
    this.idBack,
    this.licensePic,
    this.permit,
    this.car45Pic,
    this.carFontPic,
    this.examRecord,
    this.licenseCarPic,
    this.licenseSubPic,
    this.licenseHomePic,
    this.licenseEndCheckPic,
  });

  String? busLicensePic;
  String? idFront;
  String? idBack;
  String? licensePic;
  String? permit;
  String? car45Pic;
  String? carFontPic;
  String? examRecord;
  String? licenseCarPic;
  String? licenseSubPic;
  String? licenseHomePic;
  String? licenseEndCheckPic;

  factory AttachedModel.fromRawJson(String str) =>
      AttachedModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AttachedModel.fromJson(Map<String, dynamic> json) => AttachedModel(
        busLicensePic: json["busLicensePic"],
        idFront: json["idFront"],
        idBack: json["idBack"],
        licensePic: json["licensePic"],
        permit: json["permit"],
        car45Pic: json["car45Pic"],
        carFontPic: json["carFontPic"],
        examRecord: json["examRecord"],
        licenseCarPic: json["licenseCarPic"],
        licenseSubPic: json["licenseSubPic"],
        licenseHomePic: json["licenseHomePic"],
        licenseEndCheckPic: json["licenseEndCheckPic"],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (busLicensePic != null) {
      json["busLicensePic"] = busLicensePic;
    }
    if (idFront != null) {
      json["idFront"] = idFront;
    }
    if (idBack != null) {
      json["idBack"] = idBack;
    }
    if (licensePic != null) {
      json["licensePic"] = licensePic;
    }
    if (permit != null) {
      json["permit"] = permit;
    }
    if (car45Pic != null) {
      json["car45Pic"] = car45Pic;
    }
    if (carFontPic != null) {
      json["carFontPic"] = carFontPic;
    }
    if (examRecord != null) {
      json["examRecord"] = examRecord;
    }
    if (licenseCarPic != null) {
      json["licenseCarPic"] = licenseCarPic;
    }
    if (licenseSubPic != null) {
      json["licenseSubPic"] = licenseSubPic;
    }
    if (licenseHomePic != null) {
      json["licenseHomePic"] = licenseHomePic;
    }
    if (licenseEndCheckPic != null) {
      json["licenseEndCheckPic"] = licenseEndCheckPic;
    }
    return json;
  }
}
