// To parse this JSON data, do
//
//     final removeFavoriteModel = removeFavoriteModelFromJson(jsonString);

import 'dart:convert';

RemoveFavoriteModel removeFavoriteModelFromJson(String str) => RemoveFavoriteModel.fromJson(json.decode(str));

String removeFavoriteModelToJson(RemoveFavoriteModel data) => json.encode(data.toJson());

class RemoveFavoriteModel {
  bool error;
  String message;
  List<dynamic> data;

  RemoveFavoriteModel({
    required this.error,
    required this.message,
    required this.data,
  });

  factory RemoveFavoriteModel.fromJson(Map<String, dynamic> json) => RemoveFavoriteModel(
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
