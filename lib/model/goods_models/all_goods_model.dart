// To parse this JSON data, do
//
//     final goodModel = goodModelFromJson(jsonString);

import 'dart:convert';

import 'package:ttm/model/goods_models/carrier_model.dart';
import 'package:ttm/model/goods_models/goods_model.dart';
import 'package:ttm/model/goods_models/shipper_model.dart';

class GoodModel {
  GoodModel({
    this.id,
    this.code,
    this.status,
    this.remark,
    this.pickupAddress,
    this.pickupStart,
    this.pickupEnd,
    this.receivingStart,
    this.receivingEnd,
    this.price,
    this.receivingTel,
    this.receivingName,
    this.receiving_address,
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
    required this.carrier,
  });

  String? id;
  String? code;
  String? status;
  String? remark;
  String? pickupAddress;
  String? pickupStart;
  String? pickupEnd;
  String? receivingStart;
  String? receivingEnd;
  double? price;
  String? receivingTel;
  String? receivingName;
  String? receiving_address;
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
  Carrier carrier = Carrier();

  factory GoodModel.fromRawJson(String str) =>
      GoodModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GoodModel.fromJson(Map<String, dynamic> json) => GoodModel(
        id: json["id"],
        code: json["code"],
        status: json["status"],
        remark: json["remark"],
        pickupAddress: json["pickup_address"],
        pickupStart: json["pickup_start"],
        pickupEnd: json["pickup_end"],
        receivingStart: json["receiving_start"],
        receivingEnd: json["receiving_end"],
        price: json["price"] != null ? json["price"].toDouble() : 0.0,
        receivingTel: json["receiving_tel"],
        receivingName: json["receiving_name"],
        receiving_address: json["receiving_address"],
        totalWeight: json["total_weight"] != null
            ? json["total_weight"].toDouble()
            : 0.0,
        totalVolume: json["total_volume"] != null
            ? json["total_volume"].toDouble()
            : 0.0,
        totalCount:
            json["total_count"] != null ? json["total_count"].toDouble() : 0.0,
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
        goods: json["goods"] == null
            ? []
            : List<Goods>.from(json["goods"].map((x) => Goods.fromJson(x))),
        carrier: json["carrier"] == null
            ? Carrier()
            : Carrier.fromJson(json["carrier"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "status": status,
        "remark": remark,
        "pickup_address": pickupAddress,
        "pickup_start": pickupStart,
        "pickup_end": pickupEnd,
        "receiving_start": receivingStart,
        "receiving_end": receivingEnd,
        "price": price,
        "receiving_tel": receivingTel,
        "receiving_name": receivingName,
        "receiving_address": receiving_address,
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
        "goods": List<dynamic>.from(goods.map((x) => x.toJson())),
        "carrier": carrier.toJson(),
      };
}

class GoodsCommonType {
  GoodsCommonType({
    this.name,
  });

  String? name;

  factory GoodsCommonType.fromRawJson(String str) =>
      GoodsCommonType.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GoodsCommonType.fromJson(Map<String, dynamic> json) =>
      GoodsCommonType(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
