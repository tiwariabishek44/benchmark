class ChangePasswordResponse {
  String message;
  bool success;

  ChangePasswordResponse({
    required this.message,
    required this.success,
  });

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) =>
      ChangePasswordResponse(
        message: json["message"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
      };
}
