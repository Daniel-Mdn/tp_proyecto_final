import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tp_proyecto_final/config/api_contants.dart';
import 'package:tp_proyecto_final/helpers/app_material_theme.dart';
import 'package:tp_proyecto_final/model/exercise_model.dart';
import 'package:tp_proyecto_final/model/profesional_model.dart';
import 'package:tp_proyecto_final/model/user_model.dart';
import 'package:tp_proyecto_final/screens/complete_registration_page.dart';
import 'package:tp_proyecto_final/screens/view_routine_page.dart';
import 'package:tp_proyecto_final/screens/create_routine_page.dart';
import 'package:tp_proyecto_final/screens/equips_page.dart';
import 'package:tp_proyecto_final/screens/home_page.dart';
import 'package:tp_proyecto_final/screens/login_page.dart';
import 'package:tp_proyecto_final/services/auth_interceptor.dart';
import 'package:tp_proyecto_final/screens/managments_page.dart';
import 'package:tp_proyecto_final/screens/register_page.dart';
import 'package:tp_proyecto_final/services/auth_service.dart';
import 'package:tp_proyecto_final/services/exercise_provider.dart';
import 'package:tp_proyecto_final/services/routine_provider.dart';
import 'package:tp_proyecto_final/services/search_provider.dart';
import 'package:tp_proyecto_final/services/storage_service.dart';
import 'package:tp_proyecto_final/services/user_provider.dart';

// Variable global para controlar si ya se mostró la pantalla de bienvenida
bool _splashShown = false;

void main() {
  final dio = Dio(BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    headers: {
      'Content-Type': 'application/json',
    },
  ));
  final storageService = StorageService();
  final authService = AuthService(storageService: storageService, dio: dio);
  dio.interceptors.add(AuthInterceptor(authService: authService));

  runApp(
    MultiProvider(
      providers: [
        // Provee el SearchProvider parametrizado para User
        ChangeNotifierProvider<AuthService>(create: (_) => authService),
        ChangeNotifierProvider(create: (_) => SearchProvider<UserModel>()),
        ChangeNotifierProvider(create: (_) => UserProvider(dio: dio)),
        ChangeNotifierProvider(create: (_) => SearchProvider<Exercise>()),
        ChangeNotifierProvider(create: (_) => ExerciseProvider(dio: dio)),
        ChangeNotifierProvider(create: (_) => RoutineProvider(dio: dio)),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // Inicializa el router con redirección según el estado de sesión
  final GoRouter _router = GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
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
        path: '/registro',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/completar-registro',
        builder: (context, state) {
          // Si el extra es null, redirigir al login
          if (state.extra == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go('/login');
            });
            return const SizedBox
                .shrink(); // Evita que se renderice una pantalla vacía momentáneamente
          } else {
            final TipoUsuario selectedRole =
                (state.extra! as Set).first as TipoUsuario;
            final Map<String, dynamic> formData = (state.extra! as Set)
                .firstWhere((element) => element is Map<String, dynamic>);
            final TipoProfesional? specialty = (state.extra! as Set).firstWhere(
                (element) => element is TipoProfesional,
                orElse: () => null);

            return CompleteRegistrationPage(
                selectedRole: selectedRole,
                formData: formData,
                specialty: specialty);
          }
        },
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/gestiones',
        builder: (context, state) => const ManagmentsPage(),
        routes: [
          GoRoute(
            path: 'rutina',
            builder: (context, state) => const CreateRoutinePage(),
          ),
          GoRoute(
            path: 'rutina/detalles',
            builder: (context, state) {
              if (state.extra == null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.go('/gestiones');
                });
                return const SizedBox
                    .shrink(); // Evita que se renderice una pantalla vacía momentáneamente
              } else {
                final int idRoutine = (state.extra! as Set).first as int;
                return ViewRoutinePage(routineId: idRoutine);
              }
            },
          ),
        ],
      ),
      GoRoute(
        path: '/equipos',
        builder: (context, state) => EquipsPage(),
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
      locale: const Locale('es', 'ES'), // 👈 Fuerza el idioma español
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final Duration splashDuration = const Duration(seconds: 3);

  @override
  void initState() {
    super.initState();
    _navegarSiguiente();
  }

  Future<void> _navegarSiguiente() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    // Espera 3 segundos
    await Future.delayed(splashDuration);
    _splashShown = true;

    try {
      final expiredToken = await authService.isJwtExpired();

      if (expiredToken) {
        if (mounted) context.go('/login');
      } else {
        if (mounted) context.go('/home');
        // Si no hay token, navega a login
      }
    } catch (e) {
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
