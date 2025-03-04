import 'package:dio/dio.dart';
import 'auth_service.dart'; // Tu servicio de autenticación

class AuthInterceptor extends Interceptor {
  final AuthService authService;
  AuthInterceptor({required this.authService});

  @override
  void onRequest(options, handler) async {
    final token = await authService.getToken();

    if (token != null) {
      options.headers["Authorization"] = "Bearer $token";
    }
    return handler.next(options);
  }

  @override
  void onResponse(response, handler) {
    return handler.next(response);
  }

  @override
  void onError(error, handler) {
    // Manejo de errores
    return handler.next(error);
  }
}
