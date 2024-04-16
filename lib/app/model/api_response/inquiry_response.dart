class InquryResponse {
  bool? success;
  String? data;
  String? message;

  InquryResponse({
    this.success,
    this.data,
    this.message,
  });

  factory InquryResponse.fromJson(Map<String, dynamic> json) => InquryResponse(
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
