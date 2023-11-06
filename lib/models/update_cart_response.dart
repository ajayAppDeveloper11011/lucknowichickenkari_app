// To parse this JSON data, do
//
//     final cartUpdateModel = cartUpdateModelFromJson(jsonString);

import 'dart:convert';

CartUpdateModel cartUpdateModelFromJson(String str) => CartUpdateModel.fromJson(json.decode(str));

String cartUpdateModelToJson(CartUpdateModel data) => json.encode(data.toJson());

class CartUpdateModel {
  bool error;
  String message;
  List<dynamic> data;

  CartUpdateModel({
    required this.error,
    required this.message,
    required this.data,
  });

  factory CartUpdateModel.fromJson(Map<String, dynamic> json) => CartUpdateModel(
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
