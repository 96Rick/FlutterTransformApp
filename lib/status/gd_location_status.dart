import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:ttm/common/ttm_constants.dart';
import 'package:ttm/status/main_status_model.dart';
import 'dart:async';
import 'dart:io';

import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationStatus extends BaseStatus {
  initLocationStatus() {
    /// 设置locationKey
    AMapFlutterLocation.setApiKey(
        TTMConstants.gaodeMapAndroidKey, TTMConstants.gaodeMapiOSKey);

    /// 申请定位权限
    requestGDPermission();

    ///iOS 获取native精度类型
    if (Platform.isIOS) {
      requestAccuracyAuthorization();
    }

    ///注册定位结果监听
    setupLocationListener();
  }

  void setupLocationListener() {
    ///开始定位后会持续更新 model的 currentlocationlatitude 和 currentlocationlongitude
    ///更多返回结果请参考：
    ///https://lbs.amap.com/api/flutter/guide/positioning-flutter-plug-in/interface-info

    locationListener =
        locationPlugin.onLocationChanged().listen((Map<String, Object> result) {
      locationResult = result;
      currentLocationLatitude = locationResult["latitude"] is double
          ? locationResult["latitude"] as double
          : currentLocationLatitude;

      currentLocationLongitude = locationResult["longitude"] is double
          ? locationResult["longitude"] as double
          : currentLocationLongitude;
      notifyListeners();
    });
  }

  void _setLocationOption() {
    AMapLocationOption locationOption = AMapLocationOption();

    ///是否单次定位
    locationOption.onceLocation = false;

    ///是否需要返回逆地理信息
    locationOption.needAddress = true;

    ///逆地理信息的语言类型
    locationOption.geoLanguage = GeoLanguage.DEFAULT;

    locationOption.desiredLocationAccuracyAuthorizationMode =
        AMapLocationAccuracyAuthorizationMode.ReduceAccuracy;

    locationOption.fullAccuracyPurposeKey = "AMapLocationScene";

    ///设置Android端连续定位的定位间隔
    locationOption.locationInterval = 2000;

    ///设置Android端的定位模式<br>
    ///可选值：<br>
    ///<li>[AMapLocationMode.Battery_Saving]</li>
    ///<li>[AMapLocationMode.Device_Sensors]</li>
    ///<li>[AMapLocationMode.Hight_Accuracy]</li>
    locationOption.locationMode = AMapLocationMode.Hight_Accuracy;

    ///设置iOS端的定位最小更新距离<br>
    locationOption.distanceFilter = -1;

    ///设置iOS端期望的定位精度
    /// 可选值：<br>
    /// <li>[DesiredAccuracy.Best] 最高精度</li>
    /// <li>[DesiredAccuracy.BestForNavigation] 适用于导航场景的高精度 </li>
    /// <li>[DesiredAccuracy.NearestTenMeters] 10米 </li>
    /// <li>[DesiredAccuracy.Kilometer] 1000米</li>
    /// <li>[DesiredAccuracy.ThreeKilometers] 3000米</li>
    locationOption.desiredAccuracy = DesiredAccuracy.Best;

    ///设置iOS端是否允许系统暂停定位
    locationOption.pausesLocationUpdatesAutomatically = false;

    ///将定位参数设置给定位插件
    locationPlugin.setLocationOption(locationOption);
  }

  ///开始定位
  void startLocation() {
    _setLocationOption();
    locationPlugin.startLocation();
  }

  ///停止定位
  void stopLocation() {
    locationPlugin.stopLocation();
  }

  Future<bool> refreshLocation() async {
    startLocation();
    await Future.delayed(const Duration(seconds: 2));
    stopLocation();
    return true;
  }

  void requestAccuracyAuthorization() async {
    AMapAccuracyAuthorization currentAccuracyAuthorization =
        await locationPlugin.getSystemAccuracyAuthorization();
    if (currentAccuracyAuthorization ==
        AMapAccuracyAuthorization.AMapAccuracyAuthorizationFullAccuracy) {
      print("精确定位类型");
    } else if (currentAccuracyAuthorization ==
        AMapAccuracyAuthorization.AMapAccuracyAuthorizationReducedAccuracy) {
      print("模糊定位类型");
    } else {
      print("未知定位类型");
    }
  }

  /// 动态申请定位权限
  void requestGDPermission() async {
    // 申请权限
    bool hasLocationPermission = await requestLocationPermission();
    if (hasLocationPermission) {
      print("定位权限申请通过");
    } else {
      print("定位权限申请不通过");
    }
  }

  /// 申请定位权限
  /// 授予定位权限返回true， 否则返回false
  Future<bool> requestLocationPermission() async {
    //获取当前的权限
    var status = await Permission.location.status;
    if (status == PermissionStatus.granted) {
      //已经授权
      return true;
    } else {
      //未授权则发起一次申请
      status = await Permission.location.request();
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }
}
