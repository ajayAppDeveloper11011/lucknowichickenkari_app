// To parse this JSON data, do
//
//     final paymentStatusModel = paymentStatusModelFromJson(jsonString);

import 'dart:convert';

PaymentStatusModel paymentStatusModelFromJson(String str) => PaymentStatusModel.fromJson(json.decode(str));

String paymentStatusModelToJson(PaymentStatusModel data) => json.encode(data.toJson());

class PaymentStatusModel {
  bool error;
  String message;
  List<dynamic> data;

  PaymentStatusModel({
    required this.error,
    required this.message,
    required this.data,
  });

  factory PaymentStatusModel.fromJson(Map<String, dynamic> json) => PaymentStatusModel(
    error: json["error"],
    message: json["message"],
    data: List<dynamic>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x)),
  };
}
