import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tp_proyecto_final/model/routine_model.dart';
import 'package:tp_proyecto_final/services/routine_provider.dart';
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
  late Future<List<Routine>> futureRoutinesList;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final routineProvider =
        Provider.of<RoutineProvider>(context, listen: false);
    futureRoutinesList = routineProvider.getRoutinesProfesionalUser();

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
            FutureBuilder(
                future: futureRoutinesList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("Error loading routines"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return SectionCard(
                        title: "Rutinas",
                        description: "Aqui veras tus rutinas",
                        actionText: "Crear rutina",
                        onActionPressed: () {
                          GoRouter.of(context).go('/gestiones/rutina');
                        });
                  }
                  final routines = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Tus Rutinas",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            FilledButton(
                                onPressed: () {
                                  GoRouter.of(context).go('/gestiones/rutina');
                                },
                                child: const Text('Crear nueva rutina')),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 16.0),
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: routines.length,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final routine = routines[index];

                            return Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: SizedBox(
                                  width: 160,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Image.asset(
                                            'assets/imgs/without_img.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Text(
                                          routine.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "⏳ ${routine.duration} min | 🎯 ${routine.objective}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 8),
                                        Center(
                                          child: FilledButton(
                                            onPressed: () {
                                              context.go(
                                                  '/gestiones/rutina/detalles',
                                                  extra: {routine.id});
                                            },
                                            style: ElevatedButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 4),
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium,
                                            ),
                                            child: const Text("Ver detalles"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
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
