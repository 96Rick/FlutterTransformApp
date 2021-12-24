import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ttm/model/profile_models/user_info_model.dart';
import 'package:ttm/model/way_bill_models/source_model.dart';
import 'package:ttm/model/way_bill_models/wall_bill_model.dart';
import 'package:ttm/network/api.dart';
import 'package:ttm/network/dio_manager.dart';
import 'package:ttm/status/main_status_model.dart';
import 'package:ttm/status/user_status.dart';
import 'package:ttm/utils/string_util.dart';
import 'package:ttm/widgets/flush_bar.dart';

class WayBillStatus extends BaseStatus with UserStatus {
  Future initWayBillList() async {
    EasyLoading.show(status: "加载中");
    await Future.delayed(Duration(seconds: 2));
    var params = {
      "fields":
          "id,status,attached,order_carrier.id,order_carrier.status,order_carrier.evaluation,order_carrier.score,order_carrier.code,order_carrier.intention.id,order_carrier.intention.order_carrier,order_carrier.intention.order_shipper,order_carrier.intention.demand.remark,order_carrier.intention.demand.pickup_address,order_carrier.intention.demand.receiving_address,order_carrier.intention.demand.pickup_start,order_carrier.intention.demand.pickup_end,order_carrier.intention.demand.receiving_start,order_carrier.intention.demand.receiving_end,order_carrier.intention.demand.price,order_carrier.intention.demand.receiving_tel,order_carrier.intention.demand.receiving_name,order_carrier.intention.demand.shipper.id,order_carrier.intention.demand.shipper.company_name,order_carrier.intention.demand.shipper.company_code,order_carrier.intention.demand.shipper.contact_name,order_carrier.intention.demand.shipper.contact_tel,order_carrier.intention.demand.shipper.contact_phone,order_carrier.intention.demand.shipper.attached,order_carrier.intention.demand.goods_type.name,order_carrier.intention.demand.pickup_city.name,order_carrier.intention.demand.pickup_province.name,order_carrier.intention.demand.pickup_area.name,order_carrier.intention.demand.transport_mode.name,order_carrier.intention.demand.receiving_province.name,order_carrier.intention.demand.receiving_city.name,order_carrier.intention.demand.receiving_area.name,order_carrier.intention.demand.goods.name,order_carrier.intention.demand.goods.count,order_carrier.intention.demand.goods.volume,order_carrier.intention.demand.goods.weight,order_carrier.intention.demand.goods.classification.name,order_carrier.intention.demand.total_weight,order_carrier.intention.demand.total_volume,order_carrier.intention.demand.total_count,order_carrier.intention.demand.transport_mode.name,driver.name,transportation.license_plate_number",
      "filter": {
        "del": {"_eq": 0},
        "driver": {"_eq": UserInfoModel().driver},
        "status": {
          "_in": [2, 3, 4, 5, 6, 9, 10]
        }
      },
      "sort": "-date_created",
    };
    await DioManager().getList<WayBillModel>(API.execution, params: params,
        onSuccess: (list) {
      wayBillWaitingAcceptlist = [];
      wayBillWaitingPickedUplist = [];
      wayBillWaitingServicelist = [];
      wayBillConfirmationReceiptlist = [];
      // wayBillEvaluatelist = [];
      if (list.isNotEmpty) {
        for (var item in list) {
          switch (item.status) {
            case "2":
              wayBillWaitingAcceptlist.add(item);
              break;
            case "3":
              wayBillWaitingPickedUplist.add(item);
              break;
            case "4":
              wayBillWaitingServicelist.add(item);
              break;
            case "5":
            case "6":
              wayBillConfirmationReceiptlist.add(item);
              break;
            default:
          }
          // if (item.orderCarrier.status != null ||
          //     item.orderCarrier.status != "") {
          //   if (item.orderCarrier.status == "9" ||
          //       item.orderCarrier.status == "10") {
          //     wayBillEvaluatelist.add(item);
          //   }
          // }
        }
      }
    }, onError: (error) {
      notifyListeners();
      EasyLoading.dismiss();
      return;
    });
    var evaluateParams = {
      "fields":
          "id,status,attached,order_carrier.id,order_carrier.status,order_carrier.evaluation,order_carrier.score,order_carrier.code,order_carrier.intention.id,order_carrier.intention.order_carrier,order_carrier.intention.order_shipper,order_carrier.intention.demand.remark,order_carrier.intention.demand.pickup_address,order_carrier.intention.demand.receiving_address,order_carrier.intention.demand.pickup_start,order_carrier.intention.demand.pickup_end,order_carrier.intention.demand.receiving_start,order_carrier.intention.demand.receiving_end,order_carrier.intention.demand.price,order_carrier.intention.demand.receiving_tel,order_carrier.intention.demand.receiving_name,order_carrier.intention.demand.shipper.id,order_carrier.intention.demand.shipper.company_name,order_carrier.intention.demand.shipper.company_code,order_carrier.intention.demand.shipper.contact_name,order_carrier.intention.demand.shipper.contact_tel,order_carrier.intention.demand.shipper.contact_phone,order_carrier.intention.demand.shipper.attached,order_carrier.intention.demand.goods_type.name,order_carrier.intention.demand.pickup_city.name,order_carrier.intention.demand.pickup_province.name,order_carrier.intention.demand.pickup_area.name,order_carrier.intention.demand.transport_mode.name,order_carrier.intention.demand.receiving_province.name,order_carrier.intention.demand.receiving_city.name,order_carrier.intention.demand.receiving_area.name,order_carrier.intention.demand.goods.name,order_carrier.intention.demand.goods.count,order_carrier.intention.demand.goods.volume,order_carrier.intention.demand.goods.weight,order_carrier.intention.demand.goods.classification.name,order_carrier.intention.demand.total_weight,order_carrier.intention.demand.total_volume,order_carrier.intention.demand.total_count,order_carrier.intention.demand.transport_mode.name,driver.name,transportation.license_plate_number",
      "filter": {
        "_and": [
          {
            "del": {"_eq": "0"}
          },
          {
            "order_carrier": {
              "intention": {
                "driver": {"_eq": UserInfoModel().driver}
              }
            }
          },
          {
            "order_carrier": {
              "intention": {
                "type": {"_eq": "2"}
              }
            }
          },
          {
            "order_carrier": {
              "status": {
                "_in": [9, 10]
              }
            }
          }
        ]
      },
      "sort": "-date_created",
    };
    await DioManager().getList<WayBillModel>(API.execution,
        params: evaluateParams, onSuccess: (list) {
      wayBillEvaluatelist = [];
      if (list.isNotEmpty) {
        for (var item in list) {
          wayBillEvaluatelist.add(item);
        }
      }
      notifyListeners();
      EasyLoading.dismiss();
      return;
    }, onError: (error) {
      notifyListeners();
      EasyLoading.dismiss();
      return;
    });
  }

  Future refreshWayBillList(BuildContext context) async {
    EasyLoading.show(status: '加载中');
    if (UserInfoModel().driver == null || UserInfoModel().driver == "") {
      await getUserBaseInfo(context);
      if (UserInfoModel().driver == null || UserInfoModel().driver == "") {
        EasyLoading.showError("当前用户尚未填写用户信息，请先到 '我的-我的信息' 中更新个人信息");
        return;
      }
    } else {
      var params = {
        "fields":
            "id,status,attached,order_carrier.id,order_carrier.status,order_carrier.evaluation,order_carrier.score,order_carrier.code,order_carrier.intention.id,order_carrier.intention.order_carrier,order_carrier.intention.order_shipper,order_carrier.intention.demand.remark,order_carrier.intention.demand.pickup_address,order_carrier.intention.demand.receiving_address,order_carrier.intention.demand.pickup_start,order_carrier.intention.demand.pickup_end,order_carrier.intention.demand.receiving_start,order_carrier.intention.demand.receiving_end,order_carrier.intention.demand.price,order_carrier.intention.demand.receiving_tel,order_carrier.intention.demand.receiving_name,order_carrier.intention.demand.shipper.id,order_carrier.intention.demand.shipper.company_name,order_carrier.intention.demand.shipper.company_code,order_carrier.intention.demand.shipper.contact_name,order_carrier.intention.demand.shipper.contact_tel,order_carrier.intention.demand.shipper.contact_phone,order_carrier.intention.demand.shipper.attached,order_carrier.intention.demand.goods_type.name,order_carrier.intention.demand.pickup_city.name,order_carrier.intention.demand.pickup_province.name,order_carrier.intention.demand.pickup_area.name,order_carrier.intention.demand.transport_mode.name,order_carrier.intention.demand.receiving_province.name,order_carrier.intention.demand.receiving_city.name,order_carrier.intention.demand.receiving_area.name,order_carrier.intention.demand.goods.name,order_carrier.intention.demand.goods.count,order_carrier.intention.demand.goods.volume,order_carrier.intention.demand.goods.weight,order_carrier.intention.demand.goods.classification.name,order_carrier.intention.demand.total_weight,order_carrier.intention.demand.total_volume,order_carrier.intention.demand.total_count,order_carrier.intention.demand.transport_mode.name,driver.name,transportation.license_plate_number",
        "filter": {
          "del": {"_eq": 0},
          "driver": {"_eq": UserInfoModel().driver},
          "status": {
            "_in": [2, 3, 4, 5, 6, 9, 10]
          }
        },
        "sort": "-date_created",
      };
      await DioManager().getList<WayBillModel>(API.execution, params: params,
          onSuccess: (list) {
        wayBillWaitingAcceptlist = [];
        wayBillWaitingPickedUplist = [];
        wayBillWaitingServicelist = [];
        wayBillConfirmationReceiptlist = [];
        // wayBillEvaluatelist = [];
        if (list.isNotEmpty) {
          for (var item in list) {
            switch (item.status) {
              case "2":
                wayBillWaitingAcceptlist.add(item);
                break;
              case "3":
                wayBillWaitingPickedUplist.add(item);
                break;
              case "4":
                wayBillWaitingServicelist.add(item);
                break;
              case "5":
              case "6":
                wayBillConfirmationReceiptlist.add(item);
                break;
              default:
            }
            // if (item.orderCarrier.status != null ||
            //     item.orderCarrier.status != "") {
            //   if (item.orderCarrier.status == "9" ||
            //       item.orderCarrier.status == "10") {
            //     wayBillEvaluatelist.add(item);
            //   }
            // }
          }
        }
      }, onError: (error) {
        notifyListeners();
        EasyLoading.dismiss();
        FlushBarWidget.createDanger("获取运单信息失败", context);
        return;
      });
      var evaluateParams = {
        "fields":
            "id,status,attached,order_carrier.id,order_carrier.status,order_carrier.evaluation,order_carrier.score,order_carrier.code,order_carrier.intention.id,order_carrier.intention.order_carrier,order_carrier.intention.order_shipper,order_carrier.intention.demand.remark,order_carrier.intention.demand.pickup_address,order_carrier.intention.demand.receiving_address,order_carrier.intention.demand.pickup_start,order_carrier.intention.demand.pickup_end,order_carrier.intention.demand.receiving_start,order_carrier.intention.demand.receiving_end,order_carrier.intention.demand.price,order_carrier.intention.demand.receiving_tel,order_carrier.intention.demand.receiving_name,order_carrier.intention.demand.shipper.id,order_carrier.intention.demand.shipper.company_name,order_carrier.intention.demand.shipper.company_code,order_carrier.intention.demand.shipper.contact_name,order_carrier.intention.demand.shipper.contact_tel,order_carrier.intention.demand.shipper.contact_phone,order_carrier.intention.demand.shipper.attached,order_carrier.intention.demand.goods_type.name,order_carrier.intention.demand.pickup_city.name,order_carrier.intention.demand.pickup_province.name,order_carrier.intention.demand.pickup_area.name,order_carrier.intention.demand.transport_mode.name,order_carrier.intention.demand.receiving_province.name,order_carrier.intention.demand.receiving_city.name,order_carrier.intention.demand.receiving_area.name,order_carrier.intention.demand.goods.name,order_carrier.intention.demand.goods.count,order_carrier.intention.demand.goods.volume,order_carrier.intention.demand.goods.weight,order_carrier.intention.demand.goods.classification.name,order_carrier.intention.demand.total_weight,order_carrier.intention.demand.total_volume,order_carrier.intention.demand.total_count,order_carrier.intention.demand.transport_mode.name,driver.name,transportation.license_plate_number",
        "filter": {
          "_and": [
            {
              "del": {"_eq": "0"}
            },
            {
              "order_carrier": {
                "intention": {
                  "driver": {"_eq": UserInfoModel().driver}
                }
              }
            },
            {
              "order_carrier": {
                "intention": {
                  "type": {"_eq": "2"}
                }
              }
            },
            {
              "order_carrier": {
                "status": {
                  "_in": [9, 10]
                }
              }
            }
          ]
        },
        "sort": "-date_created",
      };
      await DioManager().getList<WayBillModel>(API.execution,
          params: evaluateParams, onSuccess: (list) {
        wayBillEvaluatelist = [];
        if (list.isNotEmpty) {
          for (var item in list) {
            wayBillEvaluatelist.add(item);
          }
        }
        notifyListeners();
        EasyLoading.dismiss();
        return;
      }, onError: (error) {
        notifyListeners();
        EasyLoading.dismiss();
        FlushBarWidget.createDanger("获取运单信息失败", context);
        return;
      });
    }
  }

  /// 接受运单
  Future<bool> agreeWayBill(WayBillModel wayBillModel) async {
    EasyLoading.show(status: '加载中');
    // 步骤1 更新运单status -> 3
    if (wayBillModel.id == null) {
      EasyLoading.dismiss();
      return false;
    }
    await DioManager().patch(API.execution + "/" + wayBillModel.id!,
        data: {"status": "3"}, onSuccess: (_) {}, onError: (e) {
      EasyLoading.dismiss();
      return false;
    });

    // 步骤2 更新承运人订单status -> 4
    if (wayBillModel.orderCarrier.intention.orderCarrier.isEmpty) {
      EasyLoading.dismiss();
      return false;
    }
    await DioManager().patch(
        API.order_carrier +
            "/" +
            wayBillModel.orderCarrier.intention.orderCarrier.first,
        data: {"status": "4"},
        onSuccess: (_) {}, onError: (e) {
      EasyLoading.dismiss();
      return false;
    });
    // 步骤3 更新托运人订单status -> 4
    if (wayBillModel.orderCarrier.intention.orderShipper.isEmpty) {
      EasyLoading.dismiss();
      return false;
    }
    await DioManager().patch(
        API.order_shipper +
            "/" +
            wayBillModel.orderCarrier.intention.orderShipper.first,
        data: {"status": "4"},
        onSuccess: (_) {}, onError: (e) {
      EasyLoading.dismiss();
      return false;
    });
    EasyLoading.dismiss();
    return true;
  }

  /// 拒绝运单
  Future<bool> refusalWayBill(WayBillModel wayBillModel) async {
    EasyLoading.show(status: '加载中');
    // 步骤1 更新运单status -> 7
    if (wayBillModel.id == null) {
      EasyLoading.dismiss();
      return false;
    }
    await DioManager().patch(API.execution + "/" + wayBillModel.id!,
        data: {"status": "7"}, onSuccess: (_) {}, onError: (e) {
      EasyLoading.dismiss();
      return false;
    });

    // 步骤2 更新承运人订单status -> 3
    if (wayBillModel.orderCarrier.intention.orderCarrier.isEmpty) {
      EasyLoading.dismiss();
      return false;
    }
    await DioManager().patch(
        API.order_carrier +
            "/" +
            wayBillModel.orderCarrier.intention.orderCarrier.first,
        data: {"status": "3"},
        onSuccess: (_) {}, onError: (e) {
      EasyLoading.dismiss();
      return false;
    });
    // 步骤3 更新托运人订单status -> 3
    if (wayBillModel.orderCarrier.intention.orderShipper.isEmpty) {
      EasyLoading.dismiss();
      return false;
    }
    await DioManager().patch(
        API.order_shipper +
            "/" +
            wayBillModel.orderCarrier.intention.orderShipper.first,
        data: {"status": "3"},
        onSuccess: (_) {}, onError: (e) {
      EasyLoading.dismiss();
      return false;
    });
    EasyLoading.dismiss();
    return true;
  }

  /// 上传配载单
  Future<bool> saveWayBillLoadingImages(
    WayBillModel wayBillModel,
    List<String> newLoadingImages,
  ) async {
    EasyLoading.show(status: '加载中');

    if (wayBillModel.id == null) {
      EasyLoading.dismiss();
      return false;
    }

    /// 更新 订单execution status -> 4
    /// 将新的loadingImages 更新 将原来的Receipt带入

    var params = {};
    if (wayBillModel.status == "3") {
      params = {
        "status": "4",
        "attached": {
          "loading": newLoadingImages,
          "receipt": wayBillModel.attached.receipt
        }
      };
    } else {
      params = {
        "attached": {
          "loading": newLoadingImages,
          "receipt": wayBillModel.attached.receipt
        }
      };
    }
    await DioManager().patch(API.execution + "/" + wayBillModel.id!,
        data: params, onSuccess: (_) {}, onError: (e) {
      EasyLoading.dismiss();
      return false;
    });
    EasyLoading.dismiss();
    return true;
  }

  /// 上传回单
  Future<bool> saveWayBillReceiptImages(
    WayBillModel wayBillModel,
    List<String> newReceiptImages,
  ) async {
    EasyLoading.show(status: '加载中');

    if (wayBillModel.id == null) {
      EasyLoading.dismiss();
      return false;
    }

    /// 更新 订单execution status -> 5
    /// 将新的loadingImages 更新 将原来的Receipt带入
    var params = {};
    if (wayBillModel.status == "4") {
      params = params = {
        "status": "5",
        "attached": {
          "loading": wayBillModel.attached.loading,
          "receipt": newReceiptImages
        }
      };
    } else {
      params = {
        "attached": {
          "loading": wayBillModel.attached.loading,
          "receipt": newReceiptImages
        }
      };
    }
    await DioManager().patch(API.execution + "/" + wayBillModel.id!,
        data: params, onSuccess: (_) {}, onError: (e) {
      EasyLoading.dismiss();
      return false;
    });
    EasyLoading.dismiss();
    return true;
  }

  /// 评价
  Future<bool> confirmEvaluate(
    WayBillModel wayBillModel,
    double goodsRating,
    double demandRating,
    double loadingRating,
    String remark,
  ) async {
    EasyLoading.show(status: '加载中');
    // 步骤1 更新运单 order_carrier status -> 10
    // 步骤2 更新分数为平均分，
    // 步骤3 更新评价信息，
    if (wayBillModel.orderCarrier.id == null) {
      EasyLoading.dismiss();
      return false;
    }
    var goodsRatingStr = StringUtil.formatNum(goodsRating, 1);
    var demandRatingStr = StringUtil.formatNum(demandRating, 1);
    var loadingRatingStr = StringUtil.formatNum(loadingRating, 1);
    var avarageScoreStr = StringUtil.formatNum(
        ((goodsRating + demandRating + loadingRating) / 3), 1);
    print(avarageScoreStr);
    var data = {
      "status": "10",
      "score": avarageScoreStr,
      "evaluation": {
        "goods": goodsRatingStr,
        "demand": demandRatingStr,
        "remark": remark,
        "loading": loadingRatingStr
      }
    };
    await DioManager().patch(
        API.order_carrier + "/" + wayBillModel.orderCarrier.id!,
        data: data,
        onSuccess: (_) {}, onError: (e) {
      EasyLoading.dismiss();
      return false;
    });
    // 步骤4 上传了评价以后，拿到该公司的所有评价分数总和，做平均值 更新最新评分
    if (wayBillModel.orderCarrier.intention.demand.shipper.id == "" ||
        wayBillModel.orderCarrier.intention.demand.shipper.id == null) {
      EasyLoading.dismiss();
      return false;
    }
    var listParas = {
      "filter": {
        "del": {"_eq": 0},
        "intention": {
          "demand": {
            "shipper": {
              "_eq": wayBillModel.orderCarrier.intention.demand.shipper.id
            }
          }
        },
        "status": {"_eq": 10},
        "score": {"_nnull": "true"}
      },
      "fields": "score",
    };

    List<double> shipperTotalScore = [];
    await DioManager().getList<ScoreModel>(API.order_carrier, params: listParas,
        onSuccess: (list) {
      if (list.isNotEmpty) {
        for (var item in list) {
          var v = double.parse(item.score!);
          if (v is double) {
            shipperTotalScore.add(v);
          }
        }
      }
    }, onError: (error) {
      EasyLoading.dismiss();
      return false;
    });

    var totalShipeperFinalScore = 0.0;
    if (shipperTotalScore.isNotEmpty) {
      for (var item in shipperTotalScore) {
        totalShipeperFinalScore += item;
      }
      totalShipeperFinalScore /= shipperTotalScore.length;
    }
    String newFinalScore = StringUtil.formatNum(totalShipeperFinalScore, 1);
    print(newFinalScore);

    await DioManager().patch(
        API.searchCarFleets +
            "/" +
            wayBillModel.orderCarrier.intention.demand.shipper.id!,
        data: {"score": newFinalScore},
        onSuccess: (_) {}, onError: (e) {
      EasyLoading.dismiss();
      return false;
    });
    EasyLoading.dismiss();
    return true;
  }
}
