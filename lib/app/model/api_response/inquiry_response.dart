class InquiryResponse {
  List<Inquiry>? courseBuy;

  InquiryResponse({
    this.courseBuy,
  });

  InquiryResponse.fromJson(List<dynamic> json) {
    if (json.isNotEmpty) {
      courseBuy = json.map((e) => Inquiry.fromJson(e)).toList();
    }
  }
}

class Inquiry {
  int? id;
  String? uuid;
  String? userId;
  DateTime? buyDate;
  String? amount;
  String? courseId;
  String? courseName;

  Inquiry({
    this.id,
    this.uuid,
    this.userId,
    this.buyDate,
    this.amount,
    this.courseId,
    this.courseName,
  });

  factory Inquiry.fromJson(Map<String, dynamic> json) => Inquiry(
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
