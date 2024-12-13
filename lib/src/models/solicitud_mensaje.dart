import 'dart:convert';

SolicitudMensaje solicitudAtendioFromJson(String str) => SolicitudMensaje.fromJson(json.decode(str));

String solicitudAtendioToJson(SolicitudMensaje data) => json.encode(data.toJson());

class SolicitudMensaje{

  String mensaje;
  String fecha_creado;
  String ticket_id;
  String esMensajeSoporte;
  String usuario;
  String usuario_id;
  String usuario_nombre;
  String archivo;
  String archivo_nombre;

  SolicitudMensaje({
    required this.mensaje,
    required this.fecha_creado,
    required this.ticket_id,
    required this.esMensajeSoporte,
    required this.usuario,
    required this.usuario_id,
    required this.usuario_nombre,
    required this.archivo,
    required this.archivo_nombre,

  });

  factory SolicitudMensaje.fromJson(Map<String, dynamic> json) => SolicitudMensaje(

    mensaje: json["mensaje"] ?? "",
    fecha_creado: json["fecha_creado"] ?? "",  // Fecha por defecto si es null
    ticket_id: json["ticket_id"] ?? 0,
    esMensajeSoporte: json["esMensajeSoporte"] ?? "",
    usuario: json["usuario"] ?? "",
    usuario_id: json["usuario_id"] ?? 0,
    usuario_nombre: json["usuario_nombre"] ?? "",
    archivo: json["archivo"] ?? "",
    archivo_nombre: json["archivo_nombre"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "mensaje": mensaje,
    "fecha_creado": fecha_creado,
    "ticket_id": ticket_id,
    "esMensajeSoporte": esMensajeSoporte,
    "usuario": usuario,
    "usuario_id": usuario_id,
    "usuario_nombre": usuario_nombre,
    "archivo": archivo,
    "archivo_nombre": archivo_nombre,
  };
}