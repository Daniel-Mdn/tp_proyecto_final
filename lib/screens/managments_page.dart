import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tp_proyecto_final/model/user_model.dart';
import 'package:tp_proyecto_final/services/auth_service.dart';
import 'package:tp_proyecto_final/services/storage_service.dart';
import 'package:tp_proyecto_final/services/user_provider.dart';
import 'package:tp_proyecto_final/widgets/app_bar_widget.dart';
import 'package:tp_proyecto_final/widgets/bottom_navigator_widget.dart';
import 'package:tp_proyecto_final/widgets/drawer_widget.dart';
import 'package:tp_proyecto_final/widgets/section_card.dart';

class ManagmentsPage extends StatefulWidget {
  const ManagmentsPage({super.key});

  @override
  State<ManagmentsPage> createState() => _ManagmentsPageState();
}

class _ManagmentsPageState extends State<ManagmentsPage> {
  final _formGlobalKey = GlobalKey<FormState>();
  final AuthService _authService =
      AuthService(storageService: StorageService());

  late Future<List<UserModel>> futureRoutinesList;

  @override
  void initState() {
    super.initState();
    var usersProvider = UserProvider();
    futureRoutinesList = usersProvider.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLowest,
      appBar: const AppBarWidget(),
      drawer: const DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SectionCard(
                title: "Equipos",
                description: "Aqui veras tus equipos",
                actionText: "Crear equipo",
                onActionPressed: () {
                  GoRouter.of(context).go('/equipos');
                }),
            SectionCard(
                title: "Rutinas",
                description: "Aqui veras tus rutinas",
                actionText: "Crear rutinas",
                onActionPressed: () {
                  GoRouter.of(context).go('/gestiones/rutina');
                }),
            SectionCard(
                title: "Planes de alimentación",
                description: "Crea planes para tus clientes",
                actionText: "Crear plan",
                onActionPressed: () {
                  GoRouter.of(context).go('/planes-alimentacion');
                }),
            SectionCard(
                title: "Alimentos",
                description: "Crea alimentos para tus planes alimenticios",
                actionText: "Crear alimento",
                onActionPressed: () {
                  GoRouter.of(context).go('/alimentos');
                }),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigatorBarWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
