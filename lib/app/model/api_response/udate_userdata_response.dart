class UdpateUserDataResponse {
  String? success;

  UdpateUserDataResponse({
    this.success,
  });

  factory UdpateUserDataResponse.fromJson(Map<String, dynamic> json) =>
      UdpateUserDataResponse(
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
      };
}
