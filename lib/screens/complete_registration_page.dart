import 'package:flutter/material.dart';
import 'package:tp_proyecto_final/model/user_model.dart';
import 'package:tp_proyecto_final/screens/complete_customer_registration_page.dart';
import 'package:tp_proyecto_final/screens/complete_profesional_registration_page.dart';

class CompleteRegistrationPage extends StatelessWidget {
  final TipoUsuario selectedRole;

  const CompleteRegistrationPage({super.key, required this.selectedRole});

  @override
  Widget build(BuildContext context) {
    return selectedRole == TipoUsuario.cliente
        ? const CompleteCustomerRegistrationPage()
        : const CompleteProfesionalRegistrationPage();
  }
}
