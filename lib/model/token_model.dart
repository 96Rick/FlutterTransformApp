import 'dart:convert';

import 'package:ttm/utils/date_util.dart';

class TokenModel {
  String? refreshToken;
  String? accessToken;
  int? expiresIn;

  static final TokenModel _instance = TokenModel._internal();
  TokenModel._internal();
  factory TokenModel() {
    return _instance;
  }

  factory TokenModel.fromRawJson(String str) =>
      TokenModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    _instance.refreshToken = json["refresh_token"];
    _instance.accessToken = json["access_token"];
    _instance.expiresIn = DateUtil.getExpirationTimeWith(json["expires"]);
    return _instance;
  }

  static Map<String, dynamic> toJson() => {
        "refresh_token": _instance.refreshToken,
        "access_token": _instance.accessToken,
        "expires": _instance.expiresIn,
      };
}
