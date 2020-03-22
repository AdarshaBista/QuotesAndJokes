import 'package:flutter/material.dart';

import 'package:quotes_and_jokes/ui/widgets/indicators/icon_indicator.dart';

class ErrorIcon extends StatelessWidget {
  const ErrorIcon();

  @override
  Widget build(BuildContext context) {
    return IconIndicator(
      label: 'An error has occured...',
      imageUrl: 'assets/images/error.png',
    );
  }
}
