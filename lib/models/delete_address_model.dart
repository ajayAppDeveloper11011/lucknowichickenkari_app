// To parse this JSON data, do
//
//     final deleteAddressResponseModel = deleteAddressResponseModelFromJson(jsonString);

import 'dart:convert';

DeleteAddressResponseModel deleteAddressResponseModelFromJson(String str) => DeleteAddressResponseModel.fromJson(json.decode(str));

String deleteAddressResponseModelToJson(DeleteAddressResponseModel data) => json.encode(data.toJson());

class DeleteAddressResponseModel {
  bool error;
  String message;
  List<dynamic> data;

  DeleteAddressResponseModel({
    required this.error,
    required this.message,
    required this.data,
  });

  factory DeleteAddressResponseModel.fromJson(Map<String, dynamic> json) => DeleteAddressResponseModel(
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
