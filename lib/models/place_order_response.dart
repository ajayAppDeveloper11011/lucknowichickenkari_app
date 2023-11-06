// To parse this JSON data, do
//
//     final placeOrderModel = placeOrderModelFromJson(jsonString);

import 'dart:convert';

PlaceOrderModel placeOrderModelFromJson(String str) => PlaceOrderModel.fromJson(json.decode(str));

String placeOrderModelToJson(PlaceOrderModel data) => json.encode(data.toJson());

class PlaceOrderModel {
  bool error;
  String orderId;
  String message;
  String status;
  // List<dynamic> data;

  PlaceOrderModel({
    required this.error,
    required this.orderId,
    required this.message,
    required this.status,
    // required this.data,
  });

  factory PlaceOrderModel.fromJson(Map<String, dynamic> json) => PlaceOrderModel(
    error: json["error"],
    orderId: json["order_id"],
    message: json["message"],
    status: json["status"],
    // data: List<dynamic>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "order_id": orderId,
    "message": message,
    "status": status,
    // "data": List<dynamic>.from(data.map((x) => x)),
  };
}
