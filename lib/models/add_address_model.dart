// To parse this JSON data, do
//
//     final addAddressModelResponse = addAddressModelResponseFromJson(jsonString);

import 'dart:convert';

AddAddressModelResponse addAddressModelResponseFromJson(String str) => AddAddressModelResponse.fromJson(json.decode(str));

String addAddressModelResponseToJson(AddAddressModelResponse data) => json.encode(data.toJson());

class AddAddressModelResponse {
  bool error;
  String message;
  List<dynamic> data;

  AddAddressModelResponse({
    required this.error,
    required this.message,
    required this.data,
  });

  factory AddAddressModelResponse.fromJson(Map<String, dynamic> json) => AddAddressModelResponse(
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
