// To parse this JSON data, do
//
//     final getOrderModel = getOrderModelFromJson(jsonString);

import 'dart:convert';

GetOrderModel getOrderModelFromJson(String str) => GetOrderModel.fromJson(json.decode(str));

String getOrderModelToJson(GetOrderModel data) => json.encode(data.toJson());

class GetOrderModel {
  bool error;
  String message;
  List<OrderData> data;

  GetOrderModel({
    required this.error,
    required this.message,
    required this.data,
  });

  factory GetOrderModel.fromJson(Map<String, dynamic> json) => GetOrderModel(
    error: json["error"],
    message: json["message"],
    data: List<OrderData>.from(json["data"].map((x) => OrderData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class OrderData {
  int id;
  String userId;
  String orderId;
  String amount;
  String paymentMode;
  dynamic paymentId;
  String delievryCharge;
  int paymentStatus;
  int orderStatus;
  dynamic curierCompany;
  dynamic tarckingId;
  int address;
  DateTime date;
  DateTime createdAt;
  DateTime updatedAt;

  OrderData({
    required this.id,
    required this.userId,
    required this.orderId,
    required this.amount,
    required this.paymentMode,
    required this.paymentId,
    required this.delievryCharge,
    required this.paymentStatus,
    required this.orderStatus,
    required this.curierCompany,
    required this.tarckingId,
    required this.address,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
    id: json["id"],
    userId: json["user_id"],
    orderId: json["order_id"],
    amount: json["amount"],
    paymentMode: json["payment_mode"],
    paymentId: json["payment_id"],
    delievryCharge: json["delievry_charge"],
    paymentStatus: json["payment_status"],
    orderStatus: json["order_status"],
    curierCompany: json["curier_company"],
    tarckingId: json["tarcking_id"],
    address: json["address"],
    date: DateTime.parse(json["date"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "order_id": orderId,
    "amount": amount,
    "payment_mode": paymentMode,
    "payment_id": paymentId,
    "delievry_charge": delievryCharge,
    "payment_status": paymentStatus,
    "order_status": orderStatus,
    "curier_company": curierCompany,
    "tarcking_id": tarckingId,
    "address": address,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
