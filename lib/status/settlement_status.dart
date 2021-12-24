import 'package:ttm/model/settlement_models/invoice_model.dart';
import 'package:ttm/model/settlement_models/receivable_model.dart';
import 'package:ttm/status/main_status_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:ttm/common/ttm_colors.dart';
import 'package:ttm/model/profile_models/user_info_model.dart';
import 'package:ttm/network/api.dart';
import 'package:ttm/network/dio_manager.dart';
import 'package:ttm/status/user_status.dart';
import 'package:ttm/utils/date_util.dart';
import 'package:ttm/widgets/flush_bar.dart';

import 'good_status.dart';

class SettlementStatus extends BaseStatus with UserStatus {
  initSettlementFilterData() {
    invoiceTypeAllStatusData = invoiceTypeCurrentDisplayData;
    invoiceOriganFilterItems = invoiceTypeAllStatusData
        .map((type) => MultiSelectItem<FilterType>(type, type.labelName))
        .toList();

    receivableTypeAllStatusData = receivableTypeCurrentDisplayData;
    receivableOriganFilterItems = receivableTypeAllStatusData
        .map((type) => MultiSelectItem<FilterType>(type, type.labelName))
        .toList();
  }

  /// --------- 发票相关 ------------
  Future initInvoiceList() async {
    EasyLoading.show(status: "加载中");
    await Future.delayed(Duration(seconds: 2));
    if (invoiceListFilterTypes.isNotEmpty) {
      Map<String, dynamic> params = {};
      if (invoiceFilterDateStart != "" && invoiceFilterDateEnd != "") {
        if (invoiceActualCode != "") {
          /// 输入了实际发票号
          /// 选择了发票创建结束日期
          params = {
            "fields":
                "id,status,amount,actual_code,attached,tax,rate,driver.id,driver.name,payer.company_name,date_created,order_carrier.order_carrier_id.intention.demand.price,order_carrier.order_carrier_id.code,order_carrier.order_carrier_id.id",
            "filter": {
              "del": {"_eq": 0},
              "status": {"_in": invoiceListFilterTypes},
              "type": {"_eq": 2},
              "driver": {"_eq": UserInfoModel().driver},
              "actual_code": {"_contains": invoiceActualCode},
              "date_created": {
                "_between": [invoiceFilterDateStart, invoiceFilterDateEnd]
              }
            },
            "sort": "-date_created",
          };
        } else {
          /// 未输入实际发票号
          /// 选择了发票创建结束日期
          params = {
            "fields":
                "id,status,amount,actual_code,attached,tax,rate,driver.id,driver.name,payer.company_name,date_created,order_carrier.order_carrier_id.intention.demand.price,order_carrier.order_carrier_id.code,order_carrier.order_carrier_id.id",
            "filter": {
              "del": {"_eq": 0},
              "status": {"_in": invoiceListFilterTypes},
              "type": {"_eq": 2},
              "driver": {"_eq": UserInfoModel().driver},
              "date_created": {
                "_between": [invoiceFilterDateStart, invoiceFilterDateEnd]
              }
            },
            "sort": "-date_created",
          };
        }
      } else {
        if (invoiceActualCode != "") {
          /// 输入了实际发票号
          /// 未选择发票创建结束日期
          params = {
            "fields":
                "id,status,amount,actual_code,attached,tax,rate,driver.id,driver.name,payer.company_name,date_created,order_carrier.order_carrier_id.intention.demand.price,order_carrier.order_carrier_id.code,order_carrier.order_carrier_id.id",
            "filter": {
              "del": {"_eq": 0},
              "status": {"_in": invoiceListFilterTypes},
              "type": {"_eq": 2},
              "driver": {"_eq": UserInfoModel().driver},
              "actual_code": {"_contains": invoiceActualCode},
            },
            "sort": "-date_created",
          };
        } else {
          /// 未输入实际发票号
          /// 未选择发票创建结束日期
          params = {
            "fields":
                "id,status,amount,actual_code,attached,tax,rate,driver.id,driver.name,payer.company_name,date_created,order_carrier.order_carrier_id.intention.demand.price,order_carrier.order_carrier_id.code,order_carrier.order_carrier_id.id",
            "filter": {
              "del": {"_eq": 0},
              "status": {"_in": invoiceListFilterTypes},
              "type": {"_eq": 2},
              "driver": {"_eq": UserInfoModel().driver},
            },
            "sort": "-date_created",
          };
        }
      }
      await DioManager().getList<InvoiceModel>(API.invoice, params: params,
          onSuccess: (list) {
        settlementInvoiceList = list;
        notifyListeners();
        EasyLoading.dismiss();
        return;
      }, onError: (error) {
        notifyListeners();
        EasyLoading.dismiss();
        return;
      });
    } else {
      EasyLoading.dismiss();
      return;
    }
  }

  Future refreshInvoiceList(BuildContext context) async {
    EasyLoading.show(status: '加载中');
    if (UserInfoModel().driver == null || UserInfoModel().driver == "") {
      await getUserBaseInfo(context);
      if (UserInfoModel().driver == null || UserInfoModel().driver == "") {
        EasyLoading.showError("当前用户尚未填写用户信息，请先到 '我的-我的信息' 中更新个人信息");
        return;
      }
    } else {
      if (invoiceListFilterTypes.isNotEmpty) {
        Map<String, dynamic> params = {};
        if (invoiceFilterDateStart != "" && invoiceFilterDateEnd != "") {
          if (invoiceActualCode != "") {
            /// 输入了实际发票号
            /// 选择了发票创建结束日期
            params = {
              "fields":
                  "id,status,amount,actual_code,attached,tax,rate,driver.id,driver.name,payer.company_name,date_created,order_carrier.order_carrier_id.intention.demand.price,order_carrier.order_carrier_id.code,order_carrier.order_carrier_id.id",
              "filter": {
                "del": {"_eq": 0},
                "status": {"_in": invoiceListFilterTypes},
                "type": {"_eq": 2},
                "driver": {"_eq": UserInfoModel().driver},
                "actual_code": {"_contains": invoiceActualCode},
                "date_created": {
                  "_between": [invoiceFilterDateStart, invoiceFilterDateEnd]
                }
              },
              "sort": "-date_created",
            };
          } else {
            /// 未输入实际发票号
            /// 选择了发票创建结束日期
            params = {
              "fields":
                  "id,status,amount,actual_code,attached,tax,rate,driver.id,driver.name,payer.company_name,date_created,order_carrier.order_carrier_id.intention.demand.price,order_carrier.order_carrier_id.code,order_carrier.order_carrier_id.id",
              "filter": {
                "del": {"_eq": 0},
                "status": {"_in": invoiceListFilterTypes},
                "type": {"_eq": 2},
                "driver": {"_eq": UserInfoModel().driver},
                "date_created": {
                  "_between": [invoiceFilterDateStart, invoiceFilterDateEnd]
                }
              },
              "sort": "-date_created",
            };
          }
        } else {
          if (invoiceActualCode != "") {
            /// 输入了实际发票号
            /// 未选择发票创建结束日期
            params = {
              "fields":
                  "id,status,amount,actual_code,attached,tax,rate,driver.id,driver.name,payer.company_name,date_created,order_carrier.order_carrier_id.intention.demand.price,order_carrier.order_carrier_id.code,order_carrier.order_carrier_id.id",
              "filter": {
                "del": {"_eq": 0},
                "status": {"_in": invoiceListFilterTypes},
                "type": {"_eq": 2},
                "driver": {"_eq": UserInfoModel().driver},
                "actual_code": {"_contains": invoiceActualCode},
              },
              "sort": "-date_created",
            };
          } else {
            /// 未输入实际发票号
            /// 未选择发票创建结束日期
            params = {
              "fields":
                  "id,status,amount,actual_code,attached,tax,rate,driver.id,driver.name,payer.company_name,date_created,order_carrier.order_carrier_id.intention.demand.price,order_carrier.order_carrier_id.code,order_carrier.order_carrier_id.id",
              "filter": {
                "del": {"_eq": 0},
                "status": {"_in": invoiceListFilterTypes},
                "type": {"_eq": 2},
                "driver": {"_eq": UserInfoModel().driver},
              },
              "sort": "-date_created",
            };
          }
        }
        await DioManager().getList<InvoiceModel>(API.invoice, params: params,
            onSuccess: (list) {
          settlementInvoiceList = list;
          notifyListeners();
          EasyLoading.dismiss();
          return;
        }, onError: (error) {
          notifyListeners();
          EasyLoading.dismiss();
          FlushBarWidget.createDanger("获取发票信息失败", context);
          return;
        });
      } else {
        EasyLoading.dismiss();
        FlushBarWidget.createDanger("发票状态不能为空", context);
        return;
      }
    }
  }

  Future choseInvoiceFilterType(
    BuildContext context,
  ) async {
    await showModalBottomSheet(
      isScrollControlled: true, // required for min/max child size
      context: context,
      builder: (ctx) {
        return MultiSelectBottomSheet<FilterType>(
          items: invoiceOriganFilterItems,
          initialValue: invoiceTypeCurrentDisplayData,
          listType: MultiSelectListType.CHIP,
          selectedColor: TTMColors.mainBlue,
          title: const Padding(
            padding: EdgeInsets.only(left: 15.0, top: 10),
            child: Text(
              "请选择发票状态",
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
              invoiceTypeCurrentDisplayData = invoiceTypeAllStatusData;
              invoiceListFilterTypes =
                  invoiceTypeAllStatusData.map((e) => e.id).toList();
              notifyListeners();
            } else {
              invoiceListFilterTypes = values.map((e) => e.id).toList();
              invoiceTypeCurrentDisplayData = values;
              notifyListeners();
            }
          },
          maxChildSize: 1,
        );
      },
    );
  }

  Future choseInvoiceFilterDate(
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
      invoiceFilterDateStart =
          "${result.start.year}-${result.start.month}-${result.start.day}";
      invoiceFilterDateEnd =
          "${result.end.year}-${result.end.month}-${result.end.day}";
      notifyListeners();
      onFinish(true);
    } else {
      onFinish(false);
    }
  }

  void clearInvoiceFilterDate() {
    invoiceFilterDateStart = "";
    invoiceFilterDateEnd = "";
  }

  void clearInvoiceSearchCode() {
    invoiceActualCode = "";
  }

  /// 通过发票操作
  Future<bool> agreedInvoice(InvoiceModel invoiceModel) async {
    EasyLoading.show(status: '加载中');

    /// 步骤1 更新 invoice_sell.status = 4 （待结算）
    if (invoiceModel.id == null) {
      EasyLoading.dismiss();
      return false;
    }
    await DioManager().patch(API.invoice + "/" + invoiceModel.id!,
        data: {"status": "4"}, onSuccess: (_) {}, onError: (_) {
      EasyLoading.dismiss();
      return false;
    });

    /// 步骤2 新增payables（应收表）数据
    var newPayablesParams = {
      "code": "payables-${DateUtil.getCurrentDateWithYMDHMSToString()}",
      "status": "1",
      "amount": invoiceModel.amount,
      "type": "2",
      "amount_actually": invoiceModel.amount,
      "invoice_sell": [invoiceModel.id],
      "driver": UserInfoModel().driver
    };
    await DioManager().post(API.receivable,
        data: newPayablesParams, onSuccess: (_) {}, onError: (_) {
      EasyLoading.dismiss();
      return false;
    });

    /// 步骤3 更新order_carrier.status=8
    if (invoiceModel.orderCarrier.isEmpty) {
      EasyLoading.dismiss();
      return true;
    } else {
      for (var item in invoiceModel.orderCarrier) {
        if (item.orderCarrierId.id == null) {
          continue;
        } else {
          await DioManager().patch(
              API.order_carrier + "/" + item.orderCarrierId.id!,
              data: {"status": "8"}, onSuccess: (_) {
            EasyLoading.dismiss();
            return true;
          }, onError: (_) {
            EasyLoading.dismiss();
            return false;
          });
        }
      }
      EasyLoading.dismiss();
      return true;
    }
  }

  /// 拒绝发票操作
  Future<bool> refuseInvoice(InvoiceModel invoiceModel) async {
    /// 步骤1 更新 invoice_sell.status = 6 拒绝
    if (invoiceModel.id == null) {
      EasyLoading.dismiss();
      return false;
    }
    await DioManager().patch(API.invoice + "/" + invoiceModel.id!,
        data: {"status": "6"}, onSuccess: (_) {}, onError: (_) {
      EasyLoading.dismiss();
      return false;
    });
    EasyLoading.dismiss();
    return true;
  }

  /// ------- 应收相关 ---------

  Future initReceivableList() async {
    EasyLoading.show(status: "加载中");
    await Future.delayed(Duration(seconds: 2));
    if (receivableListFilterTypes.isNotEmpty) {
      Map<String, dynamic> params = {};
      if (receivableFilterDateStart != "" && receivableFilterDateEnd != "") {
        if (receivableActualCode != "") {
          /// 输入了实际发票号
          /// 选择了发票创建结束日期
          params = {
            "fields":
                "id,status,amount,serial_number,attached,invoice_sell.actual_code,invoice_sell.id,invoice_sell.amount,invoice_sell.tax,invoice_sell.rate,driver.id,driver.name,invoice_sell.payer.company_name,date_created,invoice_sell.order_carrier.order_carrier_id.intention.demand.price,invoice_sell.order_carrier.order_carrier_id.code,invoice_sell.order_carrier.order_carrier_id.id,type",
            "filter": {
              "del": {"_eq": 0},
              "status": {"_in": receivableListFilterTypes},
              "type": {"_eq": 2},
              "driver": {"_eq": UserInfoModel().driver},
              "serial_number": {"_contains": receivableActualCode},
              "date_created": {
                "_between": [receivableFilterDateStart, receivableFilterDateEnd]
              }
            },
            "sort": "-date_created",
          };
        } else {
          /// 未输入实际发票号
          /// 选择了发票创建结束日期

          params = {
            "fields":
                "id,status,amount,serial_number,attached,invoice_sell.actual_code,invoice_sell.id,invoice_sell.amount,invoice_sell.tax,invoice_sell.rate,driver.id,driver.name,invoice_sell.payer.company_name,date_created,invoice_sell.order_carrier.order_carrier_id.intention.demand.price,invoice_sell.order_carrier.order_carrier_id.code,invoice_sell.order_carrier.order_carrier_id.id,type",
            "filter": {
              "del": {"_eq": 0},
              "status": {"_in": receivableListFilterTypes},
              "type": {"_eq": 2},
              "driver": {"_eq": UserInfoModel().driver},
              "date_created": {
                "_between": [receivableFilterDateStart, receivableFilterDateEnd]
              }
            },
            "sort": "-date_created",
          };
        }
      } else {
        if (receivableActualCode != "") {
          /// 输入了实际发票号
          /// 未选择发票创建结束日期
          params = {
            "fields":
                "id,status,amount,serial_number,attached,invoice_sell.actual_code,invoice_sell.id,invoice_sell.amount,invoice_sell.tax,invoice_sell.rate,driver.id,driver.name,invoice_sell.payer.company_name,date_created,invoice_sell.order_carrier.order_carrier_id.intention.demand.price,invoice_sell.order_carrier.order_carrier_id.code,invoice_sell.order_carrier.order_carrier_id.id,type",
            "filter": {
              "del": {"_eq": 0},
              "status": {"_in": receivableListFilterTypes},
              "type": {"_eq": 2},
              "driver": {"_eq": UserInfoModel().driver},
              "serial_number": {"_contains": receivableActualCode},
            },
            "sort": "-date_created",
          };
        } else {
          /// 未输入实际发票号
          /// 未选择发票创建结束日期
          params = {
            "fields":
                "id,status,amount,serial_number,attached,invoice_sell.actual_code,invoice_sell.id,invoice_sell.amount,invoice_sell.tax,invoice_sell.rate,driver.id,driver.name,invoice_sell.payer.company_name,date_created,invoice_sell.order_carrier.order_carrier_id.intention.demand.price,invoice_sell.order_carrier.order_carrier_id.code,invoice_sell.order_carrier.order_carrier_id.id,type",
            "filter": {
              "del": {"_eq": 0},
              "status": {"_in": receivableListFilterTypes},
              "type": {"_eq": 2},
              "driver": {"_eq": UserInfoModel().driver},
            },
            "sort": "-date_created",
          };
        }
      }
      await DioManager().getList<ReceivableModel>(API.receivable,
          params: params, onSuccess: (list) {
        settlementReceivableList = list;
        notifyListeners();
        EasyLoading.dismiss();
        return;
      }, onError: (error) {
        notifyListeners();
        EasyLoading.dismiss();
        return;
      });
    } else {
      EasyLoading.dismiss();
      return;
    }
  }

  Future refreshReceivableList(BuildContext context) async {
    EasyLoading.show(status: '加载中');
    if (UserInfoModel().driver == null || UserInfoModel().driver == "") {
      await getUserBaseInfo(context);
      if (UserInfoModel().driver == null || UserInfoModel().driver == "") {
        EasyLoading.showError("当前用户尚未填写用户信息，请先到 '我的-我的信息' 中更新个人信息");
        return;
      }
    } else {
      if (receivableListFilterTypes.isNotEmpty) {
        Map<String, dynamic> params = {};
        if (receivableFilterDateStart != "" && receivableFilterDateEnd != "") {
          if (receivableActualCode != "") {
            /// 输入了实际发票号
            /// 选择了发票创建结束日期
            params = {
              "fields":
                  "id,status,amount,serial_number,attached,invoice_sell.actual_code,invoice_sell.id,invoice_sell.amount,invoice_sell.tax,invoice_sell.rate,driver.id,driver.name,invoice_sell.payer.company_name,date_created,invoice_sell.order_carrier.order_carrier_id.intention.demand.price,invoice_sell.order_carrier.order_carrier_id.code,invoice_sell.order_carrier.order_carrier_id.id,type",
              "filter": {
                "del": {"_eq": 0},
                "status": {"_in": receivableListFilterTypes},
                "type": {"_eq": 2},
                "driver": {"_eq": UserInfoModel().driver},
                "serial_number": {"_contains": receivableActualCode},
                "date_created": {
                  "_between": [
                    receivableFilterDateStart,
                    receivableFilterDateEnd
                  ]
                }
              },
              "sort": "-date_created",
            };
          } else {
            /// 未输入实际发票号
            /// 选择了发票创建结束日期

            params = {
              "fields":
                  "id,status,amount,serial_number,attached,invoice_sell.actual_code,invoice_sell.id,invoice_sell.amount,invoice_sell.tax,invoice_sell.rate,driver.id,driver.name,invoice_sell.payer.company_name,date_created,invoice_sell.order_carrier.order_carrier_id.intention.demand.price,invoice_sell.order_carrier.order_carrier_id.code,invoice_sell.order_carrier.order_carrier_id.id,type",
              "filter": {
                "del": {"_eq": 0},
                "status": {"_in": receivableListFilterTypes},
                "type": {"_eq": 2},
                "driver": {"_eq": UserInfoModel().driver},
                "date_created": {
                  "_between": [
                    receivableFilterDateStart,
                    receivableFilterDateEnd
                  ]
                }
              },
              "sort": "-date_created",
            };
          }
        } else {
          if (receivableActualCode != "") {
            /// 输入了实际发票号
            /// 未选择发票创建结束日期
            params = {
              "fields":
                  "id,status,amount,serial_number,attached,invoice_sell.actual_code,invoice_sell.id,invoice_sell.amount,invoice_sell.tax,invoice_sell.rate,driver.id,driver.name,invoice_sell.payer.company_name,date_created,invoice_sell.order_carrier.order_carrier_id.intention.demand.price,invoice_sell.order_carrier.order_carrier_id.code,invoice_sell.order_carrier.order_carrier_id.id,type",
              "filter": {
                "del": {"_eq": 0},
                "status": {"_in": receivableListFilterTypes},
                "type": {"_eq": 2},
                "driver": {"_eq": UserInfoModel().driver},
                "serial_number": {"_contains": receivableActualCode},
              },
              "sort": "-date_created",
            };
          } else {
            /// 未输入实际发票号
            /// 未选择发票创建结束日期
            params = {
              "fields":
                  "id,status,amount,serial_number,attached,invoice_sell.actual_code,invoice_sell.id,invoice_sell.amount,invoice_sell.tax,invoice_sell.rate,driver.id,driver.name,invoice_sell.payer.company_name,date_created,invoice_sell.order_carrier.order_carrier_id.intention.demand.price,invoice_sell.order_carrier.order_carrier_id.code,invoice_sell.order_carrier.order_carrier_id.id,type",
              "filter": {
                "del": {"_eq": 0},
                "status": {"_in": receivableListFilterTypes},
                "type": {"_eq": 2},
                "driver": {"_eq": UserInfoModel().driver},
              },
              "sort": "-date_created",
            };
          }
        }
        await DioManager().getList<ReceivableModel>(API.receivable,
            params: params, onSuccess: (list) {
          settlementReceivableList = list;
          notifyListeners();
          EasyLoading.dismiss();
          return;
        }, onError: (error) {
          notifyListeners();
          EasyLoading.dismiss();
          FlushBarWidget.createDanger("获取发票信息失败", context);
          return;
        });
      } else {
        EasyLoading.dismiss();
        FlushBarWidget.createDanger("发票状态不能为空", context);
        return;
      }
    }
  }

  Future choseReceivableFilterType(
    BuildContext context,
  ) async {
    await showModalBottomSheet(
      isScrollControlled: true, // required for min/max child size
      context: context,
      builder: (ctx) {
        return MultiSelectBottomSheet<FilterType>(
          items: receivableOriganFilterItems,
          initialValue: receivableTypeCurrentDisplayData,
          listType: MultiSelectListType.CHIP,
          selectedColor: TTMColors.mainBlue,
          title: const Padding(
            padding: EdgeInsets.only(left: 15.0, top: 10),
            child: Text(
              "请选择发票状态",
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
              receivableTypeCurrentDisplayData = receivableTypeAllStatusData;
              receivableListFilterTypes =
                  invoiceTypeAllStatusData.map((e) => e.id).toList();
              notifyListeners();
            } else {
              receivableListFilterTypes = values.map((e) => e.id).toList();
              receivableTypeCurrentDisplayData = values;
              notifyListeners();
            }
          },
          maxChildSize: 1,
        );
      },
    );
  }

  Future choseReceivableFilterDate(
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
      receivableFilterDateStart =
          "${result.start.year}-${result.start.month}-${result.start.day}";
      receivableFilterDateEnd =
          "${result.end.year}-${result.end.month}-${result.end.day}";
      notifyListeners();
      onFinish(true);
    } else {
      onFinish(false);
    }
  }

  void clearReceivableFilterDate() {
    receivableFilterDateStart = "";
    receivableFilterDateEnd = "";
  }

  void clearReceivableSearchCode() {
    receivableActualCode = "";
  }

  /// 通过应收操作
  Future<bool> agreedReceivable(ReceivableModel receivableModel) async {
    EasyLoading.show(status: '加载中');

    /// 步骤1 更新 payables.status = 3(已确认)
    if (receivableModel.id == null) {
      EasyLoading.dismiss();
      return false;
    }
    await DioManager().patch(API.receivable + "/" + receivableModel.id!,
        data: {"status": "3"}, onSuccess: (_) {}, onError: (_) {
      EasyLoading.dismiss();
      return false;
    });

    /// 步骤2 更新order_carrier.status=9 会有多条运单数据，循环更新状态order_carrier.status=9
    if (receivableModel.invoiceSell.isNotEmpty) {
      if (receivableModel.invoiceSell.first.orderCarrier.isNotEmpty) {
        for (var item in receivableModel.invoiceSell.first.orderCarrier) {
          if (item.orderCarrierId.id == null) {
            continue;
          } else {
            await DioManager().patch(
                API.order_carrier + "/" + item.orderCarrierId.id!,
                data: {"status": "9"},
                onSuccess: (_) {}, onError: (_) {
              EasyLoading.dismiss();
              return false;
            });
          }
        }
      }
    }

    /// 步骤3 更新 invoice_sell.status = 5（已结算）
    if (receivableModel.invoiceSell.isNotEmpty) {
      if (receivableModel.invoiceSell.first.id != null) {
        await DioManager().patch(
            API.invoice + "/" + receivableModel.invoiceSell.first.id!,
            data: {"status": "5"},
            onSuccess: (_) {}, onError: (_) {
          EasyLoading.dismiss();
          return false;
        });
      }
    }

    /// 步骤4 增加一条 资金流水 cfa_carrier数据
    ///
    var newCafCafId = "";
    var newCafParams = {
      "status": "1",
      "amount": receivableModel.invoiceSell.first.amount,
      "payables": [receivableModel.id]
    };
    await DioManager().post(API.cafCarrier, data: newCafParams,
        onSuccess: (response) {
      if (response is Map<String, dynamic>) {
        if (response["id"] != null) {
          newCafCafId = response["id"];
        }
      } else {
        EasyLoading.dismiss();
        return false;
      }
    }, onError: (_) {
      EasyLoading.dismiss();
      return false;
    });

    /// 步骤5 查询afc_ctgy.id数据，流程6会用到此id值，调用方式参考postman1.1.41该接口返回的id，流程6与流程8会用到
    ///
    var afcCtyResultId = "";
    var getafcCtyParams = {
      "filter": {
        "name": {"_eq": "运单款结余"}
      },
      "fields": "id",
      "limit": 1,
      "sort": "-date_created"
    };
    await DioManager().getList(API.afcCtgy, params: getafcCtyParams,
        onSuccess: (list) {
      if (list.isNotEmpty) {
        var res = list.first;
        if (res is Map<String, dynamic>) {
          if (res["id"] != null) {
            afcCtyResultId = res["id"];
          }
        }
      }
    }, onError: (error) {
      EasyLoading.dismiss();
      return false;
    });

    // 步骤6 查询afc_carrier数据，参考postman1.1.42，如果该接口有值则走流程7逻辑，返回空走流程8逻辑。
    Map<String, dynamic> afcResultMap = {};
    bool isAfcResultMapEmpty = true;
    var afcCarrierParams = {
      "filter": {
        "del": {"_eq": 0},
        "afc_ctgy": {"_eq": afcCtyResultId},
        "driver": {"_eq": UserInfoModel().driver}
      },
      "fields": "id,status,amount,driver,cfa_carrier",
      "sort": "-date_created"
    };

    await DioManager().getList(API.afcCarrier, params: afcCarrierParams,
        onSuccess: (list) {
      if (list.isNotEmpty) {
        isAfcResultMapEmpty = false;
        var res = list.first;
        if (res is Map<String, dynamic>) {
          afcResultMap = res;
        }
      }
    }, onError: (error) {
      EasyLoading.dismiss();
      return false;
    });

    if (!isAfcResultMapEmpty) {
      /// 步骤 7、如果流程6（postman1.1.42）返回数据，则更新更新afc_carrier.cfa_carrier集合内容，把流程4生成的资金流水id插入到集合中，切记是插入操作，原集合值不动，插入一条新的数据。
      if (afcResultMap["id"] == null) {
        EasyLoading.dismiss();
        return false;
      }
      if (afcResultMap["cfa_carrier"] == null) {
        afcResultMap["cfa_carrier"] = [];
      }
      var cafList = [];
      for (var item in afcResultMap["cfa_carrier"]) {
        if (item is String) {
          cafList.add(item);
        }
      }
      cafList.add(newCafCafId);
      var patchAfcCarrierParams = {"cfa_carrier": cafList};
      await DioManager().patch(API.afcCarrier + "/" + afcResultMap["id"]!,
          data: patchAfcCarrierParams, onSuccess: (_) {}, onError: (_) {
        EasyLoading.dismiss();
        return false;
      });
      EasyLoading.dismiss();
      return true;
    } else {
      /// 步骤 8 如果流程6（postman1.1.42）返回空，则新增afc_carrier表，插入一条新数据
      var newAFCCarrierParams = {
        "afc_ctgy": afcCtyResultId,
        "status": "1",
        "amount": "0",
        "cfa_carrier": [newCafCafId],
        "driver": UserInfoModel().driver
      };
      await DioManager().post(API.afcCarrier,
          data: newAFCCarrierParams, onSuccess: (_) {}, onError: (_) {
        EasyLoading.dismiss();
        return false;
      });
      EasyLoading.dismiss();
      return true;
    }
  }

  /// 拒绝应收操作
  Future<bool> refuseReceivable(ReceivableModel receivableModel) async {
    /// 步骤1 更新payables表status改为4（拒绝
    if (receivableModel.id == null) {
      EasyLoading.dismiss();
      return false;
    }
    await DioManager().patch(API.receivable + "/" + receivableModel.id!,
        data: {"status": "4"}, onSuccess: (_) {}, onError: (_) {
      EasyLoading.dismiss();
      return false;
    });
    EasyLoading.dismiss();
    return true;
  }
}
