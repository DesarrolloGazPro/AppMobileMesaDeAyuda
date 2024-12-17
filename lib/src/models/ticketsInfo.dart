
import 'dart:convert';

List<TicketsInfo> ticketsFromJson(String str) => List<TicketsInfo>.from(json.decode(str).map((x) => TicketsInfo.fromJson(x)));

String ticketsToJson(List<TicketsInfo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TicketsInfo {
  int id;
  String clave;
  String falla;
  String estatus;
  String tiempo_respuesta;
  String usuario_sucursal_nombre;
  String usuario_asignado;
  TicketsInfo({
    required this.id,
    required this.clave,
    required this.falla,
    required this.estatus,
    required this.tiempo_respuesta,
    required this.usuario_sucursal_nombre,
    required this.usuario_asignado,
  });

  factory TicketsInfo.fromJson(Map<String, dynamic> json) => TicketsInfo(
    id: json["id"],
    clave: json["clave"],
    falla: json["falla"],
    estatus: json["estatus"],
    tiempo_respuesta: json["tiempo_respuesta"],
    usuario_sucursal_nombre: json["usuario_sucursal_nombre"],
    usuario_asignado: json["usuario_asignado"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "clave": clave,
    "falla": falla,
    "estatus": estatus,
    "tiempo_respuesta": tiempo_respuesta,
    "usuario_sucursal_nombre": usuario_sucursal_nombre,
    "usuario_asignado": usuario_asignado,
  };
}
