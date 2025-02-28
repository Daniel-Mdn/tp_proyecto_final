import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class CustomMultiSelectField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final List<String> items;
  final bool isRequired;
  final FloatingLabelBehavior floatingLabelBehavior;
  final TextStyle? errorStyle;
  final OutlineInputBorder? border;

  const CustomMultiSelectField({
    super.key,
    required this.controller,
    required this.label,
    required this.items,
    this.isRequired = true,
    this.floatingLabelBehavior = FloatingLabelBehavior.never,
    this.errorStyle,
    this.border,
  });

  @override
  State<CustomMultiSelectField> createState() => _CustomMultiSelectFieldState();
}

class _CustomMultiSelectFieldState extends State<CustomMultiSelectField> {
  List<String> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: widget.controller,
        readOnly: true, // Evita que el usuario escriba manualmente
        decoration: InputDecoration(
          labelText: widget.label,
          floatingLabelBehavior: widget.floatingLabelBehavior,
          border: widget.border ??
              OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.white.withOpacity(0.8),
          suffixIcon: const Icon(Icons.arrow_drop_down),
        ),
        onTap: () async {
          await showDialog(
            context: context,
            builder: (ctx) {
              return MultiSelectDialog(
                items: widget.items
                    .map((item) => MultiSelectItem<String>(item, item))
                    .toList(),
                initialValue: selectedItems,
                title: Text(widget.label),
                selectedColor: Colors.teal,
                onConfirm: (values) {
                  setState(() {
                    selectedItems = List<String>.from(values);
                    widget.controller.text = selectedItems.join(', ');
                  });
                },
              );
            },
          );
        },
        validator: (value) {
          if (widget.isRequired && (value == null || value.isEmpty)) {
            return 'Seleccione al menos una opción';
          }
          return null;
        },
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
