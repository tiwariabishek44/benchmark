// To parse this JSON data, do
//
//     final firstLoginResponse = firstLoginResponseFromJson(jsonString);

import 'dart:convert';

class FirstLoginResponse {
  bool? success;
  String? data;
  String? message;

  FirstLoginResponse({
    this.success,
    this.data,
    this.message,
  });

  factory FirstLoginResponse.fromJson(Map<String, dynamic> json) =>
      FirstLoginResponse(
        success: json["success"],
        data: json["data"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data,
        "message": message,
      };
}
