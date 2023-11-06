// To parse this JSON data, do
//
//     final addToCartResponseModel = addToCartResponseModelFromJson(jsonString);

import 'dart:convert';

AddToCartResponseModel addToCartResponseModelFromJson(String str) => AddToCartResponseModel.fromJson(json.decode(str));

String addToCartResponseModelToJson(AddToCartResponseModel data) => json.encode(data.toJson());

class AddToCartResponseModel {
  bool error;
  String message;
  List<dynamic> data;

  AddToCartResponseModel({
    required this.error,
    required this.message,
    required this.data,
  });

  factory AddToCartResponseModel.fromJson(Map<String, dynamic> json) => AddToCartResponseModel(
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
