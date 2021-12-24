// To parse this JSON data, do
//
//     final contractInfoModel = contractInfoModelFromJson(jsonString);

import 'dart:convert';

class ContractInfoModel {
  ContractInfoModel({
    this.companyName,
    this.contactName,
    this.contactAddress,
    this.contactTel,
  });

  String? companyName;
  String? contactName;
  String? contactAddress;
  String? contactTel;

  factory ContractInfoModel.fromRawJson(String str) =>
      ContractInfoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ContractInfoModel.fromJson(Map<String, dynamic> json) =>
      ContractInfoModel(
        companyName: json["company_name"],
        contactName: json["contact_name"],
        contactAddress: json["contact_address"],
        contactTel: json["contact_tel"],
      );

  Map<String, dynamic> toJson() => {
        "company_name": companyName,
        "contact_name": contactName,
        "contact_address": contactAddress,
        "contact_tel": contactTel,
      };
}
