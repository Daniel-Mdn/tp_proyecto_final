import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tp_proyecto_final/model/user_model.dart';
import 'package:tp_proyecto_final/services/auth_service.dart';
import 'package:tp_proyecto_final/services/storage_service.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final AuthService _authService =
      AuthService(storageService: StorageService());

  late Future<UserModel> userLogged;

  @override
  void initState() {
    super.initState();
    userLogged = _authService.getUserLogger();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero, // Importante remover el padding
        children: <Widget>[
          FutureBuilder<UserModel>(
            future: userLogged,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Mientras se obtiene la respuesta, muestra un indicador de carga
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // Si ocurre algún error, se puede mostrar un mensaje o un Drawer alternativo
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (snapshot.hasData) {
                var userLogged = snapshot.data;
                return DrawerHeader(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/imgs/background_image.jpg'),
                            fit: BoxFit.cover)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              alignment: Alignment.center,
                              child: Image.asset('assets/imgs/logo.png',
                                  fit: BoxFit.cover),
                            ),
                            Expanded(
                              child: Text(
                                'PINAF',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '${userLogged?.nombre} ${userLogged?.apellido}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(color: Colors.white)),
                            Text('${userLogged?.email}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(color: Colors.white)),
                          ],
                        )
                      ],
                    ));
              } else {
                return SnackBar(content: Text('${snapshot.error}'));
              }
            },
          ),
          ListTile(
            title: const Text('Mis gestiones'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              context.go('/gestiones');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Ejercicios'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Planes alimenticios'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            iconColor: Colors.red,
            textColor: Colors.red,
            title: const Text('Cerrar sesión'),
            leading: const Icon(Icons.logout),
            onTap: () async {
              var resp = await _authService.logout(context);
              if (resp) {
                if (!context.mounted) return;
                context.go('/login');
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
