// To parse this JSON data, do
//
//     final secondLoginResponse = secondLoginResponseFromJson(jsonString);

import 'dart:convert';

class LoginApiResponse {
  bool? success;
  Data? data;
  String? message;

  LoginApiResponse({
    this.success,
    this.data,
    this.message,
  });

  factory LoginApiResponse.fromJson(Map<String, dynamic> json) =>
      LoginApiResponse(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "message": message,
      };
}

class Data {
  String? accessToken;
  String? refreshToken;
  String? loginSessionHash;

  Data({
    this.accessToken,
    this.refreshToken,
    this.loginSessionHash,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
        loginSessionHash: json["loginSessionHash"],
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        "loginSessionHash": loginSessionHash,
      };
}
