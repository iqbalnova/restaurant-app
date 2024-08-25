import 'package:flutter/material.dart';

void showNoInternetDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible:
        false, // Prevent dialog from being dismissed by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('No Internet Connection'),
        content:
            const Text('Please check your internet connection and try again.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
