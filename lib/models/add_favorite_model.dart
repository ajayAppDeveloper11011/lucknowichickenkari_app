// To parse this JSON data, do
//
//     final addFavoriteModel = addFavoriteModelFromJson(jsonString);

import 'dart:convert';

AddFavoriteModel addFavoriteModelFromJson(String str) => AddFavoriteModel.fromJson(json.decode(str));

String addFavoriteModelToJson(AddFavoriteModel data) => json.encode(data.toJson());

class AddFavoriteModel {
  bool error;
  String message;
  List<dynamic> data;

  AddFavoriteModel({
    required this.error,
    required this.message,
    required this.data,
  });

  factory AddFavoriteModel.fromJson(Map<String, dynamic> json) => AddFavoriteModel(
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
