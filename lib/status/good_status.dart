import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:ttm/common/ttm_colors.dart';
import 'package:ttm/model/goods_models/all_goods_model.dart';
import 'package:ttm/model/goods_models/contract_model.dart';
import 'package:ttm/model/goods_models/good_bid_car_model.dart';
import 'package:ttm/model/intention_models/all_intention_model.dart';
import 'package:ttm/model/profile_models/user_info_model.dart';
import 'package:ttm/network/api.dart';
import 'package:ttm/network/dio_manager.dart';
import 'package:ttm/status/main_status_model.dart';
import 'package:ttm/status/user_status.dart';
import 'package:ttm/widgets/flush_bar.dart';

class GoodStatus extends BaseStatus with UserStatus {
  initGoodFilterData() {
    goodsTypeAllStatusData = goodsTypeCurrentDisplayData;
    goodsOriganFilterItems = goodsTypeAllStatusData
        .map((type) => MultiSelectItem<FilterType>(type, type.labelName))
        .toList();

    intentionTypeAllStatusData = intentionTypeCurrentDisplayData;
    intentionOriganFilterItems = intentionTypeAllStatusData
        .map((type) => MultiSelectItem<FilterType>(type, type.labelName))
        .toList();
  }

  Future getContractInfo() async {
    EasyLoading.show(status: '加载中');
    var params = {
      "fields": "company_name,contact_name,contact_address,contact_tel",
      "filter": {
        "del": {"_eq": 0},
        "company_name": {"_eq": "畅途慧通物流科技（辽宁）有限公司"},
        "type": {"_eq": 3}
      }
    };
    await DioManager().getList<ContractInfoModel>(API.searchCarFleets,
        params: params, onSuccess: (list) {
      if (list.isNotEmpty) {
        contractInfoModel = list.first;
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

  Future refreshAllGoods(BuildContext context) async {
    EasyLoading.show(status: '加载中');
    if (UserInfoModel().driver == null || UserInfoModel().driver == "") {
      await getUserBaseInfo(context).then((isSuccess) async {
        if (isSuccess) {
          if (UserInfoModel().driver == null || UserInfoModel().driver == "") {
            EasyLoading.showError("当前用户尚未填写用户信息，请先到 '我的-我的信息' 中更新个人信息");
            return;
          } else {
            if (goodsListFilterTypes.isNotEmpty) {
              Map<String, dynamic> params = {};
              if (goodsFilterDateStart != "" && goodsFilterDateEnd != "") {
                params = {
                  "fields":
                      "id,code,remark,status,pickup_address,pickup_start,pickup_end,receiving_start,receiving_end,price,receiving_tel,receiving_name,receiving_address,shipper.score,shipper.company_name,shipper.company_code,shipper.contact_name,shipper.contact_tel,shipper.contact_phone,shipper.company_address,goods_type.name,pickup_city.name,pickup_province.name,pickup_area.name,transport_mode.name,receiving_province.name,receiving_city.name,receiving_area.name,goods.name,goods.count,goods.volume,goods.weight,goods.classification.name,total_weight,total_volume,total_count,transport_mode.name,carrier.company_name,carrier.contact_name,carrier.contact_phone,carrier.company_address,carrier.company_code,carrier.contact_tel,carrier.id",
                  "filter": {
                    "del": {"_eq": 0},
                    "status": {"_in": goodsListFilterTypes},
                    "date_created": {
                      "_between": [goodsFilterDateStart, goodsFilterDateEnd]
                    }
                  },
                  "sort": "-date_created",
                };
              } else {
                params = {
                  "fields":
                      "id,code,remark,status,pickup_address,pickup_start,pickup_end,receiving_start,receiving_end,price,receiving_tel,receiving_name,receiving_address,shipper.score,shipper.company_name,shipper.company_code,shipper.contact_name,shipper.contact_tel,shipper.contact_phone,shipper.company_address,goods_type.name,pickup_city.name,pickup_province.name,pickup_area.name,transport_mode.name,receiving_province.name,receiving_city.name,receiving_area.name,goods.name,goods.count,goods.volume,goods.weight,goods.classification.name,total_weight,total_volume,total_count,transport_mode.name,carrier.company_name,carrier.contact_name,carrier.contact_phone,carrier.company_address,carrier.company_code,carrier.contact_tel,carrier.id",
                  "filter": {
                    "del": {"_eq": 0},
                    "status": {"_in": goodsListFilterTypes}
                  },
                  "sort": "-date_created",
                };
              }

              await DioManager().getList<GoodModel>(API.goods, params: params,
                  onSuccess: (list) {
                currentGoodsList = list;
                isCurrentGoodsExpanded =
                    currentGoodsList.map((e) => false).toList();
              }, onError: (error) {
                notifyListeners();
                EasyLoading.dismiss();
                FlushBarWidget.createDanger("获取货源失败", context);
                return;
              });
              notifyListeners();
              EasyLoading.dismiss();
              return;
            } else {
              notifyListeners();
              EasyLoading.dismiss();
              FlushBarWidget.createDanger("货源状态不能为空", context);
              return;
            }
          }
        } else {
          EasyLoading.dismiss();
          return;
        }
      });
    } else {
      if (goodsListFilterTypes.isNotEmpty) {
        Map<String, dynamic> params = {};
        if (goodsFilterDateStart != "" && goodsFilterDateEnd != "") {
          params = {
            "fields":
                "id,code,remark,status,pickup_address,pickup_start,pickup_end,receiving_start,receiving_end,price,receiving_tel,receiving_name,receiving_address,shipper.score,shipper.company_name,shipper.company_code,shipper.contact_name,shipper.contact_tel,shipper.contact_phone,shipper.company_address,goods_type.name,pickup_city.name,pickup_province.name,pickup_area.name,transport_mode.name,receiving_province.name,receiving_city.name,receiving_area.name,goods.name,goods.count,goods.volume,goods.weight,goods.classification.name,total_weight,total_volume,total_count,transport_mode.name,carrier.company_name,carrier.contact_name,carrier.contact_phone,carrier.company_address,carrier.company_code,carrier.contact_tel,carrier.id",
            "filter": {
              "del": {"_eq": 0},
              "status": {"_in": goodsListFilterTypes},
              "date_created": {
                "_between": [goodsFilterDateStart, goodsFilterDateEnd]
              }
            },
            "sort": "-date_created",
          };
        } else {
          params = {
            "fields":
                "id,code,remark,status,pickup_address,pickup_start,pickup_end,receiving_start,receiving_end,price,receiving_tel,receiving_name,receiving_address,shipper.score,shipper.company_name,shipper.company_code,shipper.contact_name,shipper.contact_tel,shipper.contact_phone,shipper.company_address,goods_type.name,pickup_city.name,pickup_province.name,pickup_area.name,transport_mode.name,receiving_province.name,receiving_city.name,receiving_area.name,goods.name,goods.count,goods.volume,goods.weight,goods.classification.name,total_weight,total_volume,total_count,transport_mode.name,carrier.company_name,carrier.contact_name,carrier.contact_phone,carrier.company_address,carrier.company_code,carrier.contact_tel,carrier.id",
            "filter": {
              "del": {"_eq": 0},
              "status": {"_in": goodsListFilterTypes}
            },
            "sort": "-date_created",
          };
        }

        await DioManager().getList<GoodModel>(API.goods, params: params,
            onSuccess: (list) {
          currentGoodsList = list;
          isCurrentGoodsExpanded = currentGoodsList.map((e) => false).toList();
        }, onError: (error) {
          notifyListeners();
          EasyLoading.dismiss();
          FlushBarWidget.createDanger("获取货源失败", context);
          return;
        });
        notifyListeners();
        EasyLoading.dismiss();
        return;
      } else {
        notifyListeners();
        EasyLoading.dismiss();
        FlushBarWidget.createDanger("货源状态不能为空", context);
        return;
      }
    }
  }

  Future choseGoodsFilterType(
    BuildContext context,
  ) async {
    await showModalBottomSheet(
      isScrollControlled: true, // required for min/max child size
      context: context,
      builder: (ctx) {
        return MultiSelectBottomSheet<FilterType>(
          items: goodsOriganFilterItems,
          initialValue: goodsTypeCurrentDisplayData,
          listType: MultiSelectListType.CHIP,
          selectedColor: TTMColors.mainBlue,
          title: const Padding(
            padding: EdgeInsets.only(left: 15.0, top: 10),
            child: Text(
              "请选择货源状态",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: TTMColors.titleColor),
            ),
          ),
          cancelText: const Text("取消"),
          confirmText: const Text("确认"),
          selectedItemsTextStyle:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          onConfirm: (values) {
            if (values.isEmpty) {
              goodsTypeCurrentDisplayData = goodsTypeAllStatusData;
              goodsListFilterTypes =
                  goodsTypeAllStatusData.map((e) => e.id).toList();
              notifyListeners();
            } else {
              goodsListFilterTypes = values.map((e) => e.id).toList();
              goodsTypeCurrentDisplayData = values;
              notifyListeners();
            }
          },
          maxChildSize: 1,
        );
      },
    );
  }

  Future choseGoodsFilterDate(
      BuildContext context, Function(bool isSuccess) onFinish) async {
    var result = await showDateRangePicker(
        locale: const Locale('zh'),
        context: context,
        firstDate: DateTime(1900),
        lastDate: DateTime(3000),
        confirmText: "确认",
        saveText: "确认",
        builder: (context, Widget? child) => Theme(
              data: ThemeData(
                  appBarTheme: const AppBarTheme(
                      backgroundColor: TTMColors.mainBlue,
                      iconTheme: IconThemeData(color: Colors.white)),
                  colorScheme: const ColorScheme.light(
                      onPrimary: Colors.white, primary: TTMColors.dangerColor)),
              child: child!,
            ));

    if (result != null) {
      goodsFilterDateStart =
          "${result.start.year}-${result.start.month}-${result.start.day}";
      goodsFilterDateEnd =
          "${result.end.year}-${result.end.month}-${result.end.day}";
      notifyListeners();
      onFinish(true);
    } else {
      onFinish(false);
    }
  }

  void clearGoodsFilterDate() {
    goodsFilterDateStart = "";
    goodsFilterDateEnd = "";
  }

  Future refreshAllIntention(BuildContext context) async {
    EasyLoading.show(status: '加载中');
    if (UserInfoModel().driver == null || UserInfoModel().driver == "") {
      await getUserBaseInfo(context).then((isSuccess) async {
        if (isSuccess) {
          if (UserInfoModel().driver == null || UserInfoModel().driver == "") {
            EasyLoading.showError("当前用户尚未填写用户信息，请先到 '我的-我的信息' 中更新个人信息");
            return;
          } else {
            if (intentionListFilterTypes.isNotEmpty) {
              Map<String, dynamic> params = {};
              if (intentionFilterDateStart != "" &&
                  intentionFilterDateEnd != "") {
                params = {
                  "fields":
                      "id,code,status,demand.id,demand.remark,demand.pickup_address,demand.pickup_start,demand.pickup_end,demand.receiving_start,demand.receiving_end,demand.price,demand.receiving_tel,demand.receiving_name,demand.shipper.company_name,demand.shipper.company_address,demand.shipper.company_code,demand.shipper.contact_name,demand.shipper.contact_tel,demand.shipper.contact_phone,demand.goods_type.name,demand.pickup_city.name,demand.pickup_province.name,demand.pickup_area.name,demand.transport_mode.name,demand.receiving_province.name,demand.receiving_city.name,demand.receiving_area.name,demand.receiving_address,demand.shipper.score,demand.goods.name,demand.goods.count,demand.goods.volume,demand.goods.weight,demand.goods.classification.name,demand.total_weight,demand.total_volume,demand.total_count,demand.transport_mode.name,carrier.company_name,carrier.contact_name,carrier.contact_phone,carrier.company_address,carrier.company_code,carrier.contact_tel,driver.name,transportation.license_plate_number",
                  "filter": {
                    "del": {"_eq": 0},
                    "status": {"_in": intentionListFilterTypes},
                    "date_created": {
                      "_between": [
                        intentionFilterDateStart,
                        intentionFilterDateEnd
                      ]
                    },
                    "driver": {"_eq": UserInfoModel().driver},
                    "type": {"_eq": "2"}
                  },
                  "sort": "-date_created",
                };
              } else {
                params = {
                  "fields":
                      "id,code,status,demand.id,demand.remark,demand.pickup_address,demand.pickup_start,demand.pickup_end,demand.receiving_start,demand.receiving_end,demand.price,demand.receiving_tel,demand.receiving_name,demand.shipper.company_name,demand.shipper.company_address,demand.shipper.company_code,demand.shipper.contact_name,demand.shipper.contact_tel,demand.shipper.contact_phone,demand.goods_type.name,demand.pickup_city.name,demand.pickup_province.name,demand.pickup_area.name,demand.transport_mode.name,demand.receiving_province.name,demand.receiving_city.name,demand.receiving_area.name,demand.receiving_address,demand.shipper.score,demand.goods.name,demand.goods.count,demand.goods.volume,demand.goods.weight,demand.goods.classification.name,demand.total_weight,demand.total_volume,demand.total_count,demand.transport_mode.name,carrier.company_name,carrier.contact_name,carrier.contact_phone,carrier.company_address,carrier.company_code,carrier.contact_tel,driver.name,transportation.license_plate_number",
                  "filter": {
                    "del": {"_eq": 0},
                    "driver": {"_eq": UserInfoModel().driver},
                    "type": {"_eq": "2"},
                    "status": {"_in": intentionListFilterTypes}
                  },
                  "sort": "-date_created",
                };
              }

              await DioManager().getList<IntentionModel>(API.intention,
                  params: params, onSuccess: (list) {
                currentIntentionsList = list;
                isCurrentIntentionExpanded =
                    currentIntentionsList.map((e) => false).toList();
                notifyListeners();
                EasyLoading.dismiss();
                return;
              }, onError: (error) {
                notifyListeners();
                EasyLoading.dismiss();
                FlushBarWidget.createDanger("获取意向失败", context);
                return;
              });
            } else {
              notifyListeners();
              EasyLoading.dismiss();
              FlushBarWidget.createDanger("意向状态不能为空", context);
              return;
            }
          }
        } else {
          EasyLoading.dismiss();
          return;
        }
      });
    } else {
      if (intentionListFilterTypes.isNotEmpty) {
        Map<String, dynamic> params = {};
        if (intentionFilterDateStart != "" && intentionFilterDateEnd != "") {
          params = {
            "fields":
                "id,code,status,demand.id,demand.remark,demand.pickup_address,demand.pickup_start,demand.pickup_end,demand.receiving_start,demand.receiving_end,demand.price,demand.receiving_tel,demand.receiving_name,demand.shipper.company_name,demand.shipper.company_address,demand.shipper.company_code,demand.shipper.contact_name,demand.shipper.contact_tel,demand.shipper.contact_phone,demand.goods_type.name,demand.pickup_city.name,demand.pickup_province.name,demand.pickup_area.name,demand.transport_mode.name,demand.receiving_province.name,demand.receiving_city.name,demand.receiving_area.name,demand.receiving_address,demand.shipper.score,demand.goods.name,demand.goods.count,demand.goods.volume,demand.goods.weight,demand.goods.classification.name,demand.total_weight,demand.total_volume,demand.total_count,demand.transport_mode.name,carrier.company_name,carrier.contact_name,carrier.contact_phone,carrier.company_address,carrier.company_code,carrier.contact_tel,driver.name,transportation.license_plate_number",
            "filter": {
              "del": {"_eq": 0},
              "status": {"_in": intentionListFilterTypes},
              "date_created": {
                "_between": [intentionFilterDateStart, intentionFilterDateEnd]
              },
              "driver": {"_eq": UserInfoModel().driver},
              "type": {"_eq": "2"}
            },
            "sort": "-date_created",
          };
        } else {
          params = {
            "fields":
                "id,code,status,demand.id,demand.remark,demand.pickup_address,demand.pickup_start,demand.pickup_end,demand.receiving_start,demand.receiving_end,demand.price,demand.receiving_tel,demand.receiving_name,demand.shipper.company_name,demand.shipper.company_address,demand.shipper.company_code,demand.shipper.contact_name,demand.shipper.contact_tel,demand.shipper.contact_phone,demand.goods_type.name,demand.pickup_city.name,demand.pickup_province.name,demand.pickup_area.name,demand.transport_mode.name,demand.receiving_province.name,demand.receiving_city.name,demand.receiving_area.name,demand.receiving_address,demand.shipper.score,demand.goods.name,demand.goods.count,demand.goods.volume,demand.goods.weight,demand.goods.classification.name,demand.total_weight,demand.total_volume,demand.total_count,demand.transport_mode.name,carrier.company_name,carrier.contact_name,carrier.contact_phone,carrier.company_address,carrier.company_code,carrier.contact_tel,driver.name,transportation.license_plate_number",
            "filter": {
              "del": {"_eq": 0},
              "driver": {"_eq": UserInfoModel().driver},
              "type": {"_eq": "2"},
              "status": {"_in": intentionListFilterTypes}
            },
            "sort": "-date_created",
          };
        }

        await DioManager().getList<IntentionModel>(API.intention,
            params: params, onSuccess: (list) {
          currentIntentionsList = list;
          isCurrentIntentionExpanded =
              currentIntentionsList.map((e) => false).toList();
          notifyListeners();
          EasyLoading.dismiss();
          return;
        }, onError: (error) {
          notifyListeners();
          EasyLoading.dismiss();
          FlushBarWidget.createDanger("获取意向失败", context);
          return;
        });
      } else {
        notifyListeners();
        EasyLoading.dismiss();
        FlushBarWidget.createDanger("意向状态不能为空", context);
        return;
      }
    }
  }

  Future choseIntentionFilterType(
    BuildContext context,
  ) async {
    await showModalBottomSheet(
      isScrollControlled: true, // required for min/max child size
      context: context,
      builder: (ctx) {
        return MultiSelectBottomSheet<FilterType>(
          items: intentionOriganFilterItems,
          initialValue: intentionTypeCurrentDisplayData,
          listType: MultiSelectListType.CHIP,
          selectedColor: TTMColors.mainBlue,
          title: const Padding(
            padding: EdgeInsets.only(left: 15.0, top: 10),
            child: Text(
              "请选择意向状态",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: TTMColors.titleColor),
            ),
          ),
          cancelText: const Text("取消"),
          confirmText: const Text("确认"),
          selectedItemsTextStyle:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          onConfirm: (values) {
            if (values.isEmpty) {
              intentionTypeCurrentDisplayData = intentionTypeAllStatusData;
              intentionListFilterTypes =
                  intentionTypeAllStatusData.map((e) => e.id).toList();
              notifyListeners();
            } else {
              intentionListFilterTypes = values.map((e) => e.id).toList();
              intentionTypeCurrentDisplayData = values;
              notifyListeners();
            }
          },
          maxChildSize: 1,
        );
      },
    );
  }

  Future choseIntentionFilterDate(
      BuildContext context, Function(bool isSuccess) onFinish) async {
    var result = await showDateRangePicker(
        locale: const Locale('zh'),
        context: context,
        firstDate: DateTime(1900),
        lastDate: DateTime(3000),
        confirmText: "确认",
        saveText: "确认",
        builder: (context, Widget? child) => Theme(
              data: ThemeData(
                  appBarTheme: const AppBarTheme(
                      backgroundColor: TTMColors.mainBlue,
                      iconTheme: IconThemeData(color: Colors.white)),
                  colorScheme: const ColorScheme.light(
                      onPrimary: Colors.white, primary: TTMColors.dangerColor)),
              child: child!,
            ));

    if (result != null) {
      intentionFilterDateStart =
          "${result.start.year}-${result.start.month}-${result.start.day}";
      intentionFilterDateEnd =
          "${result.end.year}-${result.end.month}-${result.end.day}";
      notifyListeners();
      onFinish(true);
    } else {
      onFinish(false);
    }
  }

  void clearIntentionFilterDate() {
    intentionFilterDateStart = "";
    intentionFilterDateEnd = "";
  }

  Future<List<GoodBidCar>> getAllGoodBidCarsList(BuildContext context) async {
    List<GoodBidCar> allCars = [];
    EasyLoading.show(status: '加载中');
    // GoodBidCar
    await DioManager().getList<GoodBidCar>(API.getCarInfo, params: {
      "filter": {
        "del": {"_eq": 0},
        "driver": {
          "driver_id": {"_eq": UserInfoModel().driver}
        },
        "status": {"_eq": "2"}
      },
      "fields": "license_plate_number,id,load.name",
      "sort": "-date_created",
    }, onSuccess: (list) {
      allCars = list;
      EasyLoading.dismiss();
    }, onError: (_) {
      EasyLoading.dismiss();
      FlushBarWidget.createDanger("获取抢单车辆信息失败", context);
    });
    return allCars;
  }

  // 抢单
  Future<bool> goodBidRequest(
      BuildContext context, String goodID, String carID) async {
    EasyLoading.show(status: '加载中');
    // 步骤1 从更改货源状态 为 7（托运人待确认）
    await DioManager().patch(API.goods + "/" + goodID,
        data: {"status": "7"}, onSuccess: (_) {}, onError: (e) {
      EasyLoading.dismiss();
      return false;
    });
    var year = DateTime.now().year;
    var month = DateTime.now().month.toString().padLeft(2, "0");
    var day = DateTime.now().day.toString().padLeft(2, "0");
    var hour = DateTime.now().hour.toString().padLeft(2, "0");
    var minute = DateTime.now().minute.toString().padLeft(2, "0");
    var second = DateTime.now().second.toString().padLeft(2, "0");
    // 步骤2 穿建意向
    await DioManager().post(API.intention, data: {
      "code": "intention-$year-$month-$day $hour:$minute:$second",
      "status": "7",
      // "carrier": carrierID,
      "demand": goodID,
      "type": "2",
      "driver": UserInfoModel().driver,
      "transportation": carID,
    }, onSuccess: (_) async {
      // 成功 刷新列表状态

      // onSuccess();
      // await refreshAllGoods(context);
      // await refreshAllIntention(context);
      // return;
    }, onError: (_) async {
      EasyLoading.dismiss();
      return false;
    });

    EasyLoading.dismiss();
    return true;
  }

  // 拒绝意向
  Future<bool> refusalIntentionAction(BuildContext context, String intentionID,
      String reason, String demandID) async {
    EasyLoading.show(status: '加载中');
    // 步骤一 更新意向表
    await DioManager().patch(API.intention + "/" + intentionID,
        data: {"status": "4", "refuse_reason": reason},
        onSuccess: (_) {}, onError: (_) {
      EasyLoading.dismiss();
      return false;
    });

    await DioManager().patch(API.goods + "/" + demandID,
        data: {"status": "4"}, onSuccess: (_) {}, onError: (_) async {
      EasyLoading.dismiss();
      return false;
    });
    // 成功 刷新列表状态
    EasyLoading.dismiss();
    return true;
  }

  // 拒绝意向
  Future<bool> agreeIntentionAction(BuildContext context, String intentionID,
      String reason, String demandID) async {
    EasyLoading.show(status: '加载中');
    // 步骤一 更新意向表
    await DioManager().patch(API.intention + "/" + intentionID,
        data: {"status": "3", "refuse_reason": reason},
        onSuccess: (_) async {}, onError: (_) {
      EasyLoading.dismiss();
      return false;
    });

    await DioManager().patch(API.goods + "/" + demandID,
        data: {"status": "3"}, onSuccess: (_) async {}, onError: (_) async {
      EasyLoading.dismiss();
      return false;
    });
    EasyLoading.dismiss();
    return true;
  }
}

class FilterType {
  final int id;
  final String labelName;

  FilterType({required this.id, required this.labelName});
}
