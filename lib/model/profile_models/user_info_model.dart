import 'dart:convert';

class UserInfoModel {
  String? first_name;
  String? email;
  String? driver;
  String? tel;
  String? id;

  static final UserInfoModel _instance = UserInfoModel._internal();
  UserInfoModel._internal();
  factory UserInfoModel() {
    return _instance;
  }

  factory UserInfoModel.fromRawJson(String str) =>
      UserInfoModel.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    print(json["tel"]);
    _instance.first_name = json["first_name"];
    _instance.email = json["email"];
    _instance.driver = (json["driver"] as List<dynamic>).cast<String>().isEmpty
        ? null
        : (json["driver"] as List<dynamic>).cast<String>().first;
    _instance.tel = json["tel"];
    _instance.id = json["id"];
    return _instance;
  }

  static Map<String, dynamic> toJson() => {
        "first_name": _instance.first_name,
        "email": _instance.email,
        "dirver": _instance.driver,
        "tel": _instance.tel,
        "id": _instance.id,
      };
}
