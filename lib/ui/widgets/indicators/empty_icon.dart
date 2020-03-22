import 'package:flutter/material.dart';

import 'package:quotes_and_jokes/ui/widgets/indicators/icon_indicator.dart';

class EmptyIcon extends StatelessWidget {
  const EmptyIcon();

  @override
  Widget build(BuildContext context) {
    return IconIndicator(
      label: 'Nothing here...',
      imageUrl: 'assets/images/empty.png',
    );
  }
}
