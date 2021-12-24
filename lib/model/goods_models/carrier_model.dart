// To parse this JSON data, do
//
//     final carrier = carrierFromJson(jsonString);

import 'dart:convert';

class Carrier {
  Carrier({
    this.id,
    this.companyName,
    this.contactName,
    this.contactPhone,
    this.companyAddress,
    this.companyCode,
    this.contactTel,
  });

  String? id;
  String? companyName;
  String? contactName;
  String? contactPhone;
  String? companyAddress;
  String? companyCode;
  String? contactTel;

  factory Carrier.fromRawJson(String str) => Carrier.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Carrier.fromJson(Map<String, dynamic> json) => Carrier(
        id: json["id"],
        companyName: json["company_name"],
        contactName: json["contact_name"],
        contactPhone: json["contact_phone"],
        companyAddress: json["company_address"],
        companyCode: json["company_code"],
        contactTel: json["contact_tel"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_name": companyName,
        "contact_name": contactName,
        "contact_phone": contactPhone,
        "company_address": companyAddress,
        "company_code": companyCode,
        "contact_tel": contactTel,
      };
}
