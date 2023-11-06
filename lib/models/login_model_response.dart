// To parse this JSON data, do
//
//     final getLoginModel = getLoginModelFromJson(jsonString);

import 'dart:convert';

GetLoginModel getLoginModelFromJson(String str) => GetLoginModel.fromJson(json.decode(str));

String getLoginModelToJson(GetLoginModel data) => json.encode(data.toJson());

class GetLoginModel {
  String token;
  bool error;
  String message;
  List<LoginData> data;

  GetLoginModel({
    required this.token,
    required this.error,
    required this.message,
    required this.data,
  });

  factory GetLoginModel.fromJson(Map<String, dynamic> json) => GetLoginModel(
    token: json["token"],
    error: json["error"],
    message: json["message"],
    data: List<LoginData>.from(json["data"].map((x) => LoginData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class LoginData {
  int id;
  String profilePhotoUrl;

  LoginData({
    required this.id,
    required this.profilePhotoUrl,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
    id: json["id"],
    profilePhotoUrl: json["profile_photo_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "profile_photo_url": profilePhotoUrl,
  };
}
