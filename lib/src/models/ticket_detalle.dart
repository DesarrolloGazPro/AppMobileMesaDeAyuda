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
  String? archivoNombre;  // Campo opcional
  int ticketId;
  int ticketMensajeId;

  ArchivosTicket({
    required this.id,
    required this.archivo,
    this.archivoNombre,  // Opcional
    required this.ticketId,
    required this.ticketMensajeId,
  });

  factory ArchivosTicket.fromJson(Map<String, dynamic> json) => ArchivosTicket(
    id: json["id"] ?? 0,  // Valor por defecto si es null
    archivo: json["archivo"] ?? "",  // Valor por defecto si es null
    archivoNombre: json["archivoNombre"],  // Puede ser null o String
    ticketId: json["ticketId"] ?? 0,  // Valor por defecto si es null
    ticketMensajeId: json["ticketMensajeId"] ?? 0,  // Valor por defecto si es null
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "archivo": archivo,
    "archivoNombre": archivoNombre,
    "ticketId": ticketId,
    "ticketMensajeId": ticketMensajeId,
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
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
    id: json["id"] ?? 0,  // Valor por defecto si es null
    clave: json["clave"] ?? "",  // Valor por defecto si es null
    estatus: json["estatus"] ?? "",  // Valor por defecto si es null
    servicio: json["servicio"] ?? "",  // Valor por defecto si es null
    falla: json["falla"] ?? "",  // Valor por defecto si es null
    prioridad: json["prioridad"] ?? "",  // Valor por defecto si es null
    asunto: json["asunto"] ?? "",  // Valor por defecto si es null
    mensaje: json["mensaje"] ?? "",  // Valor por defecto si es null
    usuario: json["usuario"] ?? "",  // Valor por defecto si es null
    reabierto: json["reabierto"] ?? "",  // Valor por defecto si es null
    condicion: json["condicion"] ?? "",  // Valor por defecto si es null
    nivel: json["nivel"] ?? "",  // Valor por defecto si es null
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
  };
}

class TicketsMensaje {
  int id;
  String mensaje;
  DateTime fechaCreado;
  int ticketId;
  String esMensajeSoporte;
  String usuario;
  int usuarioId;

  TicketsMensaje({
    required this.id,
    required this.mensaje,
    required this.fechaCreado,
    required this.ticketId,
    required this.esMensajeSoporte,
    required this.usuario,
    required this.usuarioId,
  });

  factory TicketsMensaje.fromJson(Map<String, dynamic> json) => TicketsMensaje(
    id: json["id"] ?? 0,  // Valor por defecto si es null
    mensaje: json["mensaje"] ?? "",  // Valor por defecto si es null
    fechaCreado: json["fechaCreado"] != null ? DateTime.parse(json["fechaCreado"]) : DateTime.now(),  // Fecha por defecto si es null
    ticketId: json["ticketId"] ?? 0,  // Valor por defecto si es null
    esMensajeSoporte: json["esMensajeSoporte"] ?? "",  // Valor por defecto si es null
    usuario: json["usuario"] ?? "",  // Valor por defecto si es null
    usuarioId: json["usuarioId"] ?? 0,  // Valor por defecto si es null
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "mensaje": mensaje,
    "fechaCreado": fechaCreado.toIso8601String(),
    "ticketId": ticketId,
    "esMensajeSoporte": esMensajeSoporte,
    "usuario": usuario,
    "usuarioId": usuarioId,
  };
}
