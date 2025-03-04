import 'package:jwt_decoder/jwt_decoder.dart';

class JwtPayload {
  final int iat; // Example: 1738631334,
  final int exp; // Example: 1770167330,
  final String email; // Example: "asd@prueba.com",
  // final String aud; // Example: "www.pinaf.com",
  // final String iss; // Example: "PINAF",
  // final String userId; // Example: 1,
  // final String nombre; // Example: "daniel",
  // final String apellido; // Example: "apellido",
  // final String rol; // Example: "cliente"

  JwtPayload({
    required this.email,
    required this.iat,
    required this.exp,
    // required this.iss,
    // required this.aud,
    // required this.userId,
    // required this.nombre,
    // required this.apellido,
    // required this.rol
  });

  // Método para convertir JSON a objeto Dart
  factory JwtPayload.fromToken(String token) {
    Map<String, dynamic> json = JwtDecoder.decode(token);
    return JwtPayload(
      email: json['sub'],
      iat: json['iat'],
      exp: json['exp'],
      // aud: json['aud'],
      // iss: json['iss'],
      // email: json['email'],
      // rol: json['rol'],
      // apellido: json['apellido'],
      // nombre: json['nombre'],
    );
  }

  // Método para verificar si el token está expirado
  bool isExpired() {
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return exp < now;
  }
}
