import 'package:ttm/model/car_type_model.dart';
import 'package:ttm/model/driver_id_model.dart';
import 'package:ttm/model/goods_models/all_goods_model.dart';
import 'package:ttm/model/goods_models/contract_model.dart';
import 'package:ttm/model/goods_models/good_bid_car_model.dart';
import 'package:ttm/model/intention_models/all_intention_model.dart';
import 'package:ttm/model/profile_models/all_car_info_model.dart';
import 'package:ttm/model/profile_models/cars_in_fleet_model.dart';
import 'package:ttm/model/profile_models/join_fleet_model.dart';
import 'package:ttm/model/profile_models/my_cars_card_model.dart';
import 'package:ttm/model/profile_models/my_detail_info_model.dart';
import 'package:ttm/model/settlement_models/invoice_model.dart';
import 'package:ttm/model/settlement_models/receivable_model.dart';
import 'package:ttm/model/token_model.dart';
import 'package:ttm/model/profile_models/user_info_model.dart';
import 'package:ttm/model/way_bill_models/source_model.dart';
import 'package:ttm/model/way_bill_models/wall_bill_model.dart';

class ModelFactory {
  static T? generateModel<T>(json) {
    if (json == null) {
      return null;
    } else if (T.toString() == "TokenModel") {
      return TokenModel.fromJson(json) as T;
    } else if (T.toString() == "DriverIDModel") {
      return DriverIDModel.fromJson(json) as T;
    } else if (T.toString() == "UserInfoModel") {
      return UserInfoModel.fromJson(json) as T;
    } else if (T.toString() == "MyCarCardInfoModel") {
      return MyCarCardInfoModel.fromJson(json) as T;
    } else if (T.toString() == "MyDetailInfoModel") {
      return MyDetailInfoModel.fromJson(json) as T;
    } else if (T.toString() == "JoinFleetModel") {
      return JoinFleetModel.fromJson(json) as T;
    } else if (T.toString() == "CarTypeModel") {
      return CarTypeModel.fromJson(json) as T;
    } else if (T.toString() == "AllCarInfoModel") {
      return AllCarInfoModel.fromJson(json) as T;
    } else if (T.toString() == "GoodModel") {
      return GoodModel.fromJson(json) as T;
    } else if (T.toString() == "IntentionModel") {
      return IntentionModel.fromJson(json) as T;
    } else if (T.toString() == "GoodBidCar") {
      return GoodBidCar.fromJson(json) as T;
    } else if (T.toString() == "WayBillModel") {
      return WayBillModel.fromJson(json) as T;
    } else if (T.toString() == "ContractInfoModel") {
      return ContractInfoModel.fromJson(json) as T;
    } else if (T.toString() == "ScoreModel") {
      return ScoreModel.fromJson(json) as T;
    } else if (T.toString() == "ReceivableModel") {
      return ReceivableModel.fromJson(json) as T;
    } else if (T.toString() == "InvoiceModel") {
      return InvoiceModel.fromJson(json) as T;
    } else if (T.toString() == "CarsInFleetModel") {
      return CarsInFleetModel.fromJson(json) as T;
    } else {
      return json as T;
    }
  }
}
