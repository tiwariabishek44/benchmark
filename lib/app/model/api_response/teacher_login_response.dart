class TeacherLoginResponse {
  bool? success;
  Data? data;
  String? message;

  TeacherLoginResponse({
    this.success,
    this.data,
    this.message,
  });

  factory TeacherLoginResponse.fromJson(Map<String, dynamic> json) =>
      TeacherLoginResponse(
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
  dynamic loginSessionHash;
  bool? verified;

  Data({
    this.accessToken,
    this.refreshToken,
    this.loginSessionHash,
    this.verified,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
        loginSessionHash: json["loginSessionHash"],
        verified: json["verified"],
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        "loginSessionHash": loginSessionHash,
        "verified": verified,
      };
}
