

import 'dart:convert';


GetCartResponseModel getCartResponseModelFromJson(String str) => GetCartResponseModel.fromJson(json.decode(str));

String getCartResponseModelToJson(GetCartResponseModel data) => json.encode(data.toJson());

class GetCartResponseModel {
  bool error;
  String message;
  List<GetCartData> data;

  GetCartResponseModel({
    required this.error,
    required this.message,
    required this.data,
  });

  factory GetCartResponseModel.fromJson(Map<String, dynamic> json) => GetCartResponseModel(
    error: json["error"],
    message: json["message"],
    data: List<GetCartData>.from(json["data"].map((x) => GetCartData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetCartData {
  int cartId;
  String color;
  int productQty;
  String size;
  int productId;
  int id;
  int catId;
  int subCatId;
  dynamic fabricId;
  dynamic discount;
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

  GetCartData({
    required this.cartId,
    required this.color,
    required this.productQty,
    required this.size,
    required this.productId,
    required this.id,
    required this.catId,
    required this.subCatId,
    required this.fabricId,
    required this.discount,
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

  factory GetCartData.fromJson(Map<String, dynamic> json) => GetCartData(
    cartId: json["cartId"] ?? '',
    color: json["color"] ?? '',
    productQty: json["product_qty"] ?? 0, // Assuming productQty is an int
    size: json["size"] ?? '',
    productId: json["product_Id"] ?? 0, // Assuming productId is an int
    id: json["id"] ?? 0, // Assuming id is an int
    catId: json["cat_id"] ?? 0, // Assuming catId is an int
    subCatId: json["sub_cat_id"] ?? 0, // Assuming subCatId is an int
    fabricId: json["fabric_id"], // Assuming fabricId can be null
    discount: json["discount"], // Assuming discount can be null
    productTitle: json["product_title"] ?? '',
    productImage: json["product_image"] ?? '',
    productPrice: json["product_price"] ?? '',
    slug: json["slug"] ?? '',
    productShortDesc: json["product_short_desc"] ?? '',
    productLongDesc: json["product_long_desc"] ?? '',
    metaTitleTag: json["meta_title_tag"] ?? '',
    metaTitleKeywords: json["meta_title_keywords"] ?? '',
    metaTitleDescription: json["meta_title_description"] ?? '',
    createdAt: json["created_at"] ?? '',
    updatedAt: json["updated_at"] ?? '',
  );


  Map<String, dynamic> toJson() => {
    "cartId": cartId,
    "color": color,
    "product_qty": productQty,
    "size": size,
    "product_Id": productId,
    "id": id,
    "cat_id": catId,
    "sub_cat_id": subCatId,
    "fabric_id": fabricId,
    "discount": discount,
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

