class MyCourseResponse {
  bool success;
  List<Datum> data;
  String message;

  MyCourseResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory MyCourseResponse.fromJson(Map<String, dynamic> json) =>
      MyCourseResponse(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class Datum {
  int id;
  String grade;
  String subject;
  String slug;
  String stream;
  String price;

  Datum({
    required this.id,
    required this.grade,
    required this.subject,
    required this.slug,
    required this.stream,
    required this.price,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        grade: json["grade"],
        subject: json["subject"],
        slug: json["slug"],
        stream: json["stream"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "grade": grade,
        "subject": subject,
        "slug": slug,
        "stream": stream,
        "price": price,
      };
}
