// To parse this JSON data, do
//
//     final shipper = shipperFromJson(jsonString);

import 'dart:convert';

class Shipper {
  Shipper({
    this.score,
    this.companyName,
    this.companyCode,
    this.contactName,
    this.contactTel,
    this.contactPhone,
    this.companyAddress,
  });

  String? score;
  String? companyName;
  String? companyCode;
  String? contactName;
  String? contactTel;
  String? contactPhone;
  String? companyAddress;

  factory Shipper.fromRawJson(String str) => Shipper.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Shipper.fromJson(Map<String, dynamic> json) => Shipper(
        score: json["score"],
        companyName: json["company_name"],
        companyCode: json["company_code"],
        contactName: json["contact_name"],
        contactTel: json["contact_tel"],
        contactPhone: json["contact_phone"],
        companyAddress: json["company_address"],
      );

  Map<String, dynamic> toJson() => {
        "company_name": companyName,
        "company_code": companyCode,
        "contact_name": contactName,
        "contact_tel": contactTel,
        "contact_phone": contactPhone,
        "company_address": companyAddress
      };
}
