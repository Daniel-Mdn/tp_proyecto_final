import 'dart:convert';

import 'package:tp_proyecto_final/model/user_model.dart';

List<ClientModel> clientModelFromJson(List<dynamic> list) {
  return List<ClientModel>.from(list.map((x) {
    return ClientModel.fromJson(x);
  }));
}

String clientModelToJson(List<ClientModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClientModel extends UserModel {
  ClientModel(
      {required super.id,
      required super.nombre,
      required super.apellido,
      required super.email,
      required super.sexo,
      required super.fechaNacimiento,
      required super.telefono,
      required super.role,
      required this.antecedentes,
      required this.afecciones,
      super.password});

  final String antecedentes;
  final String afecciones;

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
        id: json["id"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        email: json["username"],
        sexo: json["sexo"] == 'femenino' ? Genero.femenino : Genero.masculino,
        fechaNacimiento: json["fecha_nacimiento"] is String
            ? DateTime.parse(json["fecha_nacimiento"])
            : json["fecha_nacimiento"],
        telefono: json["telefono"],
        role: TipoUsuario.values.firstWhere(
            (val) => val.toString() == json["role"],
            orElse: () => TipoUsuario.cliente),
        antecedentes: json['antecedentes'],
        afecciones: json['afecciones']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "nombre": nombre,
      "apellido": apellido,
      "username": email,
      "sexo": sexo.name,
      "fecha_nacimiento": fechaNacimiento.toIso8601String().split('T').first,
      "telefono": telefono,
      "role": role.name,
      "password": password,
      "antecedentes": antecedentes,
      "afecciones": afecciones,
    };
  }
}
