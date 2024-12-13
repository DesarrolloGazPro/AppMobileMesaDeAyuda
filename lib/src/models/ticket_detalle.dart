import 'dart:convert';

TicketDetalle ticketDetalleFromJson(String str) => TicketDetalle.fromJson(json.decode(str));

String ticketDetalleToJson(TicketDetalle data) => json.encode(data.toJson());

class TicketDetalle {
  List<Ticket> tickets;
  List<TicketsMensaje> ticketsMensajes;
  List<ArchivosTicket> archivosTickets;

  TicketDetalle({
    required this.tickets,
    required this.ticketsMensajes,
    required this.archivosTickets,
  });

  factory TicketDetalle.fromJson(Map<String, dynamic> json) => TicketDetalle(
    tickets: List<Ticket>.from(json["tickets"]?.map((x) => Ticket.fromJson(x)) ?? []),
    ticketsMensajes: List<TicketsMensaje>.from(json["ticketsMensajes"]?.map((x) => TicketsMensaje.fromJson(x)) ?? []),
    archivosTickets: List<ArchivosTicket>.from(json["archivosTickets"]?.map((x) => ArchivosTicket.fromJson(x)) ?? []),
  );

  Map<String, dynamic> toJson() => {
    "tickets": List<dynamic>.from(tickets.map((x) => x.toJson())),
    "ticketsMensajes": List<dynamic>.from(ticketsMensajes.map((x) => x.toJson())),
    "archivosTickets": List<dynamic>.from(archivosTickets.map((x) => x.toJson())),
  };
}

class ArchivosTicket {
  int id;
  String archivo;
  String archivo_nombre;  // Campo opcional
  int ticket_id;
  int ticket_mensaje_id;

  ArchivosTicket({
    required this.id,
    required this.archivo,
    required this.archivo_nombre,  // Opcional
    required this.ticket_id,
    required this.ticket_mensaje_id,
  });

  factory ArchivosTicket.fromJson(Map<String, dynamic> json) => ArchivosTicket(
    id: json["id"] ?? 0,  // Valor por defecto si es null
    archivo: json["archivo"] ?? "",  // Valor por defecto si es null
    archivo_nombre: json["archivo_nombre"],  // Puede ser null o String
    ticket_id: json["ticket_id"] ?? 0,  // Valor por defecto si es null
    ticket_mensaje_id: json["ticket_mensaje_id"] ?? 0,  // Valor por defecto si es null
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "archivo": archivo,
    "archivo_nombre": archivo_nombre,
    "ticket_id": ticket_id,
    "ticket_mensaje_id": ticket_mensaje_id,
  };
}

class Ticket {
  int id;
  String clave;
  String estatus;
  String servicio;
  String falla;
  String prioridad;
  String asunto;
  String mensaje;
  String usuario;
  String reabierto;
  String condicion;
  String nivel;
  String atendio;
  String fecha_atendido;
  String fecha_creado;
  String tiempo_respuesta;
  String solicitud_reabrir;

  Ticket({
    required this.id,
    required this.clave,
    required this.estatus,
    required this.servicio,
    required this.falla,
    required this.prioridad,
    required this.asunto,
    required this.mensaje,
    required this.usuario,
    required this.reabierto,
    required this.condicion,
    required this.nivel,
    required this.atendio,
    required this.fecha_atendido,
    required this.fecha_creado,
    required this.tiempo_respuesta,
    required this.solicitud_reabrir
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
    id: json["id"] ?? 0,
    clave: json["clave"] ?? "",
    estatus: json["estatus"] ?? "",
    servicio: json["servicio"] ?? "",
    falla: json["falla"] ?? "",
    prioridad: json["prioridad"] ?? "",
    asunto: json["asunto"] ?? "",
    mensaje: json["mensaje"] ?? "",
    usuario: json["usuario"] ?? "",
    reabierto: json["reabierto"] ?? "",
    condicion: json["condicion"] ?? "",
    nivel: json["nivel"] ?? "",
    atendio: json["atendio"] ?? "",
    fecha_atendido: json["fecha_atendido"] ?? "",
    fecha_creado: json["fecha_creado"] ?? "",
    tiempo_respuesta: json["tiempo_respuesta"] ?? "",
    solicitud_reabrir: json["solicitud_reabrir"] ?? "",

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "clave": clave,
    "estatus": estatus,
    "servicio": servicio,
    "falla": falla,
    "prioridad": prioridad,
    "asunto": asunto,
    "mensaje": mensaje,
    "usuario": usuario,
    "reabierto": reabierto,
    "condicion": condicion,
    "nivel": nivel,
    "atendio": atendio,
    "fecha_atendido": fecha_atendido,
    "fecha_creado": fecha_creado,
    "tiempo_respuesta": tiempo_respuesta,
    "solicitud_reabrir": solicitud_reabrir,
  };
}

class TicketsMensaje {
  int id;
  String mensaje;
  DateTime fecha_creado;
  int ticket_id;
  String esMensajeSoporte;
  String usuario;
  int usuario_id;
  String usuario_nombre;

  TicketsMensaje({
    required this.id,
    required this.mensaje,
    required this.fecha_creado,
    required this.ticket_id,
    required this.esMensajeSoporte,
    required this.usuario,
    required this.usuario_id,
    required this.usuario_nombre,
  });

  factory TicketsMensaje.fromJson(Map<String, dynamic> json) => TicketsMensaje(
    id: json["id"] ?? 0,  // Valor por defecto si es null
    mensaje: json["mensaje"] ?? "",  // Valor por defecto si es null
    fecha_creado: json["fecha_creado"] != null ? DateTime.parse(json["fecha_creado"]) : DateTime.now(),  // Fecha por defecto si es null
    ticket_id: json["ticket_id"] ?? 0,  // Valor por defecto si es null
    esMensajeSoporte: json["esMensajeSoporte"] ?? "",  // Valor por defecto si es null
    usuario: json["usuario"] ?? "",  // Valor por defecto si es null
    usuario_id: json["usuario_id"] ?? 0,
    usuario_nombre: json["usuario_nombre"] ?? "",// Valor por defecto si es null
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "mensaje": mensaje,
    "fecha_creado": fecha_creado.toIso8601String(),
    "ticket_id": ticket_id,
    "esMensajeSoporte": esMensajeSoporte,
    "usuario": usuario,
    "usuario_id": usuario_id,
    "usuario_nombre": usuario_nombre,
  };
}
