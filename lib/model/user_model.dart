import 'dart:convert';

List<UserModel> userModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  UserModel({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.email,
    required this.genero,
    required this.fechaNacimiento,
    required this.telefono,
    required this.rol,
  });

  final int id;
  final String nombre;
  final String apellido;
  final String email;
  final Genero genero;
  final DateTime fechaNacimiento;
  final String telefono;
  final TipoUsuario rol;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        email: json["email"],
        genero: json["genero"],
        fechaNacimiento: json["fechaNacimiento"],
        telefono: json["telefono"],
        rol: json["rol"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "apellido": apellido,
        "email": email,
        "genero": genero,
        "fechaNacimiento": fechaNacimiento,
        "telefono": telefono,
        "rol": rol,
      };
}

enum Genero { masculino, femenino }

enum TipoUsuario { cliente, entrenador }
