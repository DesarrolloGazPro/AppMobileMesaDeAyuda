
import 'dart:convert';

List<Personal> personalFromJson(String str) => List<Personal>.from(json.decode(str).map((x) => Personal.fromJson(x)));

String personalToJson(List<Personal> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Personal {
  String nombre;
  String departamento;

  Personal({
    required this.nombre,
    required this.departamento,
  });

  factory Personal.fromJson(Map<String, dynamic> json) => Personal(
    nombre: json["nombre"],
    departamento: json["departamento"],
  );

  Map<String, dynamic> toJson() => {
    "nombre": nombre,
    "departamento": departamento,
  };
}
