// To parse this JSON data, do
//
//     final invoiceModel = invoiceModelFromJson(jsonString);

import 'dart:convert';

class InvoiceModel {
  InvoiceModel({
    this.id,
    this.status,
    this.amount,
    this.actualCode,
    required this.attached,
    this.tax,
    this.rate,
    this.dateCreated,
    required this.driver,
    required this.payer,
    required this.orderCarrier,
  });

  String? id;
  String? status;
  double? amount;
  String? actualCode;
  InvoiceAttached attached = InvoiceAttached();
  double? tax;
  double? rate;
  String? dateCreated;
  InvoiceDriver driver = InvoiceDriver();
  InvoicePayer payer = InvoicePayer();
  List<OrderCarrier> orderCarrier;

  factory InvoiceModel.fromRawJson(String str) =>
      InvoiceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InvoiceModel.fromJson(Map<String, dynamic> json) => InvoiceModel(
        id: json["id"],
        status: json["status"],
        amount: json["amount"] != null ? json["amount"].toDouble() : 0.0,
        actualCode: json["actual_code"],
        attached: json["attached"] != null
            ? InvoiceAttached.fromJson(json["attached"])
            : InvoiceAttached(),
        tax: json["tax"] != null ? json["tax"].toDouble() : 0.0,
        rate: json["rate"] != null ? json["rate"].toDouble() : 0.0,
        dateCreated: json["date_created"],
        driver: json["driver"] != null
            ? InvoiceDriver.fromJson(json["driver"])
            : InvoiceDriver(),
        payer: json["payer"] != null
            ? InvoicePayer.fromJson(json["payer"])
            : InvoicePayer(),
        orderCarrier: json["order_carrier"] != null
            ? json["order_carrier"] is List
                ? (json["order_carrier"] as List).isNotEmpty
                    ? List<OrderCarrier>.from(json["order_carrier"]
                        .map((x) => OrderCarrier.fromJson(x)))
                    : []
                : []
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "amount": amount,
        "actual_code": actualCode,
        "attached": attached.toJson(),
        "tax": tax,
        "rate": rate,
        "date_created": dateCreated,
        "driver": driver.toJson(),
        "payer": payer.toJson(),
        "order_carrier":
            List<dynamic>.from(orderCarrier.map((x) => x.toJson())),
      };
}

class InvoiceAttached {
  InvoiceAttached({
    this.actualInvoice,
  });

  String? actualInvoice;

  factory InvoiceAttached.fromRawJson(String str) =>
      InvoiceAttached.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InvoiceAttached.fromJson(Map<String, dynamic> json) =>
      InvoiceAttached(
        actualInvoice: json["actual_invoice"],
      );

  Map<String, dynamic> toJson() => {
        "actual_invoice": actualInvoice,
      };
}

class InvoiceDriver {
  InvoiceDriver({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory InvoiceDriver.fromRawJson(String str) =>
      InvoiceDriver.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InvoiceDriver.fromJson(Map<String, dynamic> json) => InvoiceDriver(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class OrderCarrier {
  OrderCarrier({
    required this.orderCarrierId,
  });

  OrderCarrierId orderCarrierId =
      OrderCarrierId(intention: Intention(demand: Demand()));

  factory OrderCarrier.fromRawJson(String str) =>
      OrderCarrier.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderCarrier.fromJson(Map<String, dynamic> json) => OrderCarrier(
        orderCarrierId: json["order_carrier_id"] != null
            ? OrderCarrierId.fromJson(json["order_carrier_id"])
            : OrderCarrierId(intention: Intention(demand: Demand())),
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
  Intention intention = Intention(demand: Demand());

  factory OrderCarrierId.fromRawJson(String str) =>
      OrderCarrierId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderCarrierId.fromJson(Map<String, dynamic> json) => OrderCarrierId(
        code: json["code"],
        id: json["id"],
        intention: json["intention"] != null
            ? Intention.fromJson(json["intention"])
            : Intention(demand: Demand()),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "id": id,
        "intention": intention.toJson(),
      };
}

class Intention {
  Intention({
    required this.demand,
  });

  Demand demand = Demand();

  factory Intention.fromRawJson(String str) =>
      Intention.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Intention.fromJson(Map<String, dynamic> json) => Intention(
        demand:
            json["demand"] != null ? Demand.fromJson(json["demand"]) : Demand(),
      );

  Map<String, dynamic> toJson() => {
        "demand": demand.toJson(),
      };
}

class Demand {
  Demand({
    this.price,
  });

  double? price;

  factory Demand.fromRawJson(String str) => Demand.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Demand.fromJson(Map<String, dynamic> json) => Demand(
        price: json["price"] != null ? json["price"].toDouble() : 0.0,
      );

  Map<String, dynamic> toJson() => {
        "price": price,
      };
}

class InvoicePayer {
  InvoicePayer({
    this.companyName,
  });

  String? companyName;

  factory InvoicePayer.fromRawJson(String str) =>
      InvoicePayer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InvoicePayer.fromJson(Map<String, dynamic> json) => InvoicePayer(
        companyName: json["company_name"],
      );

  Map<String, dynamic> toJson() => {
        "company_name": companyName,
      };
}
