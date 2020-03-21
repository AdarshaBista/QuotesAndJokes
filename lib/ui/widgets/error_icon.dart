import 'package:flutter/material.dart';

class ErrorIcon extends StatelessWidget {
  const ErrorIcon();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.error_outline,
        size: 100.0,
        color: Colors.red,
      ),
    );
  }
}
