import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class CompleteCustomerRegistrationPage extends StatefulWidget {
  const CompleteCustomerRegistrationPage({super.key});

  @override
  State<CompleteCustomerRegistrationPage> createState() =>
      _CompleteCustomerRegistrationPageState();
}

class _CompleteCustomerRegistrationPageState
    extends State<CompleteCustomerRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _objectiveController = TextEditingController();
  final TextEditingController _trainingTypeController = TextEditingController();
  final TextEditingController _timeDedicationController =
      TextEditingController();
  final TextEditingController _sportsController = TextEditingController();

  List<String> deportesSeleccionados = [];
  bool _submitted = false;

  final List<String> deportes = ["Futbol", "Basket", "Volley"];

  void _updateUser() {
    setState(() => _submitted = true);

    if (_formKey.currentState?.validate() ?? false) {
      // Validar que todos los controladores tengan valores
      if (_objectiveController.text.isNotEmpty &&
          _trainingTypeController.text.isNotEmpty &&
          _timeDedicationController.text.isNotEmpty &&
          (_trainingTypeController.text != 'Entrenamiento deportivo' ||
              deportesSeleccionados.isNotEmpty)) {
        var snackbar = ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registro completado')),
        );
        snackbar.closed.whenComplete(() => context.go('/home'));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceContainerLowest,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Image.asset(
                'assets/imgs/logo.png',
                fit: BoxFit.cover,
                width: 60,
                height: 60,
              ),
              const SizedBox(height: 10),
              const Text(
                'Completa las siguientes preguntas para empezar a entrenar!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Pregunta 1: Objetivo
              _buildQuestionCard(
                title: '¿Cuáles son los objetivos que más se ajustan a vos?',
                child: Column(
                  children: [
                    _buildRadioOption(
                        'Tonificar mi cuerpo', _objectiveController),
                    _buildRadioOption(
                        'Ganar estado físico', _objectiveController),
                    _buildRadioOption('Bajar peso', _objectiveController),
                    if (_submitted && _objectiveController.text.isEmpty)
                      _buildErrorText('Debes seleccionar un objetivo'),
                  ],
                ),
              ),

              // Pregunta 2: Tipo de entrenamiento
              _buildQuestionCard(
                title: '¿Qué tipo de entrenamiento te interesa?',
                child: Column(
                  children: [
                    _buildRadioOption(
                        'Entrenamiento gimnasio', _trainingTypeController,
                        resetSports: true),
                    _buildRadioOption(
                        'Entrenamiento deportivo', _trainingTypeController,
                        resetSports: false),
                    if (_submitted && _trainingTypeController.text.isEmpty)
                      _buildErrorText(
                          'Debes seleccionar un tipo de entrenamiento'),
                    if (_trainingTypeController.text ==
                        'Entrenamiento deportivo') ...[
                      const SizedBox(height: 10),
                      _buildSectionTitle('Seleccione un deporte'),
                      TextFormField(
                        controller: _sportsController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Deportes seleccionados',
                          suffixIcon: const Icon(Icons.arrow_drop_down),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onTap: () async {
                          final List<String>? selectedSports =
                              await showDialog<List<String>>(
                            context: context,
                            builder: (context) {
                              return MultiSelectDialog(
                                items: deportes
                                    .map((deporte) =>
                                        MultiSelectItem(deporte, deporte))
                                    .toList(),
                                initialValue: deportesSeleccionados,
                                title: const Text("Seleccione deportes"),
                                onConfirm: (values) {
                                  setState(() {
                                    deportesSeleccionados =
                                        List<String>.from(values);
                                    _sportsController.text =
                                        deportesSeleccionados.join(', ');
                                  });
                                },
                              );
                            },
                          );
                          print(selectedSports);
                          setState(() {});
                        },
                      ),
                      if (_submitted && deportesSeleccionados.isEmpty)
                        _buildErrorText(
                            'Debes seleccionar al menos un deporte'),
                    ],
                  ],
                ),
              ),

              // Pregunta 3: Tiempo de dedicación
              _buildQuestionCard(
                title: '¿Cuánto tiempo piensas dedicar?',
                child: Column(
                  children: [
                    _buildRadioOption(
                        '1 día a la semana', _timeDedicationController),
                    _buildRadioOption(
                        '2 a 3 días a la semana', _timeDedicationController),
                    _buildRadioOption(
                        'Más de 3 días', _timeDedicationController),
                    if (_submitted && _timeDedicationController.text.isEmpty)
                      _buildErrorText(
                          'Debes seleccionar un tiempo de dedicación'),
                  ],
                ),
              ),

              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () => context.go('/login'),
                    child: const Text('Cerrar sesión'),
                  ),
                  FilledButton(
                    onPressed: _updateUser,
                    child: const Text('Crear Cuenta'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionCard({required String title, required Widget child}) {
    final ThemeData theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildSectionTitle(title),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }

  Widget _buildErrorText(String errorText) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Text(
        errorText,
        style: const TextStyle(color: Colors.red, fontSize: 12),
      ),
    );
  }

  Widget _buildRadioOption(String text, TextEditingController controller,
      {bool resetSports = false}) {
    return RadioListTile<String>(
      title: Text(text),
      value: text,
      groupValue: controller.text,
      onChanged: (value) {
        setState(() {
          controller.text = value ?? '';
          if (resetSports) {
            deportesSeleccionados.clear();
            _sportsController.clear();
          }
        });
      },
    );
  }
}
