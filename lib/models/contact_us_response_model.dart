// To parse this JSON data, do
//
//     final contactUsModel = contactUsModelFromJson(jsonString);

import 'dart:convert';

ContactUsModel contactUsModelFromJson(String str) => ContactUsModel.fromJson(json.decode(str));

String contactUsModelToJson(ContactUsModel data) => json.encode(data.toJson());

class ContactUsModel {
  bool error;
  String message;
  List <ContactUsData> data;

  ContactUsModel({
    required this.error,
    required this.message,
    required this.data,
  });

  factory ContactUsModel.fromJson(Map<String, dynamic> json) => ContactUsModel(
    error: json["error"],
    message: json["message"],
    data: List<ContactUsData>.from(json["data"].map((x) => ContactUsData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ContactUsData {
  int id;
  String title;
  String slug;
  String content;
  String image;

  ContactUsData({
    required this.id,
    required this.title,
    required this.slug,
    required this.content,
    required this.image,
  });

  factory ContactUsData.fromJson(Map<String, dynamic> json) => ContactUsData(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    content: json["content"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "content": content,
    "image": image,
  };
}
