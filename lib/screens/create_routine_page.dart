import 'package:flutter/material.dart';
import 'package:tp_proyecto_final/model/exercise_model.dart';
import 'package:tp_proyecto_final/model/routine_model.dart';
import 'package:tp_proyecto_final/widgets/bottom_navigator_widget.dart';
import 'package:tp_proyecto_final/widgets/custom_text_fields.dart';
import 'package:tp_proyecto_final/widgets/exercise_form_modal.dart';
import 'package:tp_proyecto_final/widgets/exercise_selection_modal.dart';

class CreateRoutinePage extends StatefulWidget {
  const CreateRoutinePage({super.key});

  @override
  State<CreateRoutinePage> createState() => _CreateRoutinePageState();
}

class _CreateRoutinePageState extends State<CreateRoutinePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _objectiveController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _difficultyController = TextEditingController();

  List<RoutineDay> routineDays = [];

  void _addExerciseToDay(int dayIndex, ExerciseDay exercise) {
    setState(() {
      routineDays[dayIndex].exercises.add(exercise);
    });
  }

  void _addRoutineDay() {
    setState(() {
      routineDays.add(RoutineDay(
        order: routineDays.length + 1,
        day: "Día ${routineDays.length + 1}",
        observations: "",
        exercises: [],
      ));
    });
  }

  void _createRoutine() {
    if (_nameController.text.isEmpty ||
        _objectiveController.text.isEmpty ||
        _durationController.text.isEmpty ||
        _difficultyController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        routineDays.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Completa todos los campos antes de continuar")),
      );
      return;
    }

    Routine routine = Routine(
      name: _nameController.text,
      objective: _objectiveController.text,
      duration: int.tryParse(_durationController.text) ?? 0,
      difficulty: _difficultyController.text,
      description: _descriptionController.text,
      days: routineDays,
    );

    final routineJson = routine.toJson();
    print("Rutina a enviar: $routineJson");

    // Aquí se enviaría la rutina a la API
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLowest,
      appBar: AppBar(title: const Text("Crear rutina")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              controller: _nameController,
              label: "Nombre rutina",
            ),
            CustomTextField(
              controller: _descriptionController,
              label: "Descripción",
            ),
            CustomTextField(
              controller: _objectiveController,
              label: "Objetivo",
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: _durationController,
                    label: "Duración (min)",
                    obscureText: false,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: CustomTextField(
                    controller: _difficultyController,
                    label: "Dificultad",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            FilledButton(
              onPressed: _addRoutineDay,
              child: const Text("Agregar Día"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: routineDays.length,
                itemBuilder: (context, index) {
                  final day = routineDays[index];
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12)),
                          child: Container(
                            decoration: BoxDecoration(
                                color: colorScheme.secondaryContainer,
                                border: Border(
                                    bottom: BorderSide(
                                        color: colorScheme.outlineVariant,
                                        width: 2))),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(day.day,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    Text("Ejercicios: ${day.exercises.length}"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (day.exercises.isNotEmpty) ...[
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) =>
                                const Divider(height: 1),
                            itemCount: day.exercises.length,
                            itemBuilder: (context, exIndex) {
                              final exercise = day.exercises[exIndex];
                              return ListTile(
                                title: Text(
                                  exercise.exerciseData.name,
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: colorScheme.onSurface),
                                ),
                                subtitle: Text(
                                  "Series: ${exercise.sets}, Reps: ${exercise.repetitions}, Peso: ${exercise.weight} kg",
                                  style: theme.textTheme.bodyMedium!.copyWith(
                                      color: colorScheme.onSurfaceVariant),
                                ),
                              );
                            },
                          ),
                        ],
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Center(
                            child: FilledButton.icon(
                              style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                      colorScheme.tertiary)),
                              onPressed: () async {
                                final newExercise =
                                    await showExerciseBottomSheet(context);
                                if (newExercise != null) {
                                  _addExerciseToDay(index, newExercise);
                                }
                              },
                              icon: const Icon(Icons.add),
                              label: const Text("Agregar Ejercicio"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancelar"),
                ),
                ElevatedButton(
                  onPressed: _createRoutine,
                  child: const Text("Crear rutina"),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigatorBarWidget(),
    );
  }

  Future<ExerciseDay?> showExerciseBottomSheet(BuildContext context) async {
    final selectedExercise = await showModalBottomSheet<Exercise>(
      context: context,
      isScrollControlled: true,
      builder: (context) => const ExerciseSelectionModal(),
    );

    if (selectedExercise != null) {
      final newExercise = await showModalBottomSheet<ExerciseDay>(
        context: context,
        isScrollControlled: true,
        builder: (context) => ExerciseForm(
          exerciseData: selectedExercise,
        ),
      );

      return newExercise;
    }
    return null;
  }
}
