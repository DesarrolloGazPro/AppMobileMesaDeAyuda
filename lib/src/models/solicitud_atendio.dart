import 'dart:convert';

SolicitudAtendio solicitudAtendioFromJson(String str) => SolicitudAtendio.fromJson(json.decode(str));

String solicitudAtendioToJson(SolicitudAtendio data) => json.encode(data.toJson());

class SolicitudAtendio {

  String id;
  String estatus;
  String atendio;
  String fecha;
  String hora;
  String fechacreado;
  String tiemporespuesta;
  String solicitudreabrir;
  String reasignarticket;
  String tiempoFalla;
  String servicio;
  String falla;
  String prioridad;
  String usuarioasignado;

  SolicitudAtendio({
    required this.id,
    required this.estatus,
    required this.atendio,
    required this.fecha,
    required this.hora,
    required this.fechacreado,
    required this.tiemporespuesta,
    required this.solicitudreabrir,
    required this.reasignarticket,
    required this.tiempoFalla,
    required this.servicio,
    required this.falla,
    required this.prioridad,
    required this.usuarioasignado,
  });

  factory SolicitudAtendio.fromJson(Map<String, dynamic> json) => SolicitudAtendio(
    id: json["id"],
    estatus: json["estatus"],
    atendio: json["atendio"],
    fecha: json["fecha"],
    hora: json["hora"],
    fechacreado: json["fechacreado"],
    tiemporespuesta: json["tiemporespuesta"],
    solicitudreabrir: json["solicitudreabrir"],
    reasignarticket: json["reasignarticket"],
    tiempoFalla: json["tiempoFalla"],
    servicio: json["servicio"],
    falla: json["falla"],
    prioridad: json["prioridad"],
    usuarioasignado: json["usuarioasignado"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "estatus": estatus,
    "atendio": atendio,
    "fecha": fecha,
    "hora": hora,
    "fechacreado": fechacreado,
    "tiemporespuesta": tiemporespuesta,
    "solicitudreabrir": solicitudreabrir,
    "reasignarticket": reasignarticket,
    "tiempoFalla": tiempoFalla,
    "servicio": servicio,
    "falla": falla,
    "prioridad": prioridad,
    "usuarioasignado": usuarioasignado,
  };
}
