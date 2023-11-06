// To parse this JSON data, do
//
//     final getBannerModel = getBannerModelFromJson(jsonString);

import 'dart:convert';

GetBannerModel getBannerModelFromJson(String str) => GetBannerModel.fromJson(json.decode(str));

String getBannerModelToJson(GetBannerModel data) => json.encode(data.toJson());

class GetBannerModel {
  bool error;
  String message;
  List<BannerData> banner;

  GetBannerModel({
    required this.error,
    required this.message,
    required this.banner,
  });

  factory GetBannerModel.fromJson(Map<String, dynamic> json) => GetBannerModel(
    error: json["error"],
    message: json["message"],
    banner: List<BannerData>.from(json["banner"].map((x) => BannerData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "banner": List<dynamic>.from(banner.map((x) => x.toJson())),
  };
}

class BannerData {
  int id;
  String bannerImage;
  int status;
  String createAt;
  String updateAt;

  BannerData({
    required this.id,
    required this.bannerImage,
    required this.status,
    required this.createAt,
    required this.updateAt,
  });

  factory BannerData.fromJson(Map<String, dynamic> json) => BannerData(
    id: json["id"],
    bannerImage: json["banner_image"],
    status: json["status"],
    createAt: json["create_at"],
    updateAt: json["update_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "banner_image": bannerImage,
    "status": status,
    "create_at": createAt,
    "update_at": updateAt,
  };
}
