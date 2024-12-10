import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuarios? usuarios;
  String? token;

  Usuario({
     this.usuarios,
     this.token,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
    usuarios: Usuarios.fromJson(json["usuarios"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "usuarios": usuarios?.toJson(),
    "token": token,
  };
}

class Usuarios {
  int id;
  int empleadoId;
  String usuario;
  String nombre;
  dynamic contrasena;
  String correo;
  String estatus;
  String departamentoClave;
  String perfilClave;
  String depto_biotime;

  Usuarios({
    required this.id,
    required this.empleadoId,
    required this.usuario,
    required this.nombre,
    required this.contrasena,
    required this.correo,
    required this.estatus,
    required this.departamentoClave,
    required this.perfilClave,
    required this.depto_biotime,
  });

  factory Usuarios.fromJson(Map<String, dynamic> json) => Usuarios(
    id: json["id"],
    empleadoId: json["empleadoID"],
    usuario: json["usuario"],
    nombre: json["nombre"],
    contrasena: json["contrasena"],
    correo: json["correo"],
    estatus: json["estatus"],
    departamentoClave: json["departamento_clave"],
    perfilClave: json["perfil_clave"],
    depto_biotime: json["depto_biotime"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "empleadoID": empleadoId,
    "usuario": usuario,
    "nombre": nombre,
    "contrasena": contrasena,
    "correo": correo,
    "estatus": estatus,
    "departamento_clave": departamentoClave,
    "perfil_clave": perfilClave,
    "depto_biotime": depto_biotime,
  };
}
