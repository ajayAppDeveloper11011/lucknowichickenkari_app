// To parse this JSON data, do
//
//     final getProductDetailsModel = getProductDetailsModelFromJson(jsonString);

import 'dart:convert';

GetProductDetailsModel getProductDetailsModelFromJson(String str) => GetProductDetailsModel.fromJson(json.decode(str));

String getProductDetailsModelToJson(GetProductDetailsModel data) => json.encode(data.toJson());

class GetProductDetailsModel {
  bool error;
  String message;
  List<ProductDetailsData> data;

  GetProductDetailsModel({
    required this.error,
    required this.message,
    required this.data,
  });

  factory GetProductDetailsModel.fromJson(Map<String, dynamic> json) => GetProductDetailsModel(
    error: json["error"],
    message: json["message"],
    data: List<ProductDetailsData>.from(json["data"].map((x) => ProductDetailsData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ProductDetailsData {
  int id;
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
  String createdAt;
  String updatedAt;

  ProductDetailsData({
    required this.id,
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
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductDetailsData.fromJson(Map<String, dynamic> json) => ProductDetailsData(
    id: json["id"],
    catId: json["cat_id"],
    subCatId: json["sub_cat_id"],
    discount: json["discount"],
    offer: json["offer"],
    productTitle: json["product_title"],
    productImage: json["product_image"],
    productPrice: json["product_price"],
    slug: json["slug"],
    productShortDesc: json["product_short_desc"],
    productLongDesc: json["product_long_desc"],
    metaTitleTag: json["meta_title_tag"],
    metaTitleKeywords: json["meta_title_keywords"],
    metaTitleDescription: json["meta_title_description"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
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
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
