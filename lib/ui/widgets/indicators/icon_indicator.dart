import 'package:flutter/material.dart';

import 'package:quotes_and_jokes/ui/shared/styles.dart';

class IconIndicator extends StatelessWidget {
  final String label;
  final String imageUrl;

  const IconIndicator({
    @required this.label,
    @required this.imageUrl,
  })  : assert(imageUrl != null),
        assert(label != null);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              imageUrl,
              color: AppColors.secondary,
              width: MediaQuery.of(context).size.width * 0.3,
            ),
            const SizedBox(height: 20.0),
            Text(
              label,
              style: AppTextStyles.mediumDark.copyWith(
                color: Colors.white54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
