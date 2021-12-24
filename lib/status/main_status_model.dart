/*
 * MainStatusModel 用来管理全局状态 
 */

// ignore: import_of_legacy_library_into_null_safe
import 'dart:async';

import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ttm/model/car_type_model.dart';
import 'package:ttm/model/goods_models/all_goods_model.dart';
import 'package:ttm/model/goods_models/contract_model.dart';
import 'package:ttm/model/intention_models/all_intention_model.dart';
import 'package:ttm/model/profile_models/all_car_info_model.dart';
import 'package:ttm/model/profile_models/attached_model.dart';
import 'package:ttm/model/profile_models/join_fleet_model.dart';
import 'package:ttm/model/profile_models/my_cars_card_model.dart';
import 'package:ttm/model/profile_models/my_detail_info_model.dart';
import 'package:ttm/model/settlement_models/invoice_model.dart';
import 'package:ttm/model/settlement_models/receivable_model.dart';
import 'package:ttm/model/token_model.dart';
import 'package:ttm/model/profile_models/user_info_model.dart';
import 'package:ttm/model/way_bill_models/wall_bill_model.dart';
import 'package:ttm/status/app_status.dart';
import 'package:ttm/status/gd_location_status.dart';
import 'package:ttm/status/good_status.dart';
import 'package:ttm/status/page_status.dart';
import 'package:ttm/status/settlement_status.dart';
import 'package:ttm/status/token_status.dart';
import 'package:ttm/status/user_status.dart';
import 'package:ttm/status/way_bill_status.dart';

class MainStatusModel extends Model
    with
        BaseStatus,
        AppStatus,
        PageStatus,
        TokenStatus,
        UserStatus,
        GoodStatus,
        WayBillStatus,
        SettlementStatus,
        LocationStatus {
  MainStatusModel() {
    initAppStatus().then((_) {
      initPageStatus();
      initAuthorityStatus();
      initGoodFilterData();
      initSettlementFilterData();
      initLocationStatus();
      initTokenStatus().then((_) async {
        await getCarTypeList().whenComplete(() {});
        initAppStatusFinished();
      });
    });
  }
}

class BaseStatus extends Model {
  /// basic
  bool isLoadingApp = true;
  bool isNeedReLogin = true;

  // 定位相关
  double currentLocationLatitude = 39.54;
  double currentLocationLongitude = 116.23;
  late Map<String, Object> locationResult;
  late StreamSubscription<Map<String, Object>> locationListener;
  final AMapFlutterLocation locationPlugin = AMapFlutterLocation();

  /// page
  late int homePageIndex;

  /// token
  TokenModel tokenModel = TokenModel();
  List<CarTypeModel> carTypeModelList = [];

  /// 用户 user
  String userEmail = "";
  bool isRememberMe = false;
  String savedUserName = "";

  /// 个人 profile
  UserInfoModel userInfoModel = UserInfoModel();
  List<MyCarCardInfoModel> myCarCardInfoList = [];
  MyDetailInfoModel myDetailInfoModel = MyDetailInfoModel(
      attached: AttachedModel(),
      company: [],
      driverAudit: [],
      ownerTransportation: []);
  bool isUserAlreadyJoinFleet = false;
  bool isUserWaitingFleetParaExaminar = false;
  String userWaitingFleetParaExaminarCompanyName = "";
  bool isUserNotJoinFleet = true;

  String currentUserDetailPhoneNumberInfo = "";
  String currentUserDetailNameInfo = "";

  List<AllCarInfoModel> allCarsInfoList = [];
  List<JoinFleetModel> searchCarFleetList = [];
  List<AllCarInfoModel> profileCarCardList = [];
  String fleetCompanyId = "";

  /// orders 货源
  // ------- goods
  // 合同信息
  ContractInfoModel contractInfoModel = ContractInfoModel();

  // 1 (发布) 4（承运人拒绝）6（审核未通过）8（托运人拒绝）
  // 不动初始值
  List<MultiSelectItem<FilterType>> goodsOriganFilterItems = [];
  // 联动
  List<int> goodsListFilterTypes = [1, 4, 6, 8];
  List<FilterType> goodsTypeCurrentDisplayData = [
    FilterType(id: 1, labelName: "发布"),
    FilterType(id: 4, labelName: "承运人拒绝"),
    FilterType(id: 6, labelName: "审核未通过"),
    FilterType(id: 8, labelName: "托运人拒绝"),
  ];
  late List<FilterType> goodsTypeAllStatusData;
  // 货源筛选开始时间
  String goodsFilterDateStart = "";
  // 货源筛选结束时间
  String goodsFilterDateEnd = "";
  // 当前全部货源列表
  List<GoodModel> currentGoodsList = [];
  // 记录当前货源列表的展开状态
  List<bool> isCurrentGoodsExpanded = [];

  // ------ interntions
  // 2 (承运人待确认) 3(承运人已确认) 4（承运人拒绝）5 (审核通过) 6（审核未通过）7 (托运人待确认) 8（托运人拒绝） 9 (托运人已确认)
  // 不动初始值
  List<MultiSelectItem<FilterType>> intentionOriganFilterItems = [];
  // 联动
  List<int> intentionListFilterTypes = [2, 3, 4, 5, 6, 7, 8, 9];
  List<FilterType> intentionTypeCurrentDisplayData = [
    FilterType(id: 2, labelName: "承运人待确认"),
    FilterType(id: 3, labelName: "承运人已确认"),
    FilterType(id: 4, labelName: "承运人拒绝"),
    FilterType(id: 5, labelName: "审核通过"),
    FilterType(id: 6, labelName: "审核未通过"),
    FilterType(id: 7, labelName: "托运人待确认"),
    FilterType(id: 8, labelName: "托运人拒绝"),
    FilterType(id: 9, labelName: "托运人已确认"),
  ];
  late List<FilterType> intentionTypeAllStatusData;
  String intentionFilterDateStart = "";
  String intentionFilterDateEnd = "";
  List<IntentionModel> currentIntentionsList = [];
  List<bool> isCurrentIntentionExpanded = [];

  /// 运单 WayBill
  // 带接单
  List<WayBillModel> wayBillWaitingAcceptlist = [];
  // 待提货
  List<WayBillModel> wayBillWaitingPickedUplist = [];
  // 待送达
  List<WayBillModel> wayBillWaitingServicelist = [];
  // 待确认
  List<WayBillModel> wayBillConfirmationReceiptlist = [];
  // 待评价
  List<WayBillModel> wayBillEvaluatelist = [];

  /// settlement 结算
  ///
  /// -------- 发票 Invoice
  // 1新增，2待确认，3已确认，4待结算，5已结算，6拒绝
  // 不动初始值
  List<MultiSelectItem<FilterType>> invoiceOriganFilterItems = [];
  // 联动
  List<int> invoiceListFilterTypes = [1, 2, 3, 4, 5, 6];
  List<FilterType> invoiceTypeCurrentDisplayData = [
    FilterType(id: 1, labelName: "新增"),
    FilterType(id: 2, labelName: "待确认"),
    FilterType(id: 3, labelName: "已确认"),
    FilterType(id: 4, labelName: "待结算"),
    FilterType(id: 5, labelName: "已结算"),
    FilterType(id: 6, labelName: "拒绝"),
  ];
  late List<FilterType> invoiceTypeAllStatusData;
  String invoiceFilterDateStart = "";
  String invoiceFilterDateEnd = "";
  String invoiceActualCode = "";
  List<InvoiceModel> settlementInvoiceList = [];

  /// -------- 应收 Receiving
  // 1,新增，2 待确认，3已确认，4拒绝
  // 不动初始值
  List<MultiSelectItem<FilterType>> receivableOriganFilterItems = [];
  // 联动
  List<int> receivableListFilterTypes = [1, 2, 3, 4];
  List<FilterType> receivableTypeCurrentDisplayData = [
    FilterType(id: 1, labelName: "新增"),
    FilterType(id: 2, labelName: "待确认"),
    FilterType(id: 3, labelName: "已确认"),
    FilterType(id: 4, labelName: "拒绝"),
  ];
  late List<FilterType> receivableTypeAllStatusData;
  String receivableFilterDateStart = "";
  String receivableFilterDateEnd = "";
  String receivableActualCode = "";
  List<ReceivableModel> settlementReceivableList = [];
}
