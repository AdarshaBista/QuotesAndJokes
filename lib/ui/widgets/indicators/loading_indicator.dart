import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
