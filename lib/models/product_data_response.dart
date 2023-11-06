// To parse this JSON data, do
//
//     final getProductModel = getProductModelFromJson(jsonString);

import 'dart:convert';

GetProductModel getProductModelFromJson(String str) => GetProductModel.fromJson(json.decode(str));

String getProductModelToJson(GetProductModel data) => json.encode(data.toJson());

class GetProductModel {
  bool error;
  String status;
  List<ProductData> products;

  GetProductModel({
    required this.error,
    required this.status,
    required this.products,
  });

  factory GetProductModel.fromJson(Map<String, dynamic> json) => GetProductModel(
    error: json["error"],
    status: json["status"],
    products: List<ProductData>.from(json["products"].map((x) => ProductData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "status": status,
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

class ProductData {
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
  AtedAt createdAt;
  AtedAt updatedAt;
  bool isFavorite;

  ProductData({
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
    this.isFavorite = false,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
    id: json["id"] ?? 0,
    catId: json["cat_id"] ?? 0,
    subCatId: json["sub_cat_id"] ?? 0,
    discount: json["discount"] ?? 0,
    offer: json["offer"] ?? '',
    productTitle: json["product_title"] ?? '',
    productImage: json["product_image"] ?? '',
    productPrice: json["product_price"] ?? '',
    slug: json["slug"] ?? '',
    productShortDesc: json["product_short_desc"] ?? '',
    productLongDesc: json["product_long_desc"] ?? '',
    metaTitleTag: json["meta_title_tag"] ?? '',
    metaTitleKeywords: json["meta_title_keywords"] ?? '',
    metaTitleDescription: json["meta_title_description"] ?? '',
    createdAt: atedAtValues.map[json["created_at"]] ?? AtedAt.THE_0000011130_T00_0000000000_Z,
    updatedAt: atedAtValues.map[json["updated_at"]] ?? AtedAt.THE_0000011130_T00_0000000000_Z,
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
    "created_at": atedAtValues.reverse[createdAt],
    "updated_at": atedAtValues.reverse[updatedAt],
  };
}

enum AtedAt {
  THE_0000011130_T00_0000000000_Z
}

final atedAtValues = EnumValues({
  "-000001-11-30T00:00:00.000000Z": AtedAt.THE_0000011130_T00_0000000000_Z
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
