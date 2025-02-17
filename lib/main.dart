import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tp_proyecto_final/helpers/app_material_theme.dart';
import 'package:tp_proyecto_final/screens/home_page.dart';
import 'package:tp_proyecto_final/screens/login_page.dart';
import 'package:tp_proyecto_final/screens/managments_page.dart';
import 'package:tp_proyecto_final/services/auth_service.dart';
import 'package:tp_proyecto_final/services/storage_service.dart';

// Variable global para controlar si ya se mostró la pantalla de bienvenida
bool _splashShown = false;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // Inicializa el router con redirección según el estado de sesión
  final GoRouter _router = GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      print('state.matchedLocation');
      print(state.matchedLocation);
      if (!_splashShown && state.matchedLocation != '/splash') {
        return '/splash';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => SplashPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/gestiones',
        builder: (context, state) => const ManagmentsPage(),
      ),
    ],
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: AppMaterialTheme.colorScheme,
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          appBarTheme: const AppBarTheme(
              backgroundColor: AppMaterialTheme.surfaceColor)),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final AuthService _authService =
      AuthService(storageService: StorageService());
  final Duration splashDuration = const Duration(seconds: 3);

  @override
  void initState() {
    super.initState();
    _navegarSiguiente();
  }

  Future<void> _navegarSiguiente() async {
    // Espera 3 segundos
    await Future.delayed(splashDuration);
    _splashShown = true;
    
    final token = await _authService.getToken();

    if (token != null) {
      // Si hay token, navega a home
      if (mounted) context.go('/home');
    } else {
      // Si no hay token, navega a login
      if (mounted) context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
        child: const Center(
          child: Icon(Icons.fitness_center, color: Colors.white, size: 100),
        ),
      ),
    );
  }
}
