import 'package:dio/dio.dart';
import 'package:ttm/common/ttm_constants.dart';
import 'package:ttm/model/token_model.dart';
import 'package:ttm/network/api.dart';
import 'package:ttm/network/dio_manager.dart';
import 'package:ttm/network/http_method.dart';
import 'package:ttm/status/main_status_model.dart';
import 'package:ttm/utils/net_util.dart';
import 'package:ttm/utils/sp_util.dart';

class TokenStatus extends BaseStatus {
  Future<bool> initTokenStatus() async {
    print("initTokenStatus");
    tokenModel = TokenModel();
    tokenModel.accessToken = getLocalAccessToken();
    tokenModel.refreshToken = getLocalRefreshToken();
    tokenModel.expiresIn = getLocalTokenExpiresTime();
    await checkNeedRelogin().then((isNeedRelogin) {
      if (isNeedRelogin) {
        isNeedReLogin = true;
      } else {
        isNeedReLogin = false;
      }
    }).whenComplete(() {
      notifyListeners();
    });
    return true;
  }

  Future<bool> checkNeedRelogin() async {
    if (tokenModel.accessToken != "" &&
        tokenModel.accessToken != null &&
        tokenModel.refreshToken != "" &&
        tokenModel.refreshToken != null) {
      Dio tokenDio = Dio();
      tokenDio.options = DioManager().dio!.options;
      try {
        var isConnected = await NetUtil.isConnected();

        if (isConnected) {
          Response response = await tokenDio.post(API.refreshToken,
              data: {"refresh_token": tokenModel.refreshToken},
              options: Options(method: HTTPMethodValues[HTTPMethod.POST]));
          if (response != null) {
            try {
              TokenModel.fromJson(response.data["data"]);
              setAllTokenData();
              return false;
            } catch (e) {
              print(e.toString());
              return true;
            }
          } else {
            return true;
          }
        } else {
          return true;
        }
      } on DioError catch (_) {
        return true;
      }
    } else {
      return true;
    }
  }

  String getLocalAccessToken() {
    print("getaccess token begin");
    var aToken = SpUtil.get(TTMConstants.accessToken);
    print("getaccess token end");
    return (aToken is String && aToken != null) ? aToken : "";
  }

  void setLocalAccessToken(String aToken) {
    print("set access token begin");
    SpUtil.set(TTMConstants.accessToken, aToken);
    tokenModel.accessToken = aToken;
    print(tokenModel.accessToken);
    notifyListeners();
    print("set access token end");
  }

  String getLocalRefreshToken() {
    print("get refresh token begin");
    var rToken = SpUtil.get(TTMConstants.refreshToken);
    print("get refresh token end");
    return (rToken is String && rToken != null) ? rToken : "";
  }

  void setLocalRefreshToken(String rtoken) {
    print("set refresh token begin");
    SpUtil.set(TTMConstants.refreshToken, rtoken);
    tokenModel.refreshToken = rtoken;
    print(tokenModel.refreshToken);
    notifyListeners();
    print("set refresh token end");
  }

  int getLocalTokenExpiresTime() {
    print("get token time  begin");
    var time = SpUtil.get(TTMConstants.tokenExpiresTime);
    print("get token time  end");
    return (time is int && time != null)
        ? time
        : DateTime.now().millisecondsSinceEpoch;
  }

  void setLocalTokenExpiresTime(int timeStamp) {
    print("set token time stamp begin");
    SpUtil.set(TTMConstants.tokenExpiresTime, timeStamp);
    tokenModel.expiresIn = timeStamp;
    print(tokenModel.expiresIn);
    notifyListeners();
    print("set token time stamp end");
  }

  void setAllTokenData() {
    SpUtil.set(TTMConstants.accessToken, tokenModel.accessToken);
    SpUtil.set(TTMConstants.refreshToken, tokenModel.refreshToken);
    SpUtil.set(TTMConstants.tokenExpiresTime, tokenModel.expiresIn);
    notifyListeners();
  }

  void deleteAllTokenData() {
    print("delete token data begin");
    SpUtil.delete(TTMConstants.accessToken);
    SpUtil.delete(TTMConstants.refreshToken);
    SpUtil.delete(TTMConstants.tokenExpiresTime);
    print("delete token data end");
  }
}
