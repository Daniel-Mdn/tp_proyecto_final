import 'package:flutter/material.dart';
import 'package:tp_proyecto_final/helpers/app_material_theme.dart';
import 'package:tp_proyecto_final/screens/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: SplashPage(
        duration: 3,
        goToPage: const LoginPage(),
      ),
    );
  }
}

class SplashPage extends StatelessWidget {
  int duration;
  Widget goToPage;

  SplashPage({super.key, required this.goToPage, required this.duration});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: duration), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (builder) => goToPage));
    });

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
