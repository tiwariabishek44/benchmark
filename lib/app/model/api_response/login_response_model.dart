class LoginResponseModel {
  String msg;
  String tokens;
  UserData userData;

  LoginResponseModel({
    required this.msg,
    required this.tokens,
    required this.userData,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        msg: json["msg"],
        tokens: json["tokens"],
        userData: UserData.fromJson(json["userData"]),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "tokens": tokens,
        "userData": userData.toJson(),
      };
}

class UserData {
  String id;
  String name;
  String email;
  String password;
  String phone;
  String stream;
  String userType;
  bool isVerified;
  String token;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.stream,
    required this.userType,
    required this.isVerified,
    required this.token,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        stream: json["stream"],
        userType: json["userType"],
        isVerified: json["isVerified"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "stream": stream,
        "userType": userType,
        "isVerified": isVerified,
        "token": token,
      };
}
