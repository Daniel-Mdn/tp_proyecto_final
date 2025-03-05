import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tp_proyecto_final/model/profesional_model.dart';
import 'package:tp_proyecto_final/model/user_model.dart';
import 'package:tp_proyecto_final/widgets/custom_text_fields.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  DateTime? _birthDate;
  Genero? _selectedGender;

  TipoUsuario _selectedRole = TipoUsuario.cliente;
  TipoProfesional? _selectedEspecialty;
  SegmentedButtonSelectable selectedSegmentedButton =
      const SegmentedButtonSelectable(TipoUsuario.cliente);

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() {
    if (_formKey.currentState!.validate() && _birthDate != null) {
      // Aquí iría la lógica de registro
      final formData = {
        "nombre": _nameController.text.trim(),
        "apellido": _lastNameController.text.trim(),
        "username": _emailController.text.trim(),
        "telefono": int.tryParse(_phoneController.text.trim()),
        "fechaNacimiento": _birthDate,
        "sexo": _selectedGender, // Convertir enum a string
        "password": _passwordController.text.trim(),
        "confirmPassword": _confirmPasswordController.text.trim(),
        "role": _selectedRole,
      };

      // Agregar llamada al post de crear usuario
      print("datos usuario ${formData.toString()}");
      context.go('/completar-registro',
          extra: {_selectedRole, _selectedEspecialty, formData});
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.3,
                child: Image.asset('assets/imgs/background_image.jpg',
                    fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Visibility(
                    visible: MediaQuery.of(context).viewInsets.bottom ==
                        0, // Se oculta si hay teclado
                    child: Flexible(
                        flex: 3,
                        child: ClipOval(
                          child: Container(
                            width: 80,
                            height: 80,
                            alignment: Alignment.center,
                            child: Image.asset('assets/imgs/logo.png',
                                fit: BoxFit.cover),
                          ),
                        )),
                  ),
                  const Text(
                    'Registro',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  SegmentedButton<SegmentedButtonSelectable>(
                    segments: const [
                      ButtonSegment(
                          value: SegmentedButtonSelectable(TipoUsuario.cliente),
                          label: Text('Cliente')),
                      ButtonSegment(
                          value: SegmentedButtonSelectable(
                              TipoUsuario.profesional,
                              TipoProfesional.entrenador),
                          label: Text('Entrenador')),
                      ButtonSegment(
                          value: SegmentedButtonSelectable(
                              TipoUsuario.profesional,
                              TipoProfesional.nutricionista),
                          label: Text('Nutricionista')),
                    ],
                    style: SegmentedButton.styleFrom(
                        backgroundColor: theme.colorScheme.onPrimary,
                        foregroundColor: theme.colorScheme.onSurface,
                        selectedForegroundColor:
                            theme.colorScheme.onSecondaryContainer,
                        selectedBackgroundColor:
                            theme.colorScheme.secondaryContainer,
                        textStyle: theme.textTheme.labelLarge
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    selected: {selectedSegmentedButton},
                    onSelectionChanged: (newSelection) {
                      setState(() {
                        selectedSegmentedButton = newSelection.first;
                        _selectedRole = selectedSegmentedButton.rol;
                        _selectedEspecialty =
                            selectedSegmentedButton.especialidad;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                            controller: _nameController, label: 'Nombre'),
                        CustomTextField(
                            controller: _lastNameController, label: 'Apellido'),
                        CustomTextField(
                            controller: _emailController, label: 'Email'),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: DropdownButtonFormField<Genero>(
                            value: _selectedGender,
                            decoration: InputDecoration(
                              labelText: "Género",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.8),
                            ),
                            onChanged: (Genero? newValue) {
                              setState(() {
                                _selectedGender = newValue;
                              });
                            },
                            items: Genero.values.map((Genero gender) {
                              return DropdownMenuItem<Genero>(
                                value: gender,
                                child: Text(gender == Genero.masculino
                                    ? "Masculino"
                                    : "Femenino"),
                              );
                            }).toList(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: TextFormField(
                            readOnly:
                                true, // Hace que el campo no sea editable directamente
                            decoration: InputDecoration(
                              labelText: _birthDate == null
                                  ? "Fecha de nacimiento"
                                  : "${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}",
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.calendar_today),
                                onPressed: () => _selectDate(context),
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.8),
                            ),
                            onTap: () => _selectDate(
                                context), // Llama a _selectDate cuando el usuario toca el campo
                          ),
                        ),
                        CustomTextField(
                          controller: _phoneController,
                          label: 'Telefono',
                          keyboardType: TextInputType.number,
                        ),
                        CustomPasswordField(
                          controller: _passwordController,
                          label: 'Contraseña',
                          confirmController: _confirmPasswordController,
                        ),
                        CustomPasswordField(
                            controller: _confirmPasswordController,
                            label: 'Repetir Contraseña'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    style: FilledButton.styleFrom(
                        fixedSize: Size.fromWidth(
                      MediaQuery.of(context).size.width * 0.6,
                    )),
                    onPressed: _register,
                    child: const Text('Continuar'),
                  ),
                  const SizedBox(height: 6),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        backgroundColor: theme.colorScheme.onPrimary,
                        fixedSize: Size.fromWidth(
                          MediaQuery.of(context).size.width * 0.6,
                        )),
                    onPressed: () => context.pop(),
                    child: const Text('Volver'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.white.withOpacity(0.8),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'El campo es requerido';
          }
          return null;
        },
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _birthDate = pickedDate;
      });
    }
  }
}

class SegmentedButtonSelectable {
  final TipoUsuario rol;
  final TipoProfesional? especialidad;

  const SegmentedButtonSelectable(this.rol, [this.especialidad]);
}
