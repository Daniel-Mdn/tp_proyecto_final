import 'package:flutter/material.dart';
import 'package:tp_proyecto_final/model/profesional_model.dart';
import 'package:tp_proyecto_final/model/user_model.dart';
import 'package:tp_proyecto_final/screens/complete_customer_registration_page.dart';
import 'package:tp_proyecto_final/screens/complete_profesional_registration_page.dart';

class CompleteRegistrationPage extends StatelessWidget {
  final TipoUsuario selectedRole;

  final Map<String, dynamic> formData;
  final TipoProfesional? specialty;

  const CompleteRegistrationPage(
      {super.key,
      required this.selectedRole,
      required this.formData,
      this.specialty});

  @override
  Widget build(BuildContext context) {
    return selectedRole == TipoUsuario.cliente
        ? CompleteCustomerRegistrationPage(formData: formData)
        : CompleteProfesionalRegistrationPage(
            formData: formData,
            specialty: specialty ?? TipoProfesional.entrenador,
          );
  }
}
