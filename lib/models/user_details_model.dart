// To parse this JSON data, do
//
//     final getUserDetailsResponse = getUserDetailsResponseFromJson(jsonString);

import 'dart:convert';

GetUserDetailsResponse getUserDetailsResponseFromJson(String str) => GetUserDetailsResponse.fromJson(json.decode(str));

String getUserDetailsResponseToJson(GetUserDetailsResponse data) => json.encode(data.toJson());

class GetUserDetailsResponse {
  bool error;
  String message;
  List<UserDetailsData> data;

  GetUserDetailsResponse({
    required this.error,
    required this.message,
    required this.data,
  });

  factory GetUserDetailsResponse.fromJson(Map<String, dynamic> json) => GetUserDetailsResponse(
    error: json["error"],
    message: json["message"],
    data: List<UserDetailsData>.from(json["data"].map((x) => UserDetailsData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class UserDetailsData {
  int id;
  String name;
  String mobile;
  String email;
  String profileImage;
  String address;
  String pinCode;
  dynamic emailVerifiedAt;
  dynamic twoFactorConfirmedAt;
  dynamic currentTeamId;
  dynamic profilePhotoPath;
  DateTime createdAt;
  DateTime updatedAt;
  String profilePhotoUrl;

  UserDetailsData({
    required this.id,
    required this.name,
    required this.mobile,
    required this.email,
    required this.profileImage,
    required this.address,
    required this.pinCode,
    required this.emailVerifiedAt,
    required this.twoFactorConfirmedAt,
    required this.currentTeamId,
    required this.profilePhotoPath,
    required this.createdAt,
    required this.updatedAt,
    required this.profilePhotoUrl,
  });

  factory UserDetailsData.fromJson(Map<String, dynamic> json) => UserDetailsData(
    id: json["id"]??'',
    name: json["name"] ?? '',
    mobile: json["mobile"] ?? '',
    email: json["email"] ?? '',
    profileImage: json["profile_image"] ?? '',
    address: json["address"] ?? '',
    pinCode: json["pin_code"] ?? '',
    emailVerifiedAt: json["email_verified_at"]??'',
    twoFactorConfirmedAt: json["two_factor_confirmed_at"]??'',
    currentTeamId: json["current_team_id"] ??'',
    profilePhotoPath: json["profile_photo_path"] ?? '',
    createdAt: json["created_at"] != null
        ? DateTime.parse(json["created_at"])
        : DateTime.now(),
    updatedAt: json["updated_at"] != null
        ? DateTime.parse(json["updated_at"])
        : DateTime.now(),
    profilePhotoUrl: json["profile_photo_url"] ?? '',
  );

Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "mobile": mobile,
    "email": email,
    "profile_image": profileImage,
    "address": address,
    "pin_code": pinCode,
    "email_verified_at": emailVerifiedAt,
    "two_factor_confirmed_at": twoFactorConfirmedAt,
    "current_team_id": currentTeamId,
    "profile_photo_path": profilePhotoPath,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "profile_photo_url": profilePhotoUrl,
  };
}
