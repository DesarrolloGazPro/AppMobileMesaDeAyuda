
import 'dart:convert';

SolicitudAtendio solicitudAtendioFromJson(String str) => SolicitudAtendio.fromJson(json.decode(str));

String solicitudAtendioToJson(SolicitudAtendio data) => json.encode(data.toJson());

class SolicitudAtendio {
  String id;
  String estatus;
  String atendio;
  String fecha;
  String hora;

  SolicitudAtendio({
    required this.id,
    required this.estatus,
    required this.atendio,
    required this.fecha,
    required this.hora,
  });

  factory SolicitudAtendio.fromJson(Map<String, dynamic> json) => SolicitudAtendio(
    id: json["id"],
    estatus: json["estatus"],
    atendio: json["atendio"],
    fecha: json["fecha"],
    hora: json["hora"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "estatus": estatus,
    "atendio": atendio,
    "fecha": fecha,
    "hora": hora,
  };
}
