
import 'dart:convert';

List<TicketsInfo> ticketsFromJson(String str) => List<TicketsInfo>.from(json.decode(str).map((x) => TicketsInfo.fromJson(x)));

String ticketsToJson(List<TicketsInfo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TicketsInfo {
  int id;
  String clave;
  String falla;

  TicketsInfo({
    required this.id,
    required this.clave,
    required this.falla,
  });

  factory TicketsInfo.fromJson(Map<String, dynamic> json) => TicketsInfo(
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
