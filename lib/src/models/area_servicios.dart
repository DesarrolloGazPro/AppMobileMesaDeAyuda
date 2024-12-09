
import 'dart:convert';

List<AreaServicios> areaServiciosFromJson(String str) => List<AreaServicios>.from(json.decode(str).map((x) => AreaServicios.fromJson(x)));

String areaServiciosToJson(List<AreaServicios> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AreaServicios {
  int id;
  String clave;

  AreaServicios({
    required this.id,
    required this.clave,
  });

  factory AreaServicios.fromJson(Map<String, dynamic> json) => AreaServicios(
    id: json["id"],
    clave: json["clave"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "clave": clave,
  };
}
