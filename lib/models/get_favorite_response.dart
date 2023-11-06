// To parse this JSON data, do
//
//     final getFavoriteResponseModel = getFavoriteResponseModelFromJson(jsonString);

import 'dart:convert';

GetFavoriteResponseModel getFavoriteResponseModelFromJson(String str) => GetFavoriteResponseModel.fromJson(json.decode(str));

String getFavoriteResponseModelToJson(GetFavoriteResponseModel data) => json.encode(data.toJson());

class GetFavoriteResponseModel {
  bool error;
  String message;
  List<FavoriteData> data;

  GetFavoriteResponseModel({
    required this.error,
    required this.message,
    required this.data,
  });

  factory GetFavoriteResponseModel.fromJson(Map<String, dynamic> json) => GetFavoriteResponseModel(
    error: json["error"],
    message: json["message"],
    data: List<FavoriteData>.from(json["data"].map((x) => FavoriteData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class FavoriteData {
  int id;
  int userId;
  int productId;
  int isfavorites;
  String createdAt;
  String updatedAt;
  int catId;
  int subCatId;
  dynamic discount;
  String offer;
  String productTitle;
  String productImage;
  String productPrice;
  String slug;
  String productShortDesc;
  String productLongDesc;
  String metaTitleTag;
  String metaTitleKeywords;
  String metaTitleDescription;

  FavoriteData({
    required this.id,
    required this.userId,
    required this.productId,
    required this.isfavorites,
    required this.createdAt,
    required this.updatedAt,
    required this.catId,
    required this.subCatId,
    required this.discount,
    required this.offer,
    required this.productTitle,
    required this.productImage,
    required this.productPrice,
    required this.slug,
    required this.productShortDesc,
    required this.productLongDesc,
    required this.metaTitleTag,
    required this.metaTitleKeywords,
    required this.metaTitleDescription,
  });

  factory FavoriteData.fromJson(Map<String, dynamic> json) => FavoriteData(
    id: json["id"]??'',
    userId: json["user_id"]??'',
    productId: json["product_id"]??'',
    isfavorites: json["isfavorites"]??'',
    createdAt: json["created_at"]??'',
    updatedAt: json["updated_at"]??'',
    catId: json["cat_id"]??'',
    subCatId: json["sub_cat_id"]??'',
    discount: json["discount"]??'',
    offer: json["offer"]??'',
    productTitle: json["product_title"],
    productImage: json["product_image"],
    productPrice: json["product_price"],
    slug: json["slug"],
    productShortDesc: json["product_short_desc"],
    productLongDesc: json["product_long_desc"],
    metaTitleTag: json["meta_title_tag"],
    metaTitleKeywords: json["meta_title_keywords"],
    metaTitleDescription: json["meta_title_description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "product_id": productId,
    "isfavorites": isfavorites,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "cat_id": catId,
    "sub_cat_id": subCatId,
    "discount": discount,
    "offer": offer,
    "product_title": productTitle,
    "product_image": productImage,
    "product_price": productPrice,
    "slug": slug,
    "product_short_desc": productShortDesc,
    "product_long_desc": productLongDesc,
    "meta_title_tag": metaTitleTag,
    "meta_title_keywords": metaTitleKeywords,
    "meta_title_description": metaTitleDescription,
  };
}
