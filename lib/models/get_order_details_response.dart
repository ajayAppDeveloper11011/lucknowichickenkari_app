// To parse this JSON data, do
//
//     final orderDetailsResponseData = orderDetailsResponseDataFromJson(jsonString);

import 'dart:convert';

OrderDetailsResponseData orderDetailsResponseDataFromJson(String str) => OrderDetailsResponseData.fromJson(json.decode(str));

String orderDetailsResponseDataToJson(OrderDetailsResponseData data) => json.encode(data.toJson());

class OrderDetailsResponseData {
  bool error;
  String message;
  List<OrderDetailsData> data;

  OrderDetailsResponseData({
    required this.error,
    required this.message,
    required this.data,
  });

  factory OrderDetailsResponseData.fromJson(Map<String, dynamic> json) => OrderDetailsResponseData(
    error: json["error"],
    message: json["message"],
    data: List<OrderDetailsData>.from(json["data"].map((x) => OrderDetailsData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class OrderDetailsData {
  int cartId;
  String color;
  int productQty;
  String size;
  int productId;
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

  OrderDetailsData({
    required this.cartId,
    required this.color,
    required this.productQty,
    required this.size,
    required this.productId,
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

  factory OrderDetailsData.fromJson(Map<String, dynamic> json) => OrderDetailsData(
    cartId: json["cartId"]??'',
    color: json["color"]??'',
    productQty: json["product_qty"]??'',
    size: json["size"]??'',
    productId: json["product_Id"]??'',
    id: json["id"]??'',
    catId: json["cat_id"]??'',
    subCatId: json["sub_cat_id"]??'',
    discount: json["discount"]??'',
    offer: json["offer"]??'',
    productTitle: json["product_title"]??'',
    productImage: json["product_image"]??'',
    productPrice: json["product_price"]??'',
    slug: json["slug"]??'',
    productShortDesc: json["product_short_desc"]??'',
    productLongDesc: json["product_long_desc"]??'',
    metaTitleTag: json["meta_title_tag"]??'',
    metaTitleKeywords: json["meta_title_keywords"]??'',
    metaTitleDescription: json["meta_title_description"]??'',
    createdAt: json["created_at"]??'',
    updatedAt: json["updated_at"]??'',
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
