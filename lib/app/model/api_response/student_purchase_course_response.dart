// To parse this JSON data, do
//
//     final userResponseModel = userResponseModelFromJson(jsonString);

class StudentPurchaseCourseResponse {
  int id;
  String name;
  String mobileNumber;
  String password;
  dynamic email;
  dynamic address;

  StudentPurchaseCourseResponse({
    required this.id,
    required this.name,
    required this.mobileNumber,
    required this.password,
    required this.email,
    required this.address,
  });

  factory StudentPurchaseCourseResponse.fromJson(Map<String, dynamic> json) =>
      StudentPurchaseCourseResponse(
        id: json["id"],
        name: json["name"],
        mobileNumber: json["mobileNumber"],
        password: json["password"],
        email: json["email"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobileNumber": mobileNumber,
        "password": password,
        "email": email,
        "address": address,
      };
}
