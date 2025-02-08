import 'package:dio/dio.dart';
import 'auth_service.dart'; // Tu servicio de autenticación

class AuthInterceptor {
  final Dio dio = Dio();
  final AuthService authService;

  AuthInterceptor({required this.authService}) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await authService.getToken();
          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (error, handler) {
          // Manejo de errores
          return handler.next(error);
        },
      ),
    );
  }
}
