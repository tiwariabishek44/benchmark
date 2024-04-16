// To parse this JSON data, do
//
//     final registerPhase1Response = registerPhase1ResponseFromJson(jsonString);

import 'dart:convert';

class RegisterResponseModel {
  bool? success;
  Data? data;
  String? message;

  RegisterResponseModel.RegisterPhase1Response({
    this.success,
    this.data,
    this.message,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      RegisterResponseModel.RegisterPhase1Response(
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
  String? otpToken;

  Data({
    this.otpToken,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        otpToken: json["otpToken"],
      );

  Map<String, dynamic> toJson() => {
        "otpToken": otpToken,
      };
}
