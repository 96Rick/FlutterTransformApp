// ignore_for_file: unused_local_variable

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ttm/common/ttm_icons.dart';
import 'package:ttm/common/ttm_size.dart';
import 'package:ttm/common/ttm_textstyle.dart';
import 'package:ttm/model/car_type_model.dart';
import 'package:ttm/model/driver_id_model.dart';
import 'package:ttm/network/api.dart';
import 'package:ttm/network/dio_manager.dart';
import 'package:ttm/status/main_status_model.dart';
import 'package:ttm/utils/date_util.dart';
import 'package:ttm/utils/net_util.dart';
import 'package:ttm/widgets/flush_bar.dart';

class AppStatus extends BaseStatus {
  Future initAppStatus() async {
    print("initAppStatus");
    isLoadingApp = true;
    notifyListeners();
    requestPermission();
    initEsayLoading();
    await getNetworkAuthority().whenComplete(() async {
      await getDriverRoleID().whenComplete(() {
        return;
      });
    });
  }

  void initAppStatusFinished() {
    print("initAppStatusFinished");
    isLoadingApp = false;
    notifyListeners();
  }

  void initEsayLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.circle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 35.0
      ..radius = 20.0
      // ..progressColor = Colors.yellow
      // ..backgroundColor = Colors.green
      // ..indicatorColor = Colors.yellow
      // ..textColor = Colors.yellow
      ..maskColor = Colors.black.withOpacity(0.5)
      ..userInteractions = false
      ..dismissOnTap = false;
  }

  Future getNetworkAuthority() async {
    print("getNetworkAuthorityStart");
    var _isConnect = await NetUtil.isConnected();
    if (_isConnect) {
      var response = await Dio().get('http://www.baidu.com');
      print("getNetworkAuthorityEnd");
    }
  }

  Future requestPermission() async {
    var cameraStatus = await Permission.camera.status;
    var photoStatus = await Permission.photos.status;
    var locationStatus = await Permission.location.status;
    var locationAlwaysStatus = await Permission.locationAlways.status;
    var locationWhenInUseStatus = await Permission.locationWhenInUse.status;
    if (cameraStatus.isLimited ||
        cameraStatus.isDenied ||
        cameraStatus.isRestricted ||
        cameraStatus.isPermanentlyDenied) {
    } else {
      Permission.camera.request().isGranted;
    }

    if (photoStatus.isLimited ||
        photoStatus.isDenied ||
        photoStatus.isRestricted ||
        photoStatus.isPermanentlyDenied) {
    } else {
      Permission.photos.request().isGranted;
    }

    if (locationStatus.isLimited ||
        locationStatus.isDenied ||
        locationStatus.isRestricted ||
        locationStatus.isPermanentlyDenied) {
    } else {
      Permission.location.request().isGranted;
    }
    if (locationAlwaysStatus.isLimited ||
        locationAlwaysStatus.isDenied ||
        locationAlwaysStatus.isRestricted ||
        locationAlwaysStatus.isPermanentlyDenied) {
    } else {
      Permission.locationAlways.request().isGranted;
    }
    if (locationWhenInUseStatus.isLimited ||
        locationWhenInUseStatus.isDenied ||
        locationWhenInUseStatus.isRestricted ||
        locationWhenInUseStatus.isPermanentlyDenied) {
    } else {
      Permission.locationWhenInUse.request().isGranted;
    }
  }

  Future getDriverRoleID() async {
    print("getDriverRoleIDStart");
    var _isConnect = await NetUtil.isConnected();
    if (_isConnect) {
      var param = {
        "fields": "id",
        "filter": {
          "name": {"_eq": "司机"}
        },
        "limit": 1
      };
      await DioManager()
          .getList<DriverIDModel>(API.getDriverRoleID,
              params: param, onSuccess: (v) {}, onError: (e) {})
          .whenComplete(() {
        print("getDriverRoleIDSDone");
      });
    }
  }

  Future getCarTypeList() async {
    var _isConnect = await NetUtil.isConnected();
    if (_isConnect) {
      var param = {
        "filter": {
          "level": {"_eq": "1"},
          "md_ctgy": {"_eq": "8aab6af2-76d6-4024-b9d4-1d0118863363"}
        },
        "fields": "name,id,mds.id,mds.name,mds.mds.id,mds.mds.name",
        "sort": "id",
        "meta": "filter_count"
      };
      await DioManager().getList<CarTypeModel>(API.getCarTypeList,
          params: param, onSuccess: (list) {
        if (list.isNotEmpty) {
          carTypeModelList = list;
          notifyListeners();
        }
      }, onError: (e) {});
    }
  }

  Future choseDate(BuildContext context, Function(String date) onFinish) async {
    var result = await showDatePicker(
        locale: const Locale('zh'),
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(3000));
    print(result);
    if (result != null) {
      onFinish("${result.year}-${result.month}-${result.day}");
    } else {
      onFinish("");
    }
  }

  void showImageChooser(BuildContext context, Function(String id) onSuccess,
      Function() onFailed) {
    ImagePicker _picker = ImagePicker();
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      context: context,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: GestureDetector(
              onTap: () async {
                Navigator.of(context).pop();
                EasyLoading.show(status: '加载中');
                var image = await _picker.pickImage(source: ImageSource.camera);
                if (image != null) {
                  var id = await uploadPicAndGetId(image, context);
                  if (id != "") {
                    onSuccess(id);
                  } else {
                    onFailed();
                  }
                }
                EasyLoading.dismiss();
              },
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Colors.white,
                ),
                margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 10),
                // padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(CupertinoIcons.photo_camera,
                        size: 30, color: Colors.black),
                    Container(
                      width: 20,
                    ),
                    const Text(
                      "拍照",
                      style: TTMTextStyle.secondTitle,
                    )
                  ],
                ),
                height: 60,
                width: TTMSize.screenWidth,
              ),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () async {
                Navigator.of(context).pop();
                EasyLoading.show(status: '加载中');
                var image =
                    await _picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  var id = await uploadPicAndGetId(image, context);
                  if (id != "") {
                    onSuccess(id);
                  } else {
                    onFailed();
                  }
                }
                EasyLoading.dismiss();
              },
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.white),
                margin: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 20, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(CupertinoIcons.photo,
                        size: 30, color: Colors.black),
                    Container(
                      width: 20,
                    ),
                    const Text(
                      "从相册选择",
                      style: TTMTextStyle.secondTitle,
                    )
                  ],
                ),
                height: 60,
                width: TTMSize.screenWidth,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> uploadPicAndGetId(XFile image, BuildContext context) async {
    var newImageId = "";
    var folderName = await getPicFoldersName();
    if (folderName == "") {
      var fName = await createPicFolder();
      if (fName == "") {
      } else {
        var id = await uploadFile(image, fName);
        newImageId = id;
      }
      return newImageId;
    } else {
      var id = await uploadFile(image, folderName);
      newImageId = id;
      return newImageId;
    }
  }

  Future<String> getPicFoldersName() async {
    var id = "";
    var _isConnect = await NetUtil.isConnected();
    if (_isConnect) {
      var param = {
        "name": {"_eq": DateUtil.getCurrentDateString()}
      };
      await DioManager().getList(API.getCurrentPicFoldersStatus, params: param,
          onSuccess: (list) {
        if (list.isNotEmpty) {
          for (var item in list) {
            if (item is Map<String, dynamic>) {
              var data = item;
              if (data["name"] is String) {
                var name = data["name"] as String;
                if (name == DateUtil.getCurrentDateString()) {
                  if (data["id"] is String) {
                    id = data["id"] as String;
                    break;
                  }
                }
              }
            }
          }
        }
      }, onError: (e) {});
    }
    return id;
  }

  Future<String> createPicFolder() async {
    var id = "";
    var _isConnect = await NetUtil.isConnected();
    if (_isConnect) {
      var param = {"name": DateUtil.getCurrentDateString()};
      await DioManager().post(API.getCurrentPicFoldersStatus, data: param,
          onSuccess: (data) {
        if (data is Map<String, dynamic>) {
          if (data["id"] is String) {
            id = data["id"] as String;
          }
        }
      }, onError: (e) {});
    }
    return id;
  }

  Future<String> uploadFile(XFile image, String folderName) async {
    var imageId = "";
    var _isConnect = await NetUtil.isConnected();
    if (_isConnect) {
      var path = image.path;
      var name = path.substring(path.lastIndexOf("/") + 1, path.length);

      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(path, filename: name),
        "folder": folderName,
      });
      await DioManager().post(API.uploadFiles, data: formData,
          onSuccess: (data) {
        if (data is Map<String, dynamic>) {
          if (data["id"] is String) {
            imageId = data["id"] as String;
          }
        }
      }, onError: (e) {
        return imageId;
      });
    }
    return imageId;
  }
}
