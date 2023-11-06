// To parse this JSON data, do
//
//     final getAddressModelResponse = getAddressModelResponseFromJson(jsonString);

import 'dart:convert';

GetAddressModelResponse getAddressModelResponseFromJson(String str) => GetAddressModelResponse.fromJson(json.decode(str));

String getAddressModelResponseToJson(GetAddressModelResponse data) => json.encode(data.toJson());

class GetAddressModelResponse {
  GetAddressModelResponse({
    required this.error,
    required this.message,
    required this.data,
  });

  bool error;
  String message;
  List<GetAddressData> data;

  factory GetAddressModelResponse.fromJson(Map<String, dynamic> json) {
    return GetAddressModelResponse(
      error: json['error'] ?? true,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? List<GetAddressData>.from(
        json['data'].map((x) => GetAddressData.fromJson(x)),
      )
          :[],
    );
  }

  Map<String, dynamic> toJson() => {
    'error': error,
    'message': message,
    'data': List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetAddressData {
  GetAddressData({
    required this.id,
    required this.userId,
    required this.ischeck,
    required this.landmark,
    required this.area,
    required this.city,
    required this.state,
    required this.address,
    required this.pincode,
    required this.mobile,
    required this.name,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String userId;
  int ischeck;
  String landmark;
  String area;
  String city;
  String state;
  String address;
  String pincode;
  String mobile;
  String name;
  dynamic createdAt;
  dynamic updatedAt;

  factory GetAddressData.fromJson(Map<String, dynamic> json) => GetAddressData(
    id: json["id"],
    userId: json["user_id"],
    ischeck: json["ischeck"],
    landmark: json["landmark"] ?? '',
    area: json["area"] ?? '',
    city: json["city"] ?? '',
    state: json["state"] ?? '',
    address: json["address"] ?? '',
    pincode: json["pincode"] ?? '',
    mobile: json["mobile"] ?? '',
    name: json["name"] ?? '',
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "ischeck": ischeck,
    "landmark": landmark,
    "area": area,
    "city": city,
    "state": state,
    "address": address,
    "pincode": pincode,
    "mobile": mobile,
    "name": name,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}


