// To parse this JSON data, do
//
//     final updateUserResponseModel = updateUserResponseModelFromJson(jsonString);

import 'dart:convert';

UpdateUserResponseModel updateUserResponseModelFromJson(String str) => UpdateUserResponseModel.fromJson(json.decode(str));

String updateUserResponseModelToJson(UpdateUserResponseModel data) => json.encode(data.toJson());

class UpdateUserResponseModel {
  bool error;
  String message;
  List<dynamic> data;

  UpdateUserResponseModel({
    required this.error,
    required this.message,
    required this.data,
  });

  factory UpdateUserResponseModel.fromJson(Map<String, dynamic> json) => UpdateUserResponseModel(
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
