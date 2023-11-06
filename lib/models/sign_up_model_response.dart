// To parse this JSON data, do
//
//     final registerUserResponse = registerUserResponseFromJson(jsonString);

import 'dart:convert';

RegisterUserResponse registerUserResponseFromJson(String str) => RegisterUserResponse.fromJson(json.decode(str));

String registerUserResponseToJson(RegisterUserResponse data) => json.encode(data.toJson());

class RegisterUserResponse {
  bool error;
  String message;
  List<dynamic> data;

  RegisterUserResponse({
    required this.error,
    required this.message,
    required this.data,
  });

  factory RegisterUserResponse.fromJson(Map<String, dynamic> json) => RegisterUserResponse(
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
