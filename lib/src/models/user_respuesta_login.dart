
import 'dart:convert';

UserRespuestaLogin userRespuestaLoginFromJson(String str) => UserRespuestaLogin.fromJson(json.decode(str));

String userRespuestaLoginToJson(UserRespuestaLogin data) => json.encode(data.toJson());

class UserRespuestaLogin {
  Usuarios? usuarios;
  String? token;

  UserRespuestaLogin({
     this.usuarios,
     this.token,
  });

  factory UserRespuestaLogin.fromJson(Map<String, dynamic> json) => UserRespuestaLogin(
    usuarios: json["usuarios"] != null ? Usuarios.fromJson(json["usuarios"]) : null,
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "usuarios": usuarios?.toJson(),
    "token": token,
  };
}

class Usuarios {
  String? nombre;
  String? correo;
  String? usuario;
  String passwword;
  String? image;

  Usuarios({
    required this.nombre,
    required this.correo,
    required this.usuario,
    required this.passwword,
    this.image,
  });

  factory Usuarios.fromJson(Map<String, dynamic> json) => Usuarios(
    nombre: json["nombre"] ?? '',
    correo: json["correo"] ?? '',
    usuario: json["usuario"] ?? '',
    passwword: json["passwword"] ?? '' ,
    image: json["image"] ?? '' ,
  );

  Map<String, dynamic> toJson() => {
    "nombre": nombre,
    "correo": correo,
    "usuario": usuario,
    "passwword": passwword,
    "image": image,
  };
}
