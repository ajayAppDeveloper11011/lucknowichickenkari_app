// To parse this JSON data, do
//
//     final subCategoryModel = subCategoryModelFromJson(jsonString);

import 'dart:convert';

SubCategoryModel subCategoryModelFromJson(String str) => SubCategoryModel.fromJson(json.decode(str));

String subCategoryModelToJson(SubCategoryModel data) => json.encode(data.toJson());

class SubCategoryModel {
  bool error;
  String message;
  List<SubCategoryData> data;

  SubCategoryModel({
    required this.error,
    required this.message,
    required this.data,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) => SubCategoryModel(
    error: json["error"],
    message: json["message"],
    data: List<SubCategoryData>.from(json["data"].map((x) => SubCategoryData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SubCategoryData {
  int id;
  int catId;
  String subcatTitle;
  String subcategoryImage;
  String metaTitleTag;
  String metaTitleKeywords;
  String metaTitleDescription;
  dynamic createdAt;
  dynamic updatedAt;

  SubCategoryData({
    required this.id,
    required this.catId,
    required this.subcatTitle,
    required this.subcategoryImage,
    required this.metaTitleTag,
    required this.metaTitleKeywords,
    required this.metaTitleDescription,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SubCategoryData.fromJson(Map<String, dynamic> json) => SubCategoryData(
    id: json["id"],
    catId: json["cat_id"],
    subcatTitle: json["subcat_title"],
    subcategoryImage: json["subcategory_image"],
    metaTitleTag: json["meta_title_tag"],
    metaTitleKeywords: json["meta_title_keywords"],
    metaTitleDescription: json["meta_title_description"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cat_id": catId,
    "subcat_title": subcatTitle,
    "subcategory_image": subcategoryImage,
    "meta_title_tag": metaTitleTag,
    "meta_title_keywords": metaTitleKeywords,
    "meta_title_description": metaTitleDescription,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
