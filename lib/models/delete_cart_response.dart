// To parse this JSON data, do
//
//     final deleteCartResponseModel = deleteCartResponseModelFromJson(jsonString);

import 'dart:convert';

DeleteCartResponseModel deleteCartResponseModelFromJson(String str) => DeleteCartResponseModel.fromJson(json.decode(str));

String deleteCartResponseModelToJson(DeleteCartResponseModel data) => json.encode(data.toJson());

class DeleteCartResponseModel {
  bool error;
  String message;
  List<dynamic> data;

  DeleteCartResponseModel({
    required this.error,
    required this.message,
    required this.data,
  });

  factory DeleteCartResponseModel.fromJson(Map<String, dynamic> json) => DeleteCartResponseModel(
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
