import 'package:flutter/material.dart';
import 'package:tp_proyecto_final/model/exercise_model.dart';
import 'package:tp_proyecto_final/widgets/custom_text_fields.dart';

class ExerciseForm extends StatefulWidget {
  final Exercise exerciseData;
  final ExerciseDay? initialData;

  const ExerciseForm({Key? key, required this.exerciseData, this.initialData})
      : super(key: key);

  @override
  _ExerciseFormState createState() => _ExerciseFormState();
}

class _ExerciseFormState extends State<ExerciseForm> {
  late TextEditingController _observationsController;
  late TextEditingController _setsController;
  late TextEditingController _repetitionsController;
  late TextEditingController _weightController;

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _observationsController =
          TextEditingController(text: widget.initialData!.observations);
      _setsController =
          TextEditingController(text: widget.initialData!.sets.toString());
      _repetitionsController = TextEditingController(
          text: widget.initialData!.repetitions.toString());
      _weightController =
          TextEditingController(text: widget.initialData!.weight.toString());
    } else {
      _observationsController = TextEditingController(text: null);
      _setsController = TextEditingController(text: null);
      _repetitionsController = TextEditingController(text: null);
      _weightController = TextEditingController(text: null);
    }
  }

  void _submit() {
    if (_setsController.text.isEmpty ||
        _repetitionsController.text.isEmpty ||
        _weightController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Completa todos los campos del ejercicio")),
      );
      return;
    }

    final newExercise = ExerciseDay(
        exerciseId: widget.exerciseData.id,
        observations: _observationsController.text,
        sets: int.tryParse(_setsController.text) ?? 0,
        repetitions: int.tryParse(_repetitionsController.text) ?? 0,
        weight: double.tryParse(_weightController.text) ?? 0.0,
        exerciseData: widget.exerciseData);

    Navigator.pop(context, newExercise);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.exerciseData.name,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 8,
          ),
          Text(widget.exerciseData.description,
              style: theme.textTheme.bodyMedium),
          const SizedBox(
            height: 8,
          ),
          const SizedBox(
            height: 8,
          ),
          CustomTextField(
            controller: _setsController,
            label: "Series",
            keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 8,
          ),
          CustomTextField(
            controller: _repetitionsController,
            label: "Repeticiones",
            keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 8,
          ),
          CustomTextField(
            controller: _weightController,
            label: "Peso (kg)",
            keyboardType: TextInputType.number,
          ),
          CustomTextField(
            controller: _observationsController,
            label: "Observaciones",
            isRequired: false,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancelar"),
              ),
              FilledButton(
                onPressed: _submit,
                child: const Text("Agregar Ejercicio"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
