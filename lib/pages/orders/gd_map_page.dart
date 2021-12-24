import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ttm/common/ttm_colors.dart';

import 'package:ttm/common/ttm_constants.dart';
import 'package:ttm/common/ttm_icons.dart';
import 'package:ttm/status/main_status_model.dart';
import 'package:ttm/widgets/colorful_safe_area/colorful_safe_area.dart';

// ignore: must_be_immutable
class GDMapPage extends StatefulWidget {
  GDMapPage({Key? key, required this.fakePosition}) : super(key: key);
  List<Map<String, dynamic>> fakePosition;

  @override
  _GDMapPageState createState() => _GDMapPageState();
}

class _GDMapPageState extends State<GDMapPage> {
  final gdMapPageKey = GlobalKey<ScaffoldState>();
  late MainStatusModel model;

  /// 高德
  // 地图控制器
  AMapController? mapController;
  // marker 图标
  BitmapDescriptor? markerIcon;
  // 所有货车的点位信息 用来绘制已存在的点位和连线
  List<LatLng> markerPotins = [];

  /// 定位相关
  AMapLocation? currentLocation;
  bool isInitCameraFinished = false;
  MyLocationStyleOptions myLocationStyleOptions = MyLocationStyleOptions(true);

  /// 地图相关
  // 所有点位信息
  late Map<String, Marker> markers = <String, Marker>{};
  // 所有线信息
  late Map<String, Polyline> polylines = <String, Polyline>{};
  //是否支持缩放手势
  bool zoomGesturesEnabled = true;
  //是否支持滑动手势
  bool scrollGesturesEnabled = true;
  //是否支持旋转手势
  bool rotateGesturesEnabled = true;
  //是否支持倾斜手势
  bool tiltGesturesEnabled = true;

  /// 打点功能
  /// 当前位置是实时更新的（currentLocation）
  void addMarker() {
    if (currentLocation == null) {
      return;
    } else {
      LatLng markPostion = LatLng(
          currentLocation!.latLng.latitude, currentLocation!.latLng.longitude);
      final Marker marker = Marker(
        position: markPostion,
        icon: markerIcon!,
        // clickable: false,
        // infoWindow: InfoWindow(title: '信息窗口'),
        // onTap: (markerId) => _onMarkerTapped(markerId),
        // onDragEnd: (markerId, endPosition) =>
        //     _onMarkerDragEnd(markerId, endPosition),
      );
      setState(() {
        markers[marker.id] = marker;
        drawPolylineAfterManage();
      });
    }
  }

  // 打点操作后 绘制路线图
  // 添加当前定位到 markpoints 中 并绘制
  void drawPolylineAfterManage() {
    final Polyline polyline = Polyline(
      color: TTMColors.mainBlue,
      width: 10,
      points: addCurrentPointToMarkerPoints(),
    );
    // onTap: _onPolylineTapped);
    setState(() {
      polylines[polyline.id] = polyline;
    });
  }

  // 将当前定位加到 MarkerPoints 中
  List<LatLng> addCurrentPointToMarkerPoints() {
    if (currentLocation != null) {
      markerPotins.add(LatLng(
          currentLocation!.latLng.latitude, currentLocation!.latLng.longitude));
    }
    return markerPotins;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = ScopedModel.of<MainStatusModel>(context);
    // 定位相关
    requestPermission();
    // 地图相关
    // 初始化 location 图标
    markerIcon ??= BitmapDescriptor.fromIconPath('assets/images/Location.png');
    // 初始化 位置信息
    initGoodPoints();
    initMarkers();
    initPolyline();
    model.startLocation();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    model.stopLocation();
    super.dispose();
  }

  void initGoodPoints() {
    if (widget.fakePosition.isEmpty) {
      markerPotins = [];
    } else {
      for (var item in widget.fakePosition) {
        markerPotins.add(LatLng(item["latitude"], item["longitude"]));
      }
    }
  }

  void initMarkers() {
    if (markerPotins.isNotEmpty) {
      for (var position in markerPotins) {
        var marker = Marker(position: position, icon: markerIcon!);
        markers[marker.id] = marker;
      }
    } else {
      markers = <String, Marker>{};
    }
  }

  void initPolyline() {
    if (markerPotins.isNotEmpty) {
      final Polyline polyline = Polyline(
        color: TTMColors.mainBlue,
        width: 10,
        points: markerPotins,
      );
      polylines[polyline.id] = polyline;
    } else {
      polylines = <String, Polyline>{};
    }
  }

  void onMapCreated(AMapController controller) async {
    print("map created");
    // await model.refreshLocation();
    mapController = controller;
    // mapController!.moveCamera(CameraUpdate.newCameraPosition(
    //   CameraPosition(
    //       //中心点
    //       target: LatLng(
    //           model.currentLocationLatitude, model.currentLocationLongitude),
    //       //缩放级别
    //       zoom: 5,
    //       //俯仰角0°~45°（垂直与地图时为0）
    //       tilt: 0,
    //       //偏航角 0~360° (正北方为0)
    //       bearing: 0),
    // ));
  }

  @override
  Widget build(BuildContext context) {
    // 地图相关
    final AMapWidget map = AMapWidget(
      apiKey: TTMConstants.amapApiKeys,
      initialCameraPosition: CameraPosition(
          target: LatLng(currentLocation?.latLng.latitude ?? 39.909187,
              currentLocation?.latLng.longitude ?? 116.397451),
          zoom: 4),
      onMapCreated: onMapCreated,
      onLocationChanged: onLocationChanged,
      myLocationStyleOptions: myLocationStyleOptions,
      rotateGesturesEnabled: rotateGesturesEnabled,
      scrollGesturesEnabled: scrollGesturesEnabled,
      tiltGesturesEnabled: tiltGesturesEnabled,
      zoomGesturesEnabled: zoomGesturesEnabled,
      markers: Set<Marker>.of(markers.values),
      onTap: (latlng) {
        print(latlng.latitude);
        print(latlng.longitude);
      },
      polylines: Set<Polyline>.of(polylines.values),
    );
    return Scaffold(
      key: gdMapPageKey,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        // leadingWidth: 100,
        // leading: commonBack1(color: TTMColors.white),
        title: const Text(
          "行车定位",
          // style: TTMTextStyle.whiteAppBarTitle,
        ),
        centerTitle: true,
        backgroundColor: TTMColors.mainBlue,
        elevation: 0,
      ),
      body: ColorfulSafeArea(
        topColor: TTMColors.mainBlue,
        bottomColor: TTMColors.backgroundColor,
        child: Stack(
          children: [
            map,
            // Positioned(
            //     bottom: 20,
            //     left: 20,
            //     right: 20,
            //     child: Center(
            //         child: GestureDetector(
            //       onTap: () {
            //         print("打点");
            //         addMarker();
            //       },
            //       child: Container(
            //           height: 50,
            //           width: 160,
            //           decoration: BoxDecoration(
            //               color: TTMColors.myInfoSaveBtnColor,
            //               borderRadius: BorderRadius.circular(10)),
            //           // color: Colors.black,
            //           child: Center(
            //             child: Text(
            //               "打点",
            //               style: TTMTextStyle.bottomBtnTitle,
            //             ),
            //           )),
            //     )))
          ],
        ),
      ),
    );
  }

  void onInitMapFinished() {}

  void onLocationChanged(AMapLocation location) {
    if (null == location) {
      return;
    }
    currentLocation = location;
    // currentLocation = AMapLocation(
    //     latLng: LatLng(
    //         model.currentLocationLatitude, model.currentLocationLongitude));
    //如果第一次进入 没有 init 镜头位置 更新镜头位置并设置 initCameraFinished = true
    if (!isInitCameraFinished) {
      if (mapController != null) {
        mapController!.moveCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              //中心点
              target: LatLng(currentLocation!.latLng.latitude,
                  currentLocation!.latLng.longitude),
              //缩放级别
              zoom: 5,
              //俯仰角0°~45°（垂直与地图时为0）
              tilt: 0,
              //偏航角 0~360° (正北方为0)
              bearing: 0),
        ));
        isInitCameraFinished = true;
      }
    } else {
      currentLocation = location;
      print('_onLocationChanged ${location.toJson()}');
    }
  }

  // 定位
  ///设置定位参数

  /// 动态申请定位权限
  void requestPermission() async {
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
