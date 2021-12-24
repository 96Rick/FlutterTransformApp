// To parse this JSON data, do
//
//     final goodBidCar = goodBidCarFromJson(jsonString);

import 'dart:convert';

class GoodBidCar {
  GoodBidCar({
    this.licensePlateNumber,
    this.id,
    this.load,
  });

  String? licensePlateNumber;
  String? id;
  Load? load;

  factory GoodBidCar.fromRawJson(String str) =>
      GoodBidCar.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GoodBidCar.fromJson(Map<String, dynamic> json) => GoodBidCar(
        licensePlateNumber: json["license_plate_number"],
        id: json["id"],
        load: json["load"] == null ? Load() : Load.fromJson(json["load"]),
      );

  Map<String, dynamic> toJson() => {
        "license_plate_number": licensePlateNumber,
        "id": id,
        "load": load == null ? null : load!.toJson(),
      };
}

class Load {
  Load({
    this.name,
  });

  String? name;

  factory Load.fromRawJson(String str) => Load.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Load.fromJson(Map<String, dynamic> json) => Load(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
