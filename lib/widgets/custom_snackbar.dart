import 'package:flutter/material.dart';

class CustomSnackbar extends StatelessWidget {
  final String message;
  const CustomSnackbar({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
    );
  }
}
