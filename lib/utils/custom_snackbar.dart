import 'package:flutter/material.dart';

enum SnackbarType { success, error }

void showSnackbar(BuildContext context, String message, SnackbarType type) {
  IconData icon;
  Color backgroundColor;

  switch (type) {
    case SnackbarType.success:
      icon = Icons.check_circle;
      backgroundColor = Colors.green;
      break;
    case SnackbarType.error:
      icon = Icons.error;
      backgroundColor = Colors.red;
      break;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Expanded(child: Text(message)),
        ],
      ),
      backgroundColor: backgroundColor,
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}
