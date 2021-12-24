// To parse this JSON data, do
//
//     final intentionModel = intentionModelFromJson(jsonString);

import 'dart:convert';

import 'package:ttm/model/goods_models/all_goods_model.dart';
import 'package:ttm/model/goods_models/carrier_model.dart';
import 'package:ttm/model/goods_models/goods_model.dart';
import 'package:ttm/model/goods_models/shipper_model.dart';

class IntentionModel {
  IntentionModel({
    this.id,
    this.code,
    this.status,
    required this.demand,
    required this.carrier,
    required this.driver,
    this.transportation,
  });

  String? id;
  String? code;
  String? status;
  Demand demand = Demand(
      shipper: Shipper(),
      goodsType: GoodsCommonType(),
      pickupCity: GoodsCommonType(),
      pickupProvince: GoodsCommonType(),
      pickupArea: GoodsCommonType(),
      transportMode: GoodsCommonType(),
      receivingProvince: GoodsCommonType(),
      receivingCity: GoodsCommonType(),
      receivingArea: GoodsCommonType(),
      goods: []);
  Carrier carrier = Carrier();
  GoodsCommonType driver = GoodsCommonType();
  String? transportation;

  factory IntentionModel.fromRawJson(String str) =>
      IntentionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory IntentionModel.fromJson(Map<String, dynamic> json) => IntentionModel(
      id: json["id"],
      code: json["code"],
      status: json["status"],
      demand: Demand.fromJson(json["demand"] ?? {}),
      carrier: Carrier.fromJson(json["carrier"] ?? {}),
      driver: json["driver"] == null
          ? GoodsCommonType()
          : GoodsCommonType.fromJson(json["driver"] ?? {}),
      transportation: json["transportation"] == null
          ? ""
          : json["transportation"] is Map<String, dynamic>
              ? json["transportation"]["license_plate_number"] ?? ""
              : "");

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "status": status,
        "demand": demand.toJson(),
        "carrier": carrier.toJson(),
      };
}

class Demand {
  Demand({
    this.id,
    this.remark,
    this.pickupAddress,
    this.receivingAddress,
    this.pickupStart,
    this.pickupEnd,
    this.receivingStart,
    this.receivingEnd,
    this.price,
    this.receivingTel,
    this.receivingName,
    this.totalWeight,
    this.totalVolume,
    this.totalCount,
    required this.shipper,
    required this.goodsType,
    required this.pickupCity,
    required this.pickupProvince,
    required this.pickupArea,
    required this.transportMode,
    required this.receivingProvince,
    required this.receivingCity,
    required this.receivingArea,
    required this.goods,
  });

  String? id;
  String? remark;
  String? pickupAddress;
  String? receivingAddress;
  String? pickupStart;
  String? pickupEnd;
  String? receivingStart;
  String? receivingEnd;
  double? price;
  String? receivingTel;
  String? receivingName;
  double? totalWeight;
  double? totalVolume;
  double? totalCount;
  Shipper shipper = Shipper();
  GoodsCommonType goodsType = GoodsCommonType();
  GoodsCommonType pickupCity = GoodsCommonType();
  GoodsCommonType pickupProvince = GoodsCommonType();
  GoodsCommonType pickupArea = GoodsCommonType();
  GoodsCommonType transportMode = GoodsCommonType();
  GoodsCommonType receivingProvince = GoodsCommonType();
  GoodsCommonType receivingCity = GoodsCommonType();
  GoodsCommonType receivingArea = GoodsCommonType();

  List<Goods> goods = [];

  factory Demand.fromRawJson(String str) => Demand.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Demand.fromJson(Map<String, dynamic> json) => Demand(
        id: json["id"],
        remark: json["remark"],
        pickupAddress: json["pickup_address"],
        pickupStart: json["pickup_start"],
        pickupEnd: json["pickup_end"],
        receivingStart: json["receiving_start"],
        receivingEnd: json["receiving_end"],
        price: json["price"].toDouble(),
        receivingTel: json["receiving_tel"],
        receivingName: json["receiving_name"],
        totalWeight: json["total_weight"].toDouble(),
        totalVolume: json["total_volume"].toDouble(),
        totalCount: json["total_count"].toDouble(),
        shipper: json["shipper"] == null
            ? Shipper()
            : Shipper.fromJson(json["shipper"]),
        goodsType: json["goods_type"] == null
            ? GoodsCommonType()
            : GoodsCommonType.fromJson(json["goods_type"]),
        pickupCity: json["pickup_city"] == null
            ? GoodsCommonType()
            : GoodsCommonType.fromJson(json["pickup_city"]),
        pickupProvince: json["pickup_province"] == null
            ? GoodsCommonType()
            : GoodsCommonType.fromJson(json["pickup_province"]),
        pickupArea: json["pickup_area"] == null
            ? GoodsCommonType()
            : GoodsCommonType.fromJson(json["pickup_area"]),
        transportMode: json["transport_mode"] == null
            ? GoodsCommonType()
            : GoodsCommonType.fromJson(json["transport_mode"]),
        receivingProvince: json["receiving_province"] == null
            ? GoodsCommonType()
            : GoodsCommonType.fromJson(json["receiving_province"]),
        receivingCity: json["receiving_city"] == null
            ? GoodsCommonType()
            : GoodsCommonType.fromJson(json["receiving_city"]),
        receivingArea: json["receiving_area"] == null
            ? GoodsCommonType()
            : GoodsCommonType.fromJson(json["receiving_area"]),
        receivingAddress: json["receiving_address"],
        goods: json["goods"] == null
            ? []
            : List<Goods>.from(json["goods"].map((x) => Goods.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "remark": remark,
        "pickup_address": pickupAddress,
        "pickup_start": pickupStart,
        "pickup_end": pickupEnd,
        "receiving_start": receivingStart,
        "receiving_end": receivingEnd,
        "price": price,
        "receiving_tel": receivingTel,
        "receiving_name": receivingName,
        "total_weight": totalWeight,
        "total_volume": totalVolume,
        "total_count": totalCount,
        "shipper": shipper.toJson(),
        "goods_type": goodsType.toJson(),
        "pickup_city": pickupCity.toJson(),
        "pickup_province": pickupProvince.toJson(),
        "pickup_area": pickupArea.toJson(),
        "transport_mode": transportMode.toJson(),
        "receiving_province": receivingProvince.toJson(),
        "receiving_city": receivingCity.toJson(),
        "receiving_area": receivingArea.toJson(),
        "receiving_address": receivingAddress,
        "goods": List<dynamic>.from(goods.map((x) => x.toJson())),
      };
}
