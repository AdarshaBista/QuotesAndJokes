import 'package:flutter/material.dart';

import 'package:quotes_and_jokes/ui/shared/styles.dart';

class Tag extends StatelessWidget {
  final String label;
  final Color color;

  const Tag({
    @required this.label,
    this.color = AppColors.secondary,
  }) : assert(label != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: color.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        label,
        style: AppTextStyles.extraSmallLight,
      ),
    );
  }
}
