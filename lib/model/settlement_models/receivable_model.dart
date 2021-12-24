// To parse this JSON data, do
//
//     final receivableModel = receivableModelFromJson(jsonString);

import 'dart:convert';

class ReceivableModel {
  ReceivableModel({
    this.id,
    this.status,
    this.amount,
    this.serialNumber,
    required this.attached,
    this.dateCreated,
    this.type,
    required this.invoiceSell,
    required this.driver,
  });

  String? id;
  String? status;
  double? amount;
  String? serialNumber;
  ReceivableAttached attached = ReceivableAttached();
  String? dateCreated;
  String? type;
  List<InvoiceSell> invoiceSell = [];
  ReceivableDriver driver = ReceivableDriver();

  factory ReceivableModel.fromRawJson(String str) =>
      ReceivableModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReceivableModel.fromJson(Map<String, dynamic> json) =>
      ReceivableModel(
        id: json["id"],
        status: json["status"],
        amount: json["amount"] != null ? json["amount"].toDouble() : 0.0,
        serialNumber: json["serial_number"],
        attached: json["attached"] != null
            ? ReceivableAttached.fromJson(json["attached"])
            : ReceivableAttached(),
        dateCreated: json["date_created"],
        type: json["type"],
        invoiceSell: json["invoice_sell"] != null
            ? json["invoice_sell"] is List
                ? (json["invoice_sell"] as List).isNotEmpty
                    ? List<InvoiceSell>.from(json["invoice_sell"]
                        .map((x) => InvoiceSell.fromJson(x)))
                    : []
                : []
            : [],
        driver: json["driver"] != null
            ? ReceivableDriver.fromJson(json["driver"])
            : ReceivableDriver(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "amount": amount,
        "serial_number": serialNumber,
        "attached": attached.toJson(),
        "date_created": dateCreated,
        "type": type,
        "invoice_sell": List<dynamic>.from(invoiceSell.map((x) => x.toJson())),
        "driver": driver.toJson(),
      };
}

class ReceivableAttached {
  ReceivableAttached({
    this.capitalFlow,
  });

  String? capitalFlow;

  factory ReceivableAttached.fromRawJson(String str) =>
      ReceivableAttached.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReceivableAttached.fromJson(Map<String, dynamic> json) =>
      ReceivableAttached(
        capitalFlow: json["capital_flow"],
      );

  Map<String, dynamic> toJson() => {
        "capital_flow": capitalFlow,
      };
}

class ReceivableDriver {
  ReceivableDriver({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory ReceivableDriver.fromRawJson(String str) =>
      ReceivableDriver.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReceivableDriver.fromJson(Map<String, dynamic> json) =>
      ReceivableDriver(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class InvoiceSell {
  InvoiceSell({
    this.id,
    this.amount,
    this.tax,
    this.rate,
    this.actualCode,
    required this.payer,
    required this.orderCarrier,
  });

  String? id;
  double? amount;
  double? tax;
  double? rate;
  String? actualCode;
  ReceivablePayer payer = ReceivablePayer();
  List<ReceivableOrderCarrier> orderCarrier = [];

  factory InvoiceSell.fromRawJson(String str) =>
      InvoiceSell.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InvoiceSell.fromJson(Map<String, dynamic> json) => InvoiceSell(
        id: json["id"],
        actualCode: json["actual_code"],
        amount: json["amount"] != null ? json["amount"].toDouble() : 0.0,
        tax: json["tax"] != null ? json["tax"].toDouble() : 0.0,
        rate: json["rate"] != null ? json["rate"].toDouble() : 0.0,
        payer: json["payer"] != null
            ? ReceivablePayer.fromJson(json["payer"])
            : ReceivablePayer(),
        orderCarrier: json["order_carrier"] != null
            ? json["order_carrier"] is List
                ? (json["order_carrier"] as List).isNotEmpty
                    ? List<ReceivableOrderCarrier>.from(json["order_carrier"]
                        .map((x) => ReceivableOrderCarrier.fromJson(x)))
                    : []
                : []
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "tax": tax,
        "rate": rate,
        "payer": payer.toJson(),
        "order_carrier":
            List<dynamic>.from(orderCarrier.map((x) => x.toJson())),
      };
}

class ReceivableOrderCarrier {
  ReceivableOrderCarrier({
    required this.orderCarrierId,
  });

  OrderCarrierId orderCarrierId = OrderCarrierId(
      intention: ReceivableIntention(demand: ReceivableDemand()));

  factory ReceivableOrderCarrier.fromRawJson(String str) =>
      ReceivableOrderCarrier.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReceivableOrderCarrier.fromJson(Map<String, dynamic> json) =>
      ReceivableOrderCarrier(
        orderCarrierId: json["order_carrier_id"] != null
            ? OrderCarrierId.fromJson(json["order_carrier_id"])
            : OrderCarrierId(
                intention: ReceivableIntention(demand: ReceivableDemand())),
      );

  Map<String, dynamic> toJson() => {
        "order_carrier_id": orderCarrierId.toJson(),
      };
}

class OrderCarrierId {
  OrderCarrierId({
    this.code,
    this.id,
    required this.intention,
  });

  String? code;
  String? id;
  ReceivableIntention intention =
      ReceivableIntention(demand: ReceivableDemand());

  factory OrderCarrierId.fromRawJson(String str) =>
      OrderCarrierId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderCarrierId.fromJson(Map<String, dynamic> json) => OrderCarrierId(
        code: json["code"],
        id: json["id"],
        intention: json["intention"] != null
            ? ReceivableIntention.fromJson(json["intention"])
            : ReceivableIntention(demand: ReceivableDemand()),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "id": id,
        "intention": intention.toJson(),
      };
}

class ReceivableIntention {
  ReceivableIntention({
    required this.demand,
  });

  ReceivableDemand demand;

  factory ReceivableIntention.fromRawJson(String str) =>
      ReceivableIntention.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReceivableIntention.fromJson(Map<String, dynamic> json) =>
      ReceivableIntention(
        demand: json["demand"] != null
            ? ReceivableDemand.fromJson(json["demand"])
            : ReceivableDemand(),
      );

  Map<String, dynamic> toJson() => {
        "demand": demand.toJson(),
      };
}

class ReceivableDemand {
  ReceivableDemand({
    this.price,
  });

  double? price;

  factory ReceivableDemand.fromRawJson(String str) =>
      ReceivableDemand.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReceivableDemand.fromJson(Map<String, dynamic> json) =>
      ReceivableDemand(
        price: json["price"] != null ? json["price"].toDouble() : 0.0,
      );

  Map<String, dynamic> toJson() => {
        "price": price,
      };
}

class ReceivablePayer {
  ReceivablePayer({
    this.companyName,
  });

  String? companyName;

  factory ReceivablePayer.fromRawJson(String str) =>
      ReceivablePayer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReceivablePayer.fromJson(Map<String, dynamic> json) =>
      ReceivablePayer(
        companyName: json["company_name"],
      );

  Map<String, dynamic> toJson() => {
        "company_name": companyName,
      };
}
