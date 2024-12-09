import 'dart:convert';

List<Fallas> fallasFromJson(String str) => List<Fallas>.from(json.decode(str).map((x) => Fallas.fromJson(x)));

String fallasToJson(List<Fallas> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Fallas {
  int id;
  String falla;
  int prioridad;
  int tiempo;
  int departamentoId;
  int categoriaId;
  int clasificacionId;

  Fallas({
    required this.id,
    required this.falla,
    required this.prioridad,
    required this.tiempo,
    required this.departamentoId,
    required this.categoriaId,
    required this.clasificacionId,
  });

  factory Fallas.fromJson(Map<String, dynamic> json) => Fallas(
    id: json["id"],
    falla: json["falla"],
    prioridad: json["prioridad"],
    tiempo: json["tiempo"],
    departamentoId: json["departamentoID"],
    categoriaId: json["categoriaID"],
    clasificacionId: json["clasificacionID"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "falla": falla,
    "prioridad": prioridad,
    "tiempo": tiempo,
    "departamentoID": departamentoId,
    "categoriaID": categoriaId,
    "clasificacionID": clasificacionId,
  };
}
