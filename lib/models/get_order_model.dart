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
  String image;
  PaymentMode paymentMode;
  String? paymentId;
  String delievryCharge;
  int paymentStatus;
  int orderStatus;
  int address;
  DateTime createdAt;
  DateTime updatedAt;

  OrderData({
    required this.id,
    required this.userId,
    required this.orderId,
    required this.amount,
    required this.image,
    required this.paymentMode,
    required this.paymentId,
    required this.delievryCharge,
    required this.paymentStatus,
    required this.orderStatus,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
    id: json["id"],
    userId: json["user_id"],
    orderId: json["order_id"],
    amount: json["amount"],
    image: json["image"]??'',
    paymentMode: paymentModeValues.map[json["payment_mode"]]!,
    paymentId: json["payment_id"],
    delievryCharge: json["delievry_charge"],
    paymentStatus: json["payment_status"],
    orderStatus: json["order_status"],
    address: json["address"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "order_id": orderId,
    "amount": amount,
    "image": image,
    "payment_mode": paymentModeValues.reverse[paymentMode],
    "payment_id": paymentId,
    "delievry_charge": delievryCharge,
    "payment_status": paymentStatus,
    "order_status": orderStatus,
    "address": address,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

enum PaymentMode {
  COD,
  CODE,
  PAYMENT_MODE_COD,
  PAYTM,
  PAY_PAL,
  RAZOR_PAY
}

final paymentModeValues = EnumValues({
  "cod": PaymentMode.COD,
  "code": PaymentMode.CODE,
  "COD": PaymentMode.PAYMENT_MODE_COD,
  "paytm": PaymentMode.PAYTM,
  "payPal": PaymentMode.PAY_PAL,
  "Razor Pay": PaymentMode.RAZOR_PAY
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
