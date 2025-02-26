import 'package:flutter/material.dart';
import 'package:tp_proyecto_final/model/certification_form_model.dart';
import 'package:tp_proyecto_final/widgets/custom_text_fields.dart';

Future<CertificationForm?> showCertificationFormModal(
    BuildContext context) async {
  return await showModalBottomSheet<CertificationForm>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          top: 16,
        ),
        child: CertificationFormWidget(),
      );
    },
  );
}

class CertificationFormWidget extends StatefulWidget {
  @override
  _CertificationFormWidgetState createState() =>
      _CertificationFormWidgetState();
}

class _CertificationFormWidgetState extends State<CertificationFormWidget> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _institutionController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  bool _inProgress = false;
  String? _experienceType;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Indicador superior
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 16),

          // Campo: Título
          CustomTextField(
            controller: _titleController,
            label: 'Título',
          ),

          const SizedBox(height: 10),

          // Campo: Descripción
          CustomTextField(
            controller: _descriptionController,
            label: "Descripción",
          ),

          const SizedBox(height: 10),

          // Campo: Institución
          CustomTextField(
              controller: _institutionController, label: "Institución"),

          const SizedBox(height: 10),

          // Selección de Fechas
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  icon: const Icon(Icons.calendar_today),
                  label: Text(_startDate == null
                      ? "Fecha inicio"
                      : "${_startDate!.day}/${_startDate!.month}/${_startDate!.year}"),
                  onPressed: () => _selectDate(context, true),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextButton.icon(
                  icon: const Icon(Icons.calendar_today),
                  label: Text(_endDate == null
                      ? "Fecha fin"
                      : "${_endDate!.day}/${_endDate!.month}/${_endDate!.year}"),
                  onPressed:
                      _inProgress ? null : () => _selectDate(context, false),
                ),
              ),
            ],
          ),

          // Checkbox: En curso
          CheckboxListTile(
            title: const Text("En curso"),
            value: _inProgress,
            onChanged: (value) {
              setState(() {
                _inProgress = value!;
                if (_inProgress) _endDate = null;
              });
            },
          ),

          const SizedBox(height: 10),

          // Dropdown: Tipo de experiencia
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: "Tipo de experiencia"),
            items: ["Entrenador", "Profesor"]
                .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                .toList(),
            onChanged: (value) => setState(() => _experienceType = value),
            validator: (value) => value == null ? "Selecciona un tipo" : null,
          ),

          const SizedBox(height: 10),

          // Botón de subir archivo (ejemplo)
          FilledButton.icon(
            onPressed: () {},
            style: const ButtonStyle(alignment: Alignment.centerLeft),
            icon: const Icon(Icons.upload_file),
            label: const Text("Subir archivo"),
          ),

          const SizedBox(height: 20),

          // Botones de acción
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancelar"),
              ),
              ElevatedButton(
                onPressed: _saveForm,
                child: const Text("Guardar Cambios"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        if (isStart) {
          _startDate = pickedDate;
        } else {
          _endDate = pickedDate;
        }
      });
    }
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final formData = CertificationForm(
        title: _titleController.text,
        description: _descriptionController.text,
        institution: _institutionController.text,
        startDate: _startDate,
        endDate: _endDate,
        inProgress: _inProgress,
        experienceType: _experienceType!,
      );

      Navigator.pop(context, formData);
    }
  }
}
