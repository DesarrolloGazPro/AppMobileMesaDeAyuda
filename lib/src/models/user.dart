
import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int? id;
  String? email;
  String name;
  String lastname;
  String phone;
  String? image;
  String? password;
  bool? isAvailable;
  String? sessionToken;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.email,
    required this.name,
    required this.lastname,
    required this.phone,
    this.image,
    this.password,
     this.isAvailable,
     this.sessionToken,
     this.createdAt,
     this.updatedAt
  });



  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    email: json["email"],
    name: json["name"],
    lastname: json["lastname"],
    phone: json["phone"],
    image: json["image"],
    password: json["password"],
    isAvailable: json["is_available"],
    sessionToken: json["session_token"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "name": name,
    "lastname": lastname,
    "phone": phone,
    "image": image,
    "password": password,
    "is_available": isAvailable,
    "session_token": sessionToken,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
