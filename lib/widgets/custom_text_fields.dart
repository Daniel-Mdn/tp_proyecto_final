import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final bool isRequired;
  final FloatingLabelBehavior floatingLabelBehavior;
  final TextStyle? errorStyle;
  final Widget? suffixIcon;
  final OutlineInputBorder? border;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.obscureText = false,
    this.isRequired = true,
    this.floatingLabelBehavior = FloatingLabelBehavior.never,
    this.errorStyle,
    this.suffixIcon,
    this.border,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          floatingLabelBehavior: floatingLabelBehavior,
          border: border ??
              OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.white.withOpacity(0.8),
          suffixIcon: suffixIcon,
        ),
        validator: (value) {
          if (isRequired && (value == null || value.isEmpty)) {
            return 'El campo es requerido';
          }
          return null;
        },
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}

class CustomPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextEditingController? confirmController;
  final bool isRequired;
  final FloatingLabelBehavior floatingLabelBehavior;
  final TextStyle? errorStyle;
  final Widget? suffixIcon;
  final OutlineInputBorder? border;

  const CustomPasswordField({
    super.key,
    required this.controller,
    required this.label,
    this.confirmController,
    this.isRequired = true,
    this.floatingLabelBehavior = FloatingLabelBehavior.never,
    this.errorStyle,
    this.suffixIcon,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
          labelText: label,
          floatingLabelBehavior: floatingLabelBehavior,
          border: border ??
              OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.white.withOpacity(0.8),
          suffixIcon: suffixIcon,
        ),
        validator: (value) {
          if (isRequired && (value == null || value.isEmpty)) {
            return 'El campo es requerido';
          }
          print(confirmController?.text);
          if (confirmController != null && value != confirmController!.text) {
            return 'Las contraseñas no coinciden';
          }
          return null;
        },
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
