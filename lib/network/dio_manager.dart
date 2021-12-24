// ignore_for_file: unnecessary_null_comparison

import 'package:dio/dio.dart';
import 'package:ttm/model/base_entity.dart';
import 'package:ttm/model/base_list_entity.dart';
import 'package:ttm/model/error_entity.dart';
import 'package:ttm/network/api.dart';
import 'package:ttm/network/http_method.dart';
import 'package:ttm/network/token_interceptors.dart';

class DioManager {
  static final DioManager _shared = DioManager._internal();
  factory DioManager() => _shared;
  Dio? dio;
  DioManager._internal() {
    if (dio == null) {
      BaseOptions options = BaseOptions(
        baseUrl: API.baseUrl,
        connectTimeout: 3000,
        receiveTimeout: 3000,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        receiveDataWhenStatusError: true,
      );
      dio = Dio(options);
      dio?.interceptors.add(TokenInterceptors());
    }
  }

  Future get<T>(String path,
      {Map<String, dynamic>? params,
      required Function(T) onSuccess,
      required Function(ErrorEntity) onError}) async {
    try {
      Response response = await dio!.request(path,
          queryParameters: params,
          options: Options(method: HTTPMethodValues[HTTPMethod.GET]));
      if (response != null) {
        if (path == API.getDriverRoleID) {
          BaseEntity entity = BaseEntity();
          onSuccess(entity.data);
        } else {
          BaseEntity entity = BaseEntity<T>.fromJson(response.data);
          onSuccess(entity.data);
        }
      } else {
        onError(ErrorEntity(code: "-1", message: "未知错误"));
      }
    } on DioError catch (e) {
      onError(createErrorEntity(e));
    }
  }

  Future post<T>(String path,
      {data,
      required Function(T) onSuccess,
      required Function(ErrorEntity) onError}) async {
    try {
      Response response = await dio!.request(path,
          data: data,
          options: Options(method: HTTPMethodValues[HTTPMethod.POST]));
      if (response != null && response.data != null) {
        BaseEntity entity = BaseEntity<T>.fromJson(response.data);
        onSuccess(entity.data);
      } else if (response != null) {
        BaseEntity entity = BaseEntity();
        onSuccess(entity.data);
      } else {
        onError(ErrorEntity(code: "-1", message: "未知错误"));
      }
    } on DioError catch (e) {
      onError(createErrorEntity(e));
    }
  }

  Future patch<T>(String path,
      {data,
      required Function(T) onSuccess,
      required Function(ErrorEntity) onError}) async {
    try {
      Response response = await dio!.request(path,
          data: data,
          options: Options(method: HTTPMethodValues[HTTPMethod.PATCH]));
      if (response != null && response.data != null) {
        BaseEntity entity = BaseEntity<T>.fromJson(response.data);
        onSuccess(entity.data);
      } else if (response != null) {
        BaseEntity entity = BaseEntity();
        onSuccess(entity.data);
      } else {
        onError(ErrorEntity(code: "-1", message: "未知错误"));
      }
    } on DioError catch (e) {
      onError(createErrorEntity(e));
    }
  }

  Future getList<T>(String path,
      {Map<String, dynamic>? params,
      required Function(List<T>) onSuccess,
      required Function(ErrorEntity) onError}) async {
    try {
      Response response = await dio!.request(path,
          queryParameters: params,
          options: Options(method: HTTPMethodValues[HTTPMethod.GET]));
      if (response != null) {
        BaseListEntity listEntity = BaseListEntity<T>.fromJson(response.data);
        onSuccess(listEntity.data as List<T>);
      } else {
        onError(ErrorEntity(code: "-1", message: "未知错误"));
      }
    } on DioError catch (e) {
      onError(createErrorEntity(e));
    }
  }

  Future postList<T>(String path,
      {data,
      required Function(List<T>) onSuccess,
      required Function(ErrorEntity) onError}) async {
    try {
      Response response = await dio!.request(path,
          data: data,
          options: Options(method: HTTPMethodValues[HTTPMethod.GET]));
      if (response != null) {
        BaseListEntity listEntity = BaseListEntity<T>.fromJson(response.data);
        onSuccess(listEntity.data as List<T>);
      } else {
        onError(ErrorEntity(code: "-1", message: "未知错误"));
      }
    } on DioError catch (e) {
      onError(createErrorEntity(e));
    }
  }

  ErrorEntity createErrorEntity(DioError e) {
    switch (e.type) {
      case DioErrorType.other:
        return ErrorEntity(code: "-1", message: "网络无连接");
      case DioErrorType.cancel:
        return ErrorEntity(code: "-1", message: "请求取消");
      case DioErrorType.connectTimeout:
        return ErrorEntity(code: "-1", message: "连接服务器错误");
      case DioErrorType.sendTimeout:
        return ErrorEntity(code: "-1", message: "网络超时");
      case DioErrorType.receiveTimeout:
        return ErrorEntity(code: "-1", message: "接收超时");

      case DioErrorType.response:
        try {
          var errorEntity = ErrorEntity.formCode(e.response?.statusCode);
          return errorEntity;
        } on Exception catch (_) {
          return ErrorEntity(code: "-1", message: "未知错误");
        }
      default:
        return ErrorEntity(code: "-1", message: e.message);
    }
  }
}
