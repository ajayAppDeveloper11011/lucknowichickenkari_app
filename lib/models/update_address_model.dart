// To parse this JSON data, do
//
//     final updateAddressResponseModel = updateAddressResponseModelFromJson(jsonString);

import 'dart:convert';

UpdateAddressResponseModel updateAddressResponseModelFromJson(String str) => UpdateAddressResponseModel.fromJson(json.decode(str));

String updateAddressResponseModelToJson(UpdateAddressResponseModel data) => json.encode(data.toJson());

class UpdateAddressResponseModel {
  bool error;
  String message;
  List<dynamic> data;

  UpdateAddressResponseModel({
    required this.error,
    required this.message,
    required this.data,
  });

  factory UpdateAddressResponseModel.fromJson(Map<String, dynamic> json) => UpdateAddressResponseModel(
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
