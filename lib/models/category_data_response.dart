// To parse this JSON data, do
//
//     final getCategoryModel = getCategoryModelFromJson(jsonString);

import 'dart:convert';

GetCategoryModel getCategoryModelFromJson(String str) => GetCategoryModel.fromJson(json.decode(str));

String getCategoryModelToJson(GetCategoryModel data) => json.encode(data.toJson());

class GetCategoryModel {
  bool error;
  String message;
  List<CategoryData> data;

  GetCategoryModel({
    required this.error,
    required this.message,
    required this.data,
  });

  factory GetCategoryModel.fromJson(Map<String, dynamic> json) => GetCategoryModel(
    error: json["error"],
    message: json["message"],
    data: List<CategoryData>.from(json["data"].map((x) => CategoryData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CategoryData {
  int id;
  String catTitle;
  String catImage;
  String metaTitleTag;
  String metaTitleKeywords;
  String metaTitleDescription;
  dynamic createdAt;
  dynamic updatedAt;

  CategoryData({
    required this.id,
    required this.catTitle,
    required this.catImage,
    required this.metaTitleTag,
    required this.metaTitleKeywords,
    required this.metaTitleDescription,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
    id: json["id"]??'',
    catTitle: json["cat_title"]??'',
    catImage: json["cat_image"]??'',
    metaTitleTag: json["meta_title_tag"]??'',
    metaTitleKeywords: json["meta_title_keywords"]??'',
    metaTitleDescription: json["meta_title_description"]??'',
    createdAt: json["created_at"]??'',
    updatedAt: json["updated_at"]??'',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cat_title": catTitle,
    "cat_image": catImage,
    "meta_title_tag": metaTitleTag,
    "meta_title_keywords": metaTitleKeywords,
    "meta_title_description": metaTitleDescription,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
