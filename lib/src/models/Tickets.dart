
import 'dart:convert';

List<Tickets> ticketsFromJson(String str) => List<Tickets>.from(json.decode(str).map((x) => Tickets.fromJson(x)));

String ticketsToJson(List<Tickets> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tickets {
  int id;
  String clave;
  String falla;

  Tickets({
    required this.id,
    required this.clave,
    required this.falla,
  });

  factory Tickets.fromJson(Map<String, dynamic> json) => Tickets(
    id: json["id"],
    clave: json["clave"],
    falla: json["falla"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "clave": clave,
    "falla": falla,
  };
}
