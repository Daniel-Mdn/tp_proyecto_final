import 'package:flutter/material.dart';

class SectionCard extends StatelessWidget {
  final String title;
  final String description;
  final String actionText;
  final VoidCallback onActionPressed;

  const SectionCard({
    super.key,
    required this.title,
    required this.description,
    required this.actionText,
    required this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(description),
            const SizedBox(height: 8.0),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onActionPressed,
                child: Text(actionText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
