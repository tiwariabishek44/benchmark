class MannualResponseModel {
  bool success;
  List<Mannual> data;
  String message;

  MannualResponseModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory MannualResponseModel.fromJson(Map<String, dynamic> json) =>
      MannualResponseModel(
        success: json["success"],
        data: List<Mannual>.from(json["data"].map((x) => Mannual.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class Mannual {
  int id;
  int subjectId;
  String name;
  String description;
  String fileLocation;

  Mannual({
    required this.id,
    required this.subjectId,
    required this.name,
    required this.description,
    required this.fileLocation,
  });

  factory Mannual.fromJson(Map<String, dynamic> json) => Mannual(
        id: json["id"],
        subjectId: json["subjectId"],
        name: json["name"],
        description: json["description"],
        fileLocation: json["fileLocation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subjectId": subjectId,
        "name": name,
        "description": description,
        "fileLocation": fileLocation,
      };
}
