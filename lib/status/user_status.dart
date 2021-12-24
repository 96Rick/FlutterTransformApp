import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ttm/common/ttm_constants.dart';
import 'package:ttm/model/driver_id_model.dart';
import 'package:ttm/model/goods_models/contract_model.dart';
import 'package:ttm/model/profile_models/all_car_info_model.dart';
import 'package:ttm/model/profile_models/attached_model.dart';
import 'package:ttm/model/profile_models/cars_in_fleet_model.dart';
import 'package:ttm/model/profile_models/join_fleet_model.dart';
import 'package:ttm/model/profile_models/my_detail_info_model.dart';
import 'package:ttm/model/token_model.dart';
import 'package:ttm/model/profile_models/user_info_model.dart';
import 'package:ttm/network/api.dart';
import 'package:ttm/network/dio_manager.dart';
import 'package:ttm/status/main_status_model.dart';
import 'package:ttm/status/token_status.dart';
import 'package:ttm/utils/net_util.dart';
import 'package:ttm/utils/sp_util.dart';
import 'package:ttm/widgets/flush_bar.dart';

class UserStatus extends BaseStatus {
  void initAuthorityStatus() {
    print("initAuthorityStatus");
    getIsRememberMe();
    getSavedUserName();
    getSavedUserEmail();
  }

  // 初始化 用户信息
  Future initUserData(BuildContext context) async {
    print("init User Data Start ");
    // await Future.delayed(Duration(milliseconds: 500));
    await getUserBaseInfo(context).whenComplete(() async {
      await getAllCarInfoList(context).whenComplete(() {
        print("get car list Finish");
      });
    }).whenComplete(() async {
      print("get user info Finish");
    });
    notifyListeners();
    print("init User Data finish ");
    return;
  }

  // 获取 卡片车辆
  // Future getMyCarCardInfo(BuildContext context) async {
  //   EasyLoading.show(status: '加载中');
  //   print("get car list start ");
  //   await Future.delayed(Duration(milliseconds: 500));
  //   if (UserInfoModel().driver != null) {
  //     var params = {
  //       "filter": {
  //         "del": {"_eq": 0},
  //         "driver": {
  //           "driver_id": {"_eq": "3336906e-f21f-4ffb-8026-16a9a2c9f8ca"}
  //         },
  //         "owner_driver": {"_nnull": "true"}
  //       },
  //       "fields": "license_plate_number,license_color,status"
  //     };
  //     await DioManager().getList<MyCarCardInfoModel>(API.getCarInfo,
  //         params: params, onSuccess: (list) {
  //       myCarCardInfoList = list;
  //       print("get car list success ");
  //       EasyLoading.dismiss();
  //       return;
  //     }, onError: (error) {
  //       print("get car list error ");
  //       print("get car list error ");
  //       EasyLoading.dismiss();
  //       FlushBarWidget.createDanger("获取车辆列表失败", context);
  //       return;
  //     });
  //   } else {
  //     EasyLoading.dismiss();
  //     print("get car list error ");
  //     return;
  //   }
  // }

  // 获取 我的全部车辆
  Future getAllCarInfoList(BuildContext context) async {
    EasyLoading.show(status: '加载中');
    print("get all car list start ");
    // await Future.delayed(Duration(milliseconds: 200));
    if (UserInfoModel().driver != null) {
      var params = {
        "filter": {
          "del": {"_eq": 0},
          "driver": {
            "driver_id": {"_eq": UserInfoModel().driver}
          }
        },
        "fields":
            "*,driver.driver_id,owner_company.company_name,owner_driver.id",
        "sort": "-date_created",
      };
      await DioManager().getList<AllCarInfoModel>(API.getCarInfo,
          params: params, onSuccess: (list) {
        allCarsInfoList = list;
        profileCarCardList = [];
        for (var item in allCarsInfoList) {
          if (item.owner_driver != null) {
            profileCarCardList.add(item);
          }
        }
        notifyListeners();
        print("get all car list success ");
        EasyLoading.dismiss();
        return;
      }, onError: (error) {
        print("get all car list error");
        print("get all car list error");
        EasyLoading.dismiss();
        FlushBarWidget.createDanger("获取全部车辆列表失败", context);
        return;
      });
    } else {
      EasyLoading.dismiss();
      print("get all car list error");
      return;
    }
  }

  // 获取 用户基础信息
  Future<bool> getUserBaseInfo(BuildContext context) async {
    EasyLoading.show(status: '加载中');
    var _isConnect = await NetUtil.isConnected();
    if (_isConnect) {
      var params = {
        "filter": {
          "del": {"_eq": 0},
          "email": {"_eq": userEmail}
        },
        "fields": "first_name,email,driver,id,tel"
      };
      await DioManager().getList(API.getUserBaseInfo, params: params,
          onSuccess: (list) {
        if (list.isNotEmpty) {
          UserInfoModel.fromJson(list.first as Map<String, dynamic>);
          currentUserDetailPhoneNumberInfo = UserInfoModel().tel ?? "";
          currentUserDetailNameInfo = UserInfoModel().first_name ?? "";
        }
      }, onError: (error) {
        print("get user info faild ");
        EasyLoading.dismiss();
        FlushBarWidget.createDanger("获取用户信息失败", context);
        return false;
      });
      EasyLoading.dismiss();
      return true;
    } else {
      print("get user info faild ");
      EasyLoading.dismiss();
      FlushBarWidget.createNetworkNotContected(context);
      return false;
    }
  }

  // 获取 用户详细信息
  Future<bool> getMyDetaillInfo(BuildContext context) async {
    bool isGetUserBaseInfoSuccess = await getUserBaseInfo(context);
    EasyLoading.show(status: '加载中');
    print("get my info info start ");
    if (isGetUserBaseInfoSuccess) {
      var _isConnect = await NetUtil.isConnected();
      if (_isConnect) {
        if (UserInfoModel().driver != null) {
          var params = {
            "filter": {
              "id": {"_eq": UserInfoModel().driver}
            },
            "fields":
                "id,status,execution,account,driver_start,driver_end,name,id_card,police_station,id_card_start,id_card_end,certificate,attached,shipper,transportion,company.company_id.company_name,company.company_id.id,driver_audit.status,driver_audit.company.company_name,owner_transportation"
          };
          await DioManager().getList<MyDetailInfoModel>(API.myInfo,
              params: params, onSuccess: (list) {
            if (list.isNotEmpty) {
              myDetailInfoModel = list.first;
              if (myDetailInfoModel.company.isNotEmpty) {
                isUserAlreadyJoinFleet = true;
                isUserWaitingFleetParaExaminar = false;
                isUserNotJoinFleet = false;
              } else if (myDetailInfoModel.driverAudit.isNotEmpty) {
                isUserWaitingFleetParaExaminar = false;
                isUserAlreadyJoinFleet = false;
                isUserNotJoinFleet = true;
                for (var item in myDetailInfoModel.driverAudit) {
                  if (item.status == "1") {
                    userWaitingFleetParaExaminarCompanyName =
                        item.company.companyName ?? "";

                    isUserWaitingFleetParaExaminar = true;
                    isUserAlreadyJoinFleet = false;
                    isUserNotJoinFleet = false;
                    break;
                  }
                }
              } else {
                isUserWaitingFleetParaExaminar = false;
                isUserAlreadyJoinFleet = false;
                isUserNotJoinFleet = true;
              }

              currentUserDetailNameInfo =
                  myDetailInfoModel.name ?? UserInfoModel().first_name ?? "";
            }
          }, onError: (error) {
            EasyLoading.dismiss();
            notifyListeners();
            return false;
          });
          EasyLoading.dismiss();
          notifyListeners();
          return true;
        } else {
          EasyLoading.dismiss();
          notifyListeners();
          return false;
        }
      } else {
        EasyLoading.dismiss();
        notifyListeners();
        return false;
      }
    } else {
      EasyLoading.dismiss();
      notifyListeners();
      return false;
    }
  }

  Future<bool> searchCarFleet(String inputStr, BuildContext context) async {
    EasyLoading.show(status: '加载中');
    var _isConnect = await NetUtil.isConnected();
    if (_isConnect) {
      var params;
      if (inputStr == "") {
        params = {
          "filter": {
            "_and": [
              {
                "del": {"_eq": "0"}
              },
              {
                "status": {"_eq": "2"}
              },
              {
                "type": {"_eq": "2"}
              }
            ]
          },
          "fields": "id,company_name",
        };
      } else {
        params = {
          "filter": {
            "_and": [
              {
                "del": {"_eq": "0"}
              },
              {
                "status": {"_eq": "2"}
              },
              {
                "type": {"_eq": "2"}
              }
            ],
            "_or": [
              {
                "company_name": {"_eq": inputStr}
              },
              {
                "contact_phone": {"_eq": inputStr}
              },
              {
                "contact_name": {"_eq": inputStr}
              }
            ],
          },
          "fields": "id,company_name",
        };
      }
      await DioManager().getList<JoinFleetModel>(API.searchCarFleets,
          params: params, onSuccess: (carFleetList) {
        searchCarFleetList = carFleetList;
      }, onError: (onError) {
        EasyLoading.dismiss();
        notifyListeners();
        return false;
      });
      EasyLoading.dismiss();
      notifyListeners();
      return true;
    } else {
      EasyLoading.dismiss();
      notifyListeners();
      return false;
    }
  }

  Future<bool> joinFleet(String companyID) async {
    EasyLoading.show(status: '加载中');
    if (UserInfoModel().driver != null) {
      var params = {
        "status": "1",
        "driver": UserInfoModel().driver,
        "company": companyID
      };
      await DioManager().post(API.joinFleet, data: params, onSuccess: (result) {
        fleetCompanyId = companyID;
      }, onError: (error) {
        EasyLoading.dismiss();
        return false;
      });
      EasyLoading.dismiss();
      notifyListeners();
      return true;
    } else {
      EasyLoading.dismiss();
      return false;
    }
  }

  Future<bool> exitFleet() async {
    EasyLoading.show(status: '加载中');
    // 步骤一 查询当前车队下的车辆信息
    Map<String, dynamic> searchCarInFleetParams = {
      "filter": {
        "id": {"_eq": myDetailInfoModel.company.first.companyId.id}
      },
      "fields": "transportation.*"
    };
    List<Transportation> allCarsInFleet = [];
    List<Transportation> allCarsAfterFilterInFleet = [];
    await DioManager().getList<CarsInFleetModel>(API.searchCarFleets,
        params: searchCarInFleetParams, onSuccess: (list) {
      // 步骤2 将当前司机的个人车辆和车队全部车辆比对，如存在相同，则去掉
      if (list.isNotEmpty) {
        allCarsInFleet = list.first.transportation;
        if (allCarsInFleet.isNotEmpty) {
          for (var carInFleet in allCarsInFleet) {
            if (!myDetailInfoModel.ownerTransportation
                .contains(carInFleet.transportationId)) {
              allCarsAfterFilterInFleet.add(carInFleet);
            }
          }
        }
      }
    }, onError: (e) {
      EasyLoading.dismiss();
      return false;
    });

    // 步骤3 更新新的车辆列表 到车队
    List<Map<String, dynamic>> newFleetUpdateCars = [];
    for (var item in allCarsAfterFilterInFleet) {
      if (item.transportationId != null) {
        newFleetUpdateCars.add(item.toOnlyCompanyIDAndTransportationIDJson());
      }
    }
    var updateNewCarsInFleetData = {"transportation": newFleetUpdateCars};
    await DioManager().patch(
      API.searchCarFleets + "/" + myDetailInfoModel.company.first.companyId.id!,
      data: updateNewCarsInFleetData,
      onSuccess: (entity) async {},
      onError: (error) {
        EasyLoading.dismiss();
        return false;
      },
    );

    /// 步骤四 司机逻辑
    /// 更新当前司机车辆信息（transportation）= 司机个人的车辆信息
    List<Map<String, dynamic>> newPersionalCars = [];
    for (var item in myDetailInfoModel.ownerTransportation) {
      newPersionalCars.add(
          {"transportation_id": item, "driver_id": UserInfoModel().driver!});
    }
    var updateNewPersionalCarsData = {"transportation": newPersionalCars};
    await DioManager().patch(
      API.myInfo + "/" + UserInfoModel().driver!,
      data: updateNewPersionalCarsData,
      onSuccess: (entity) async {},
      onError: (error) {
        EasyLoading.dismiss();
        return false;
      },
    );

    /// 步骤五 更新司机车队信息为空
    await DioManager().patch(
      API.myInfo + "/" + UserInfoModel().driver!,
      data: {"company": []},
      onSuccess: (entity) async {},
      onError: (error) {
        EasyLoading.dismiss();
        return false;
      },
    );
    EasyLoading.dismiss();
    return true;
  }

  Future<bool> addMyInfo(
      MyDetailInfoModel infoModel, String tel, BuildContext context) async {
    EasyLoading.show(status: '加载中');
    var _isConnect = await NetUtil.isConnected();
    if (_isConnect) {
      Map<String, dynamic> data;
      data = infoModel.toJson();
      data["account"] = {"id": UserInfoModel().id, "tel": tel};
      data["status"] = "1";
      await DioManager().post(
        API.myInfo,
        data: data,
        onSuccess: (entity) async {},
        onError: (error) {
          EasyLoading.dismiss();
          return false;
        },
      );
      EasyLoading.dismiss();
      return true;
    } else {
      EasyLoading.dismiss();
      return false;
    }
  }

  Future<bool> modifyMyInfo(
      MyDetailInfoModel infoModel, String tel, BuildContext context) async {
    EasyLoading.show(status: '加载中');
    var _isConnect = await NetUtil.isConnected();
    if (_isConnect) {
      Map<String, dynamic> data;
      data = infoModel.toJson();
      data["account"] = {"id": UserInfoModel().id, "tel": tel};
      data["status"] = "1";
      if (UserInfoModel().driver == null) {
        EasyLoading.dismiss();
        return false;
      }
      await DioManager().patch(
        API.myInfo + "/" + UserInfoModel().driver!,
        data: data,
        onSuccess: (entity) async {},
        onError: (error) {
          EasyLoading.dismiss();
          return false;
        },
      );
      EasyLoading.dismiss();
      return true;
    } else {
      EasyLoading.dismiss();
      return false;
    }
  }

  Future<bool> addMyCar(
      AllCarInfoModel carInfoModel, BuildContext context) async {
    EasyLoading.show(status: '加载中');
    var _isConnect = await NetUtil.isConnected();
    if (_isConnect) {
      Map<String, dynamic> data;
      data = carInfoModel.toUpdateJson();
      data["account"] = UserInfoModel().id;
      data["driver"] = [
        {"driver_id": UserInfoModel().driver}
      ];
      data["status"] = "1";
      data["owner_driver"] = UserInfoModel().driver;

      if (myDetailInfoModel.company.isNotEmpty) {
        data["company"] = [
          {"company_id": myDetailInfoModel.company.first.companyId.id}
        ];
      }
      await DioManager().post(
        API.getCarInfo,
        data: data,
        onSuccess: (entity) async {},
        onError: (error) {
          EasyLoading.dismiss();
          return false;
        },
      );
      EasyLoading.dismiss();
      return true;
    } else {
      EasyLoading.dismiss();
      return false;
    }
  }

  Future<bool> modifyMyCar(
      AllCarInfoModel carInfoModel, BuildContext context) async {
    EasyLoading.show(status: '加载中');
    var _isConnect = await NetUtil.isConnected();
    if (_isConnect) {
      Map<String, dynamic> data;
      data = carInfoModel.toUpdateJson();
      data["account"] = UserInfoModel().id;
      data["driver"] = [
        {"driver_id": UserInfoModel().driver}
      ];
      data["status"] = "1";
      data["owner_driver"] = UserInfoModel().driver;
      if (myDetailInfoModel.company.isNotEmpty) {
        data["company"] = [
          {"company_id": myDetailInfoModel.company.first.companyId.id}
        ];
      }
      if (carInfoModel.id == null) {
        EasyLoading.dismiss();
        return false;
      }
      await DioManager().patch(
        API.getCarInfo + "/" + carInfoModel.id!,
        data: data,
        onSuccess: (entity) async {},
        onError: (error) {
          EasyLoading.dismiss();
          return false;
        },
      );
      EasyLoading.dismiss();
      return true;
    } else {
      EasyLoading.dismiss();
      return false;
    }
  }

  Future<bool> unboundCar(AllCarInfoModel carModel) async {
    //  步骤一 if （transportation 的 owner_driver==当前司机id），接口参考postman 1.1.11
    // 更新transportation表driver=[]，transportation表company=[]，
    // transportation表del=1，更新接口参考postman1.1.14
    EasyLoading.show(status: '加载中');
    var data = {"driver": [], "del": "1", "company": []};
    if (carModel.owner_driver == UserInfoModel().driver) {
      await DioManager().patch(API.getCarInfo + "/" + carModel.id!,
          data: data, onSuccess: (entity) async {}, onError: (error) {
        EasyLoading.dismiss();
        return false;
      });

      // 步骤二 更新drive表的owner_transportation移除当前解绑的这辆车的id，更新接口参考postman1.1.47

      List<String> originOwnerTransportation =
          myDetailInfoModel.ownerTransportation;

      List<String> newOwnerTransportation = [];
      for (var item in originOwnerTransportation) {
        if (item != carModel.id) {
          newOwnerTransportation.add(item);
        }
      }
      await DioManager().patch(API.myInfo + "/" + UserInfoModel().driver!,
          data: {"owner_transportation": newOwnerTransportation},
          onSuccess: (entity) async {}, onError: (error) {
        EasyLoading.dismiss();
        return false;
      });
      EasyLoading.dismiss();
      return true;
    } else {
      // 更新transportation表driver的关系中移除当前司机信息，更新接口参考postman1.1.14，
      List<Driver> originTransportationDrivers = carModel.driver;
      List<Driver> newTransportationDrivers = [];
      for (var item in originTransportationDrivers) {
        if (item.driverId != UserInfoModel().driver) {
          newTransportationDrivers.add(item);
        }
      }
      await DioManager().patch(API.getCarInfo + "/" + carModel.id!,
          data: {
            "driver": List<dynamic>.from(
                newTransportationDrivers.map((x) => x.toJson())),
          },
          onSuccess: (entity) async {}, onError: (error) {
        EasyLoading.dismiss();
        return false;
      });
      EasyLoading.dismiss();
      return true;
    }
  }

  Future<bool> changePwd(String pwd, String confirmPwd) async {
    EasyLoading.show(status: '加载中');
    var _isConnect = await NetUtil.isConnected();
    if (_isConnect) {
      Map<String, dynamic> data = {};
      data["password"] = pwd;
      data["passwordConfirm"] = confirmPwd;

      if (UserInfoModel().id == null) {
        EasyLoading.dismiss();
        return false;
      }
      await DioManager().patch(
        API.getUserBaseInfo + "/" + UserInfoModel().id!,
        data: data,
        onSuccess: (entity) async {},
        onError: (error) {
          EasyLoading.dismiss();
          return false;
        },
      );
      EasyLoading.dismiss();
      return true;
    } else {
      EasyLoading.dismiss();
      return false;
    }
  }

  Future<bool> checkUserIdCardIsExist(
      String idNumber, BuildContext context) async {
    bool isExit = false;
    EasyLoading.show(status: '加载中');
    var _isConnect = await NetUtil.isConnected();
    if (_isConnect) {
      var params = {
        "filter": {
          "id_card": {"_eq": idNumber}
        },
        "fields": "id_card"
      };
      await DioManager().getList(API.driver, params: params, onSuccess: (data) {
        if (data.isNotEmpty) {
          EasyLoading.dismiss();
          isExit = true;
        } else {
          EasyLoading.dismiss();
          isExit = false;
        }
      }, onError: (e) {
        EasyLoading.dismiss();
        isExit = false;
      });
    } else {
      isExit = false;
      EasyLoading.dismiss();
    }
    return isExit;
  }

  Future<bool> checkCarNumberIsExist(
      String carNumber, BuildContext context) async {
    bool isExit = false;
    EasyLoading.show(status: '加载中');
    var _isConnect = await NetUtil.isConnected();
    if (_isConnect) {
      var params = {
        "filter": {
          "license_plate_number": {"_eq": carNumber}
        },
        "fields": "license_plate_number"
      };
      await DioManager().getList(API.getCarInfo, params: params,
          onSuccess: (data) {
        if (data.isNotEmpty) {
          EasyLoading.dismiss();
          isExit = true;
        } else {
          EasyLoading.dismiss();
          isExit = false;
        }
      }, onError: (e) {
        EasyLoading.dismiss();
        isExit = false;
      });
    } else {
      isExit = false;
      EasyLoading.dismiss();
    }
    return isExit;
  }

  // 注册
  Future register(String email, String name, String password,
      String confirmPassword, BuildContext context) async {
    EasyLoading.show(status: '加载中');
    var _isConnect = await NetUtil.isConnected();
    if (_isConnect) {
      await DioManager().post(
        API.register,
        data: {
          "email": email,
          "first_name": name,
          "password": password,
          "passwordConfirm": confirmPassword,
          "role": DriverIDModel().id ?? TTMConstants.driverRoleId,
        },
        onSuccess: (entity) async {
          if (entity == null) {
            EasyLoading.dismiss();
            Navigator.pop(context);
            FlushBarWidget.createDone("注册成功", context);
          }
        },
        onError: (error) {
          EasyLoading.dismiss();
          if (error.code == "400") {
            FlushBarWidget.createDanger("邮箱已经存在", context);
          } else {
            FlushBarWidget.createDanger("注册失败", context);
          }
        },
      );
    } else {
      EasyLoading.dismiss();
      FlushBarWidget.createNetworkNotContected(context);
    }
  }

  // 登出
  void logout() {
    getIsRememberMe();
    getSavedUserName();
    TokenStatus().deleteAllTokenData();
    isNeedReLogin = true;
    homePageIndex = 0;
    UserInfoModel().driver = null;
    UserInfoModel().email = null;
    UserInfoModel().first_name = null;
    UserInfoModel().id = null;
    UserInfoModel().tel = null;
    myCarCardInfoList = [];
    myDetailInfoModel = MyDetailInfoModel(
        attached: AttachedModel(),
        company: [],
        driverAudit: [],
        ownerTransportation: []);
    isUserAlreadyJoinFleet = false;
    isUserWaitingFleetParaExaminar = false;
    userWaitingFleetParaExaminarCompanyName = "";
    isUserNotJoinFleet = true;
    currentUserDetailPhoneNumberInfo = "";
    currentUserDetailNameInfo = "";
    allCarsInfoList = [];
    profileCarCardList = [];
    searchCarFleetList = [];
    fleetCompanyId = "";

    intentionListFilterTypes = [2, 3, 4, 5, 6, 7, 8, 9];
    goodsListFilterTypes = [1, 4, 6, 8];
    intentionFilterDateStart = "";
    intentionFilterDateEnd = "";
    goodsFilterDateStart = "";
    goodsFilterDateEnd = "";
    currentGoodsList = [];
    isCurrentGoodsExpanded = [];
    currentIntentionsList = [];
    isCurrentIntentionExpanded = [];

    wayBillWaitingAcceptlist = [];
    wayBillWaitingPickedUplist = [];
    wayBillWaitingServicelist = [];
    wayBillConfirmationReceiptlist = [];
    wayBillEvaluatelist = [];
    invoiceListFilterTypes = [1, 2, 3, 4, 5, 6];
    invoiceFilterDateStart = "";
    invoiceFilterDateEnd = "";
    invoiceActualCode = "";
    settlementInvoiceList = [];
    receivableListFilterTypes = [1, 2, 3, 4];
    receivableFilterDateStart = "";
    receivableFilterDateEnd = "";
    receivableActualCode = "";
    settlementReceivableList = [];

    contractInfoModel = ContractInfoModel();

    notifyListeners();
  }

  // 登陆
  Future login(String username, String password, BuildContext context) async {
    EasyLoading.show(status: '加载中');
    var _isConnect = await NetUtil.isConnected();
    if (_isConnect) {
      await Future.delayed(const Duration(milliseconds: 500), () {});
      await DioManager().post<TokenModel>(
        API.loginPath,
        data: {"email": username, "password": password},
        onSuccess: (newToken) async {
          tokenModel = newToken;
          SpUtil.set(TTMConstants.accessToken, newToken.accessToken);
          SpUtil.set(TTMConstants.refreshToken, newToken.refreshToken);
          SpUtil.set(TTMConstants.tokenExpiresTime, newToken.expiresIn);
          setSavedUserEmail(username);
          await Future.delayed(const Duration(milliseconds: 200), () {});
          EasyLoading.dismiss();
          isNeedReLogin = false;
          notifyListeners();
        },
        onError: (error) {
          EasyLoading.dismiss();
          if (error.code == "400") {
            FlushBarWidget.createDanger("登录失败，请检查用户名密码是否正确", context);
          } else if (error.code == "401") {
            FlushBarWidget.createDanger("密码错误，请重新输入", context);
          } else {
            FlushBarWidget.createDanger("发生了未知错误", context);
          }
        },
      );
    } else {
      EasyLoading.dismiss();
      FlushBarWidget.createNetworkNotContected(context);
    }
  }

  void setIsRememberMe(bool isRem) {
    print("set is Remember begin");
    SpUtil.set(TTMConstants.isRememberMe, isRem);
    isRememberMe = isRem;
    print("set is Remember end");
    notifyListeners();
  }

  void getIsRememberMe() {
    print("get is Remember  begin");
    var isRem = SpUtil.get(TTMConstants.isRememberMe);
    isRememberMe = (isRem is bool && isRem != null) ? isRem : false;
    notifyListeners();
    print("get is Remember  end");
  }

  void setSavedUserName(String username) {
    print("set is saved user name begin");
    SpUtil.set(TTMConstants.savedUserName, username);
    savedUserName = username;
    notifyListeners();
    print("set is saved user name end");
  }

  void getSavedUserName() {
    print("get saved username  begin");
    var username = SpUtil.get(TTMConstants.savedUserName);
    savedUserName = (username is String && username != null) ? username : "";
    notifyListeners();
    print("get saved username  end");
  }

  void setSavedUserEmail(String email) {
    print("set user email start ");
    SpUtil.set(TTMConstants.savedUserEmail, email);
    userEmail = email;
    notifyListeners();
    print("set user email end ");
  }

  void getSavedUserEmail() {
    print("get saved user email  begin");
    var email = SpUtil.get(TTMConstants.savedUserEmail);
    userEmail = (email is String && email != null) ? email : "";
    notifyListeners();
    print("get saved user email  end");
  }
}
