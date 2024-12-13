
import 'dart:convert';

List<Prioridad> prioridadFromJson(String str) => List<Prioridad>.from(json.decode(str).map((x) => Prioridad.fromJson(x)));

String prioridadToJson(List<Prioridad> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Prioridad {
  int id;
  String clave;
  String descripcion;
  String tiempoRespuesta;

  Prioridad({
    required this.id,
    required this.clave,
    required this.descripcion,
    required this.tiempoRespuesta,
  });

  factory Prioridad.fromJson(Map<String, dynamic> json) => Prioridad(
    id: json["id"],
    clave: json["clave"],
    descripcion: json["descripcion"],
    tiempoRespuesta: json["tiempoRespuesta"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "clave": clave,
    "descripcion": descripcion,
    "tiempoRespuesta": tiempoRespuesta,
  };
}
