import 'package:flutter/material.dart';

class ModalService {
  ModalService();

  Future<bool?> showConfirmationDialog(
      BuildContext context, String title, String message) async {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false), // Cancela
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true), // Confirma
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }
}
