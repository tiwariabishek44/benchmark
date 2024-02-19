class RegisterResponseModel {
  String name;
  String email;
  String password;
  String phone;
  String userType;
  bool isVerified;
  String token;
  String stream;
  String id;

  RegisterResponseModel({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.userType,
    required this.isVerified,
    required this.token,
    required this.stream,
    required this.id,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      RegisterResponseModel(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        userType: json["userType"],
        isVerified: json["isVerified"],
        token: json["token"],
        stream: json["stream"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "userType": userType,
        "isVerified": isVerified,
        "token": token,
        "stream": stream,
        "_id": id,
      };
}
