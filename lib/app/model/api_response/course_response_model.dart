import 'package:benchmark/app/model/api_response/my_course_response.dart';

class CourseApiResponse {
  bool? success;
  List<Datum> data;
  String? message;

  CourseApiResponse({
    this.success,
    required this.data,
    this.message,
  });

  factory CourseApiResponse.fromJson(Map<String, dynamic> json) =>
      CourseApiResponse(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}
