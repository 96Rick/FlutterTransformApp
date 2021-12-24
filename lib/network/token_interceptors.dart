import 'package:dio/dio.dart';
import 'package:ttm/common/ttm_constants.dart';
import 'package:ttm/model/base_entity.dart';
import 'package:ttm/model/token_model.dart';
import 'package:ttm/network/api.dart';
import 'package:ttm/network/dio_manager.dart';
import 'package:ttm/network/http_method.dart';
import 'package:ttm/utils/date_util.dart';
import 'package:ttm/utils/sp_util.dart';

class TokenInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var accessToken = TokenModel().accessToken ?? "";
    var refreshToken = TokenModel().refreshToken ?? "";
    var tokenExpiresTime =
        TokenModel().expiresIn ?? DateTime.now().millisecondsSinceEpoch;

    if (options.path == API.loginPath || options.path == API.getDriverRoleID) {
      print("base with no Token");
    } else {
      if (options.path == API.register) {
        if (options.method == HTTPMethodValues[HTTPMethod.GET]) {
          print("base with Token");
          options.headers["Authorization"] = "Bearer $accessToken";
        }
      } else {
        print("base with Token");
        options.headers["Authorization"] = "Bearer $accessToken";
      }
    }
    print(options.data);
    print(options.path);
    print(options.uri);
    print(options.baseUrl);
    print(options.queryParameters);
    print(options.method);

    print(options.validateStatus);
    print(options.headers);
    // switch (options.path) {
    //   case API.loginPath:

    //   case API.register:
    //   case API.getDriverRoleID:
    //     print("base with login");
    //     break;
    //   // case Api.userInfo:
    //   //   print("base with uer info");
    //   //   options.headers.addAll({"access_token": accessToken});
    //   //   break;
    //   // case Api.getServerStatus:
    //   //   print("base with server status");
    //   //   options.headers.addAll({"access_token": accessToken});
    //   //   break;
    //   // case Api.refreshServerRemoteStatus:
    //   //   print("base with refresh server status");
    //   //   options.headers.addAll({"access_token": accessToken});
    //   //   break;
    //   // case Api.getServerRemoteDetail:
    //   //   print("base with server Detail");
    //   //   options.headers.addAll({"access_token": accessToken});
    //   //   break;
    //   default:
    //     print("base with defalut");
    //     options.headers["Authorization"] = "Bearer $accessToken";
    //     break;
    // }
    if (options.path != API.loginPath &&
        options.path != API.register &&
        options.path != API.getDriverRoleID &&
        DateUtil.isExpirationFromNow(tokenExpiresTime)) {
      DioManager().dio?.lock();
      bool isSuccess = await refreshAllToken(refreshToken);
      if (!isSuccess) {
        handler.reject(DioError(
            type: DioErrorType.response,
            response: Response(
                data: {"code": 10040, "message": "刷新失败请重新登录"},
                requestOptions: options),
            requestOptions: options));
        //   DioManager().dio
        //     ..reject(DioError(
        //         type: DioErrorType.RESPONSE,
        //         response:
        //             Response(data: {"code": 10040, "message": "刷新失败请重新登录"})));
      }
      DioManager().dio?.unlock();
    }
    return super.onRequest(options, handler);
  }

  Future<bool> refreshAllToken(String refreshToken) async {
    Dio tokenDio = Dio();
    tokenDio.options = DioManager().dio!.options;
    try {
      Response response = await tokenDio.post(API.refreshToken,
          data: {"refresh_token": refreshToken},
          options: Options(method: HTTPMethodValues[HTTPMethod.POST]));
      if (response != null) {
        try {
          TokenModel.fromJson(response.data["data"]);
          if (TokenModel().accessToken != null) {
            SpUtil.set(TTMConstants.accessToken, TokenModel().accessToken);
          }
          if (TokenModel().refreshToken != null) {
            SpUtil.set(TTMConstants.refreshToken, TokenModel().refreshToken);
          }
          if (TokenModel().expiresIn != null) {
            SpUtil.set(TTMConstants.tokenExpiresTime, TokenModel().expiresIn);
          }
          return true;
        } catch (e) {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
