class Mcq {
  String id;
  String title;
  String streamName;
  String pdfUrl;

  Mcq({
    required this.id,
    required this.title,
    required this.streamName,
    required this.pdfUrl,
  });

  factory Mcq.fromJson(Map<String, dynamic> json) {
    return Mcq(
      id: json['_id'],
      title: json['title'],
      streamName: json['streamName'],
      pdfUrl: json['pdfUrl'],
    );
  }
}

class McqResponse {
  String status;
  List<Mcq> mcqs;

  McqResponse({
    required this.status,
    required this.mcqs,
  });

  factory McqResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> mcqsList = json['mcqs'];
    List<Mcq> mcqs = mcqsList.map((item) => Mcq.fromJson(item)).toList();

    return McqResponse(
      status: json['status'],
      mcqs: mcqs,
    );
  }
}
