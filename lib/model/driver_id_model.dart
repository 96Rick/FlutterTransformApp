import 'dart:convert';

class DriverIDModel {
  String? id;

  static final DriverIDModel _instance = DriverIDModel._internal();
  DriverIDModel._internal();
  factory DriverIDModel() {
    return _instance;
  }

  factory DriverIDModel.fromRawJson(String str) =>
      DriverIDModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DriverIDModel.fromJson(Map<String, dynamic> json) {
    _instance.id = json["id"];
    return _instance;
  }

  static Map<String, dynamic> toJson() => {
        "id": _instance.id,
      };
}
