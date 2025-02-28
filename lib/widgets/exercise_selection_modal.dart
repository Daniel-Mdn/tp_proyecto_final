import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp_proyecto_final/model/exercise_model.dart';
import 'package:tp_proyecto_final/services/exercise_provider.dart';
import 'package:tp_proyecto_final/services/search_provider.dart';
import 'package:tp_proyecto_final/widgets/search_with_autocomplete.dart';

class ExerciseSelectionModal extends StatefulWidget {
  const ExerciseSelectionModal({Key? key}) : super(key: key);

  @override
  _ExerciseSelectionModalState createState() => _ExerciseSelectionModalState();
}

class _ExerciseSelectionModalState extends State<ExerciseSelectionModal> {
  int? selectedExerciseId;
  String? selectedExerciseName;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final exerciseProvider =
        Provider.of<ExerciseProvider>(context, listen: false);
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
          ),
          child: Column(
            children: [
              SearchWithAutocompleteInput<Exercise>(
                fetchFunction: exerciseProvider.getExercises,
                displayStringForOption: (Exercise user) => user.name,
              ),
              Consumer<SearchProvider<Exercise>>(
                builder: (context, searchProvider, child) {
                  if (searchProvider.isLoading) {
                    return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: CircularProgressIndicator());
                  }
                  if (searchProvider.suggestions.isEmpty) {
                    return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text("No se encontraron resultados"));
                  }
                  return Expanded(
                      child: Container(
                          child: ListView.separated(
                    itemCount: searchProvider.suggestions.length,
                    itemBuilder: (context, index) {
                      final exercise = searchProvider.suggestions[index];
                      return ListTile(
                        tileColor: theme.colorScheme.surface,
                        leading: Image.asset('assets/imgs/without_img.png'),
                        title: Text(exercise.name),
                        subtitle: Text(exercise.muscleGroup),
                        trailing: const Icon(Icons.arrow_right),
                        onTap: () {
                          // Acción al seleccionar un ítem del listado
                          Navigator.pop<Exercise>(context, exercise);
                          print("Seleccionado: $exercise");
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 1,
                      );
                    },
                  )));
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildExerciseList() {
    List<Exercise> exercises = [
      Exercise(
          id: 1,
          name: 'Flexiones inclinadas',
          description: 'description',
          muscleGroup: 'muscleGroup'),
      Exercise(
          id: 2,
          name: 'Press martillo',
          description: 'description',
          muscleGroup: 'muscleGroup'),
      Exercise(
          id: 3,
          name: 'Pullover',
          description: 'description',
          muscleGroup: 'muscleGroup'),
    ];

    return ListView(
      children: exercises.map((exercise) {
        return ListTile(
          title: Text(exercise.name),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pop<Exercise>(context, exercise);
          },
        );
      }).toList(),
    );
  }
}
