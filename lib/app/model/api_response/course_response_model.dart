class CourseResponse {
  String id;
  String name;
  String description;
  double price;
  List<Note> notes;

  CourseResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.notes,
  });

  factory CourseResponse.fromJson(Map<String, dynamic> json) => CourseResponse(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        price: json["price"]?.toDouble(),
        notes: List<Note>.from(json["notes"].map((x) => Note.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "price": price,
        "notes": List<dynamic>.from(notes.map((x) => x.toJson())),
      };
}

class Note {
  String title;
  String courseName;
  String pdfUrl;
  String id;

  Note({
    required this.title,
    required this.courseName,
    required this.pdfUrl,
    required this.id,
  });

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        title: json["title"],
        courseName: json["courseName"],
        pdfUrl: json["pdfUrl"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "courseName": courseName,
        "pdfUrl": pdfUrl,
        "_id": id,
      };
}
