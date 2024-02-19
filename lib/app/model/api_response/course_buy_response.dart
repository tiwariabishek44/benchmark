class CourseBuyResponse {
  List<CourseBuy>? courseBuy;

  CourseBuyResponse({
    this.courseBuy,
  });

  CourseBuyResponse.fromJson(List<dynamic> json) {
    if (json.isNotEmpty) {
      courseBuy = json.map((e) => CourseBuy.fromJson(e)).toList();
    }
  }
}

class CourseBuy {
  int? id;
  String? uuid;
  String? userId;
  DateTime? buyDate;
  String? amount;
  String? courseId;
  String? courseName;

  CourseBuy({
    this.id,
    this.uuid,
    this.userId,
    this.buyDate,
    this.amount,
    this.courseId,
    this.courseName,
  });

  factory CourseBuy.fromJson(Map<String, dynamic> json) => CourseBuy(
        id: json['id'],
        uuid: json['uuid'],
        userId: json['userId'],
        buyDate:
            json['buyDate'] != null ? DateTime.parse(json['buyDate']) : null,
        amount: json['amount'],
        courseId: json['courseId'],
        courseName: json['courseName'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'uuid': uuid,
        'userId': userId,
        'buyDate': buyDate?.toIso8601String(),
        'amount': amount,
        'courseId': courseId,
        'courseName': courseName,
      };
}
