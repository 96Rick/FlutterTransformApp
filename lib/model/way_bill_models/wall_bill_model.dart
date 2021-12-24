// To parse this JSON data, do
//
//     final wayBillModel = wayBillModelFromJson(jsonString);

import 'dart:convert';

class WayBillModel {
  WayBillModel({
    this.id,
    this.status,
    required this.attached,
    required this.orderCarrier,
    required this.driver,
    required this.transportation,
  });

  String? id;
  String? status;
  Attached attached = Attached(loading: [], receipt: []);
  OrderCarrier orderCarrier = OrderCarrier(
      evaluation: Evaluation(),
      intention: Intention(
          orderCarrier: [],
          orderShipper: [],
          demand: WayBillDemand(
              shipper: WayBillShipper(attached: WailBillAttached()),
              goodsType: WayBillCommonType(),
              pickupCity: WayBillCommonType(),
              pickupProvince: WayBillCommonType(),
              pickupArea: WayBillCommonType(),
              transportMode: WayBillCommonType(),
              receivingProvince: WayBillCommonType(),
              receivingCity: WayBillCommonType(),
              receivingArea: WayBillCommonType(),
              goods: [])));
  WayBillCommonType driver = WayBillCommonType();
  Transportation transportation = Transportation();

  factory WayBillModel.fromRawJson(String str) =>
      WayBillModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WayBillModel.fromJson(Map<String, dynamic> json) => WayBillModel(
        id: json["id"] ?? "",
        status: json["status"] ?? "",
        attached: json["attached"] == null
            ? Attached(loading: [], receipt: [])
            : Attached.fromJson(json["attached"]),
        orderCarrier: json["order_carrier"] == null
            ? OrderCarrier(
                evaluation: Evaluation(),
                intention: Intention(
                    orderCarrier: [],
                    orderShipper: [],
                    demand: WayBillDemand(
                        shipper: WayBillShipper(attached: WailBillAttached()),
                        goodsType: WayBillCommonType(),
                        pickupCity: WayBillCommonType(),
                        pickupProvince: WayBillCommonType(),
                        pickupArea: WayBillCommonType(),
                        transportMode: WayBillCommonType(),
                        receivingProvince: WayBillCommonType(),
                        receivingCity: WayBillCommonType(),
                        receivingArea: WayBillCommonType(),
                        goods: [])))
            : OrderCarrier.fromJson(json["order_carrier"]),
        driver: json["driver"] == null
            ? WayBillCommonType()
            : WayBillCommonType.fromJson(json["driver"]),
        transportation: json["transportation"] == null
            ? Transportation()
            : Transportation.fromJson(json["transportation"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "attached": attached.toJson(),
        "order_carrier": orderCarrier.toJson(),
        "driver": driver.toJson(),
        "transportation": transportation.toJson(),
      };
}

class Attached {
  Attached({
    required this.loading,
    required this.receipt,
  });

  List<String?> loading = [];
  List<String?> receipt = [];

  factory Attached.fromRawJson(String str) =>
      Attached.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attached.fromJson(Map<String, dynamic> json) => Attached(
        loading: json["loading"] == null
            ? []
            : List<String>.from(json["loading"].map((x) => x)),
        receipt: json["receipt"] == null
            ? []
            : List<String>.from(json["receipt"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "loading":
            loading == null ? [] : List<dynamic>.from(loading.map((x) => x)),
        "receipt":
            receipt == null ? [] : List<dynamic>.from(receipt.map((x) => x)),
      };
}

class OrderCarrier {
  OrderCarrier({
    this.code,
    this.id,
    this.score,
    this.status,
    required this.evaluation,
    required this.intention,
  });
  String? id;
  String? score;
  String? status;
  String? code;
  Evaluation evaluation = Evaluation();
  Intention intention = Intention(
      orderCarrier: [],
      orderShipper: [],
      demand: WayBillDemand(
          shipper: WayBillShipper(attached: WailBillAttached()),
          goodsType: WayBillCommonType(),
          pickupCity: WayBillCommonType(),
          pickupProvince: WayBillCommonType(),
          pickupArea: WayBillCommonType(),
          transportMode: WayBillCommonType(),
          receivingProvince: WayBillCommonType(),
          receivingCity: WayBillCommonType(),
          receivingArea: WayBillCommonType(),
          goods: []));

  factory OrderCarrier.fromRawJson(String str) =>
      OrderCarrier.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderCarrier.fromJson(Map<String, dynamic> json) => OrderCarrier(
        id: json["id"],
        status: json["status"],
        score: json["score"],
        code: json["code"],
        evaluation: json["evaluation"] == null
            ? Evaluation()
            : Evaluation.fromJson(json["evaluation"]),
        intention: json["intention"] == null
            ? Intention(
                orderCarrier: [],
                orderShipper: [],
                demand: WayBillDemand(
                    shipper: WayBillShipper(attached: WailBillAttached()),
                    goodsType: WayBillCommonType(),
                    pickupCity: WayBillCommonType(),
                    pickupProvince: WayBillCommonType(),
                    pickupArea: WayBillCommonType(),
                    transportMode: WayBillCommonType(),
                    receivingProvince: WayBillCommonType(),
                    receivingCity: WayBillCommonType(),
                    receivingArea: WayBillCommonType(),
                    goods: []))
            : Intention.fromJson(json["intention"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "intention": intention == null ? null : intention.toJson(),
      };
}

class Evaluation {
  Evaluation({
    this.goods,
    this.demand,
    this.remark,
    this.loading,
  });

  String? goods;
  String? demand;
  String? remark;
  String? loading;

  factory Evaluation.fromRawJson(String str) =>
      Evaluation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Evaluation.fromJson(Map<String, dynamic> json) => Evaluation(
        goods: json["goods"].toString(),
        demand: json["demand"].toString(),
        remark: json["remark"].toString(),
        loading: json["loading"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "goods": goods,
        "demand": demand,
        "remark": remark,
        "loading": loading,
      };
}

class Intention {
  Intention({
    this.id,
    required this.orderCarrier,
    required this.orderShipper,
    required this.demand,
  });
  String? id;
  List<String> orderCarrier = [];
  List<String> orderShipper = [];
  WayBillDemand demand = WayBillDemand(
      shipper: WayBillShipper(attached: WailBillAttached()),
      goodsType: WayBillCommonType(),
      pickupCity: WayBillCommonType(),
      pickupProvince: WayBillCommonType(),
      pickupArea: WayBillCommonType(),
      transportMode: WayBillCommonType(),
      receivingProvince: WayBillCommonType(),
      receivingCity: WayBillCommonType(),
      receivingArea: WayBillCommonType(),
      goods: []);

  factory Intention.fromRawJson(String str) =>
      Intention.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Intention.fromJson(Map<String, dynamic> json) => Intention(
        id: json["id"],
        orderCarrier: json["order_carrier"] == null
            ? []
            : (json["order_carrier"] as List<dynamic>)
                .map((dynamic e) => e as String)
                .toList(),
        // (json["order_carrier"] as List<String>)
        // ?.map((item) => item as String)
        // ?.toList(),
        orderShipper: json["order_shipper"] == null
            ? []
            : (json["order_shipper"] as List<dynamic>)
                .map((dynamic e) => e as String)
                .toList(),
        demand: json["demand"] == null
            ? WayBillDemand(
                shipper: WayBillShipper(attached: WailBillAttached()),
                goodsType: WayBillCommonType(),
                pickupCity: WayBillCommonType(),
                pickupProvince: WayBillCommonType(),
                pickupArea: WayBillCommonType(),
                transportMode: WayBillCommonType(),
                receivingProvince: WayBillCommonType(),
                receivingCity: WayBillCommonType(),
                receivingArea: WayBillCommonType(),
                goods: [])
            : WayBillDemand.fromJson(json["demand"]),
      );

  Map<String, dynamic> toJson() => {
        "demand": demand == null ? null : demand.toJson(),
      };
}

class WayBillDemand {
  WayBillDemand({
    this.id,
    this.remark,
    this.pickupAddress,
    this.receiving_address,
    this.pickupStart,
    this.pickupEnd,
    this.receivingStart,
    this.receivingEnd,
    this.price,
    this.receivingTel,
    this.receivingName,
    this.totalWeight,
    this.totalCount,
    this.totalVolumn,
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
  String? receiving_address;
  String? pickupEnd;
  String? receivingStart;
  String? receivingEnd;
  String? pickupStart;
  double? price;
  String? receivingTel;
  String? receivingName;
  double? totalWeight;
  double? totalCount;
  double? totalVolumn;
  WayBillShipper shipper;
  WayBillCommonType goodsType = WayBillCommonType();
  WayBillCommonType pickupCity = WayBillCommonType();
  WayBillCommonType pickupProvince = WayBillCommonType();
  WayBillCommonType pickupArea = WayBillCommonType();
  WayBillCommonType transportMode = WayBillCommonType();
  WayBillCommonType receivingProvince = WayBillCommonType();
  WayBillCommonType receivingCity = WayBillCommonType();
  WayBillCommonType receivingArea = WayBillCommonType();
  List<Good?> goods = [];

  factory WayBillDemand.fromRawJson(String str) =>
      WayBillDemand.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WayBillDemand.fromJson(Map<String, dynamic> json) => WayBillDemand(
        id: json["id"] ?? "",
        remark: json["remark"] ?? "",
        pickupAddress: json["pickup_address"] ?? "",
        receiving_address: json["receiving_address"] ?? "",
        pickupStart: json["pickup_start"] ?? "",
        pickupEnd: json["pickup_end"] ?? "",
        receivingStart: json["receiving_start"] ?? "",
        receivingEnd: json["receiving_end"] ?? "",
        price: json["price"] == null ? 0.0 : json["price"].toDouble(),
        receivingTel: json["receiving_tel"] ?? "",
        receivingName: json["receiving_name"] ?? "",
        totalWeight: json["total_weight"] == null
            ? 0.0
            : json["total_weight"].toDouble(),
        totalCount:
            json["total_count"] == null ? 0.0 : json["total_count"].toDouble(),
        totalVolumn: json["total_volume"] == null
            ? 0.0
            : json["total_volume"].toDouble(),
        shipper: json["shipper"] == null
            ? WayBillShipper(attached: WailBillAttached())
            : WayBillShipper.fromJson(json["shipper"]),
        goodsType: json["goods_type"] == null
            ? WayBillCommonType()
            : WayBillCommonType.fromJson(json["goods_type"]),
        pickupCity: json["pickup_city"] == null
            ? WayBillCommonType()
            : WayBillCommonType.fromJson(json["pickup_city"]),
        pickupProvince: json["pickup_province"] == null
            ? WayBillCommonType()
            : WayBillCommonType.fromJson(json["pickup_province"]),
        pickupArea: json["pickup_area"] == null
            ? WayBillCommonType()
            : WayBillCommonType.fromJson(json["pickup_area"]),
        transportMode: json["transport_mode"] == null
            ? WayBillCommonType()
            : WayBillCommonType.fromJson(json["transport_mode"]),
        receivingProvince: json["receiving_province"] == null
            ? WayBillCommonType()
            : WayBillCommonType.fromJson(json["receiving_province"]),
        receivingCity: json["receiving_city"] == null
            ? WayBillCommonType()
            : WayBillCommonType.fromJson(json["receiving_city"]),
        receivingArea: json["receiving_area"] == null
            ? WayBillCommonType()
            : WayBillCommonType.fromJson(json["receiving_area"]),
        goods: json["goods"] == null
            ? []
            : List<Good>.from(json["goods"].map((x) => Good.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "remark": remark,
        "pickup_address": pickupAddress,
        "receiving_address": receiving_address,
        "pickup_start": pickupStart,
        "pickup_end": pickupEnd,
        "receiving_start": receivingStart,
        "receiving_end": receivingEnd,
        "price": price,
        "receiving_tel": receivingTel,
        "receiving_name": receivingName,
        "total_weight": totalWeight,
        "total_count": totalCount,
        "shipper": shipper,
        "goods_type": goodsType,
        "pickup_city": pickupCity,
        "pickup_province": pickupProvince,
        "pickup_area": pickupArea,
        "transport_mode": transportMode,
        "receiving_province": receivingProvince,
        "receiving_city": receivingCity,
        "receiving_area": receivingArea,
        "goods": goods.isEmpty
            ? []
            : List<dynamic>.from(goods.map((x) => x!.toJson())),
      };
}

class Good {
  Good({
    this.name,
    this.count,
    this.volume,
    this.weight,
    required this.classification,
  });

  String? name;
  double? count;
  double? volume;
  double? weight;
  WayBillCommonType classification = WayBillCommonType();

  factory Good.fromRawJson(String str) => Good.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Good.fromJson(Map<String, dynamic> json) => Good(
        name: json["name"] ?? "",
        count: json["count"] != null ? json["count"].toDouble() : 0.0,
        volume: json["volume"] != null ? json["volume"].toDouble() : 0.0,
        weight: json["weight"] != null ? json["weight"].toDouble() : 0.0,
        classification: json["classification"] == null
            ? WayBillCommonType()
            : WayBillCommonType.fromJson(json["classification"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "count": count,
        "volume": volume,
        "weight": weight,
        "classification": classification == null ? "" : classification.toJson(),
      };
}

class WayBillShipper {
  WayBillShipper({
    this.id,
    this.companyName,
    this.companyCode,
    this.contactName,
    this.contactTel,
    this.contactPhone,
    required this.attached,
  });

  String? id;
  String? companyName;
  String? companyCode;
  String? contactName;
  String? contactTel;
  String? contactPhone;
  WailBillAttached attached = WailBillAttached();

  factory WayBillShipper.fromRawJson(String str) =>
      WayBillShipper.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WayBillShipper.fromJson(Map<String, dynamic> json) => WayBillShipper(
        id: json["id"] ?? "",
        companyName: json["company_name"] ?? "",
        companyCode: json["company_code"] ?? "",
        contactName: json["contact_name"] ?? "",
        contactTel: json["contact_tel"] ?? "",
        contactPhone: json["contact_phone"] ?? "",
        attached: json["attached"] == null
            ? WailBillAttached()
            : WailBillAttached.fromJson(json["attached"]),
      );

  Map<String, dynamic> toJson() => {
        "company_name": companyName ?? "",
        "company_code": companyCode ?? "",
        "contact_name": contactName ?? "",
        "contact_tel": contactTel ?? "",
        "contact_phone": contactPhone ?? "",
        "attached": attached.toJson(),
      };
}

class WailBillAttached {
  WailBillAttached({
    this.idBack,
    this.idFront,
    this.licensePic,
    this.busLicensePic,
  });

  String? idBack;
  String? idFront;
  String? licensePic;
  String? busLicensePic;

  factory WailBillAttached.fromRawJson(String str) =>
      WailBillAttached.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WailBillAttached.fromJson(Map<String, dynamic> json) =>
      WailBillAttached(
        idBack: json["idBack"],
        idFront: json["idFront"],
        licensePic: json["licensePic"],
        busLicensePic: json["busLicensePic"],
      );

  Map<String, dynamic> toJson() => {
        "idBack": idBack,
        "idFront": idFront,
        "licensePic": licensePic,
        "busLicensePic": busLicensePic,
      };
}

class Transportation {
  Transportation({
    this.licensePlateNumber,
  });

  String? licensePlateNumber;

  factory Transportation.fromRawJson(String str) =>
      Transportation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Transportation.fromJson(Map<String, dynamic> json) => Transportation(
        licensePlateNumber: json["license_plate_number"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "license_plate_number": licensePlateNumber ?? "",
      };
}

class WayBillCommonType {
  WayBillCommonType({
    this.name,
  });

  String? name;

  factory WayBillCommonType.fromRawJson(String str) =>
      WayBillCommonType.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WayBillCommonType.fromJson(Map<String, dynamic> json) =>
      WayBillCommonType(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
