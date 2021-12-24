// To parse this JSON data, do
//

import 'dart:convert';

class CarTypeModel {
  CarTypeModel({
    this.name,
    this.id,
    this.mds,
  });

  String? name;
  String? id;
  List<CarTypeModel?>? mds;

  factory CarTypeModel.fromRawJson(String str) =>
      CarTypeModel.fromJson(json.decode(str));

  factory CarTypeModel.fromJson(Map<String, dynamic> json) => CarTypeModel(
        name: json["name"],
        id: json["id"],
        mds: json["mds"] != null
            ? List<CarTypeModel>.from(
                json["mds"].map((x) => CarTypeModel.fromJson(x)))
            : [],
      );
}
