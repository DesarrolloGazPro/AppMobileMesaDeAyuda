import 'dart:convert';

UserLogin userFromJson(String str) => UserLogin.fromJson(json.decode(str));

String userToJson(UserLogin data) => json.encode(data.toJson());

class UserLogin {
  String usuario;
  String contrasena;
  UserLogin({
    required this.usuario,
    required this.contrasena,
  });

  factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(
    usuario: json["usuario"],
    contrasena: json["contrasena"],
  );

  Map<String, dynamic> toJson() => {
    "usuario": usuario,
    "contrasena": contrasena,
  };
}