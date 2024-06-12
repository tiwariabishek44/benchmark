
class LoginApiResponse {
  bool success;
  Data data;
  String message;

  LoginApiResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory LoginApiResponse.fromJson(Map<String, dynamic> json) =>
      LoginApiResponse(
        success: json["success"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
      };
}

class Data {
  String accessToken;
  String refreshToken;
  String loginSessionHash;
  bool student;
  bool verified;

  Data({
    required this.accessToken,
    required this.refreshToken,
    required this.loginSessionHash,
    required this.student,
    required this.verified,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
        loginSessionHash: json["loginSessionHash"],
        student: json["student"],
        verified: json["verified"],
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        "loginSessionHash": loginSessionHash,
        "student": student,
        "verified": verified,
      };
}
