import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tp_proyecto_final/model/routine_model.dart';
import 'package:tp_proyecto_final/services/routine_provider.dart';
import 'package:tp_proyecto_final/widgets/bottom_navigator_widget.dart';

class ViewRoutinePage extends StatefulWidget {
  final int routineId;
  const ViewRoutinePage({super.key, required this.routineId});

  @override
  State<ViewRoutinePage> createState() => _ViewRoutinePageState();
}

class _ViewRoutinePageState extends State<ViewRoutinePage> {
  late Future<Routine> futureRoutine;

  @override
  void initState() {
    super.initState();
    // Suponemos que RoutineProvider tiene un método getRoutineById que retorna Future<Routine>
    final routineProvider =
        Provider.of<RoutineProvider>(context, listen: false);
    futureRoutine = routineProvider.getRoutine(widget.routineId);
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLowest,
      appBar: AppBar(title: const Text("Ver rutina")),
      body: FutureBuilder<Routine>(
        future: futureRoutine,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error cargando la rutina"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("No se encontró la rutina"));
          }
          final routine = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título y descripción de la rutina
                Text(
                  routine.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  routine.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
                // Otros detalles de la rutina
                Text(
                  "Objetivo: ${routine.objective}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "Duración: ${routine.duration} min",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "Dificultad: ${routine.difficulty}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                // Visualizar días de la rutina
                Text(
                  "Días de la rutina:",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: routine.days.length,
                  itemBuilder: (context, index) {
                    final day = routine.days[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Encabezado del día
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  day.day,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text("Ejercicios: ${day.exercises.length}"),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // Listado de ejercicios del día
                            if (day.exercises.isNotEmpty)
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: day.exercises.length,
                                separatorBuilder: (context, index) =>
                                    const Divider(),
                                itemBuilder: (context, exIndex) {
                                  final exercise = day.exercises[exIndex];
                                  return ListTile(
                                    title: Text(
                                      exercise.exerciseName!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: colorScheme.onSurface),
                                    ),
                                    subtitle: Text(
                                      "Series: ${exercise.sets}  Reps: ${exercise.repetitions}  Peso: ${exercise.weight} kg",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              color:
                                                  colorScheme.onSurfaceVariant),
                                    ),
                                  );
                                },
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                // Botón para regresar o navegar a otra página
                Center(
                  child: ElevatedButton(
                    onPressed: () => context.pop(),
                    child: const Text("Volver"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomNavigatorBarWidget(),
    );
  }
}
