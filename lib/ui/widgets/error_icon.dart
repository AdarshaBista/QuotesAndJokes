import 'package:flutter/material.dart';

import 'package:quotes_and_jokes/ui/shared/styles.dart';

class ErrorIcon extends StatelessWidget {
  const ErrorIcon();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.error_outline,
            size: 100.0,
            color: Colors.red,
          ),
          const SizedBox(height: 16.0),
          Text(
            'An error has occured...',
            style: AppTextStyles.largeDark.copyWith(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
