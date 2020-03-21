import 'package:flutter/material.dart';

import 'package:quotes_and_jokes/ui/shared/styles.dart';

class CollapsibleAppBar extends StatelessWidget {
  final String title;
  final String imageUrl;

  const CollapsibleAppBar({
    @required this.title,
    @required this.imageUrl,
  })  : assert(title != null),
        assert(imageUrl != null);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 8.0,
      expandedHeight: 140.0,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        titlePadding: const EdgeInsets.all(16.0),
        title: Text(
          title,
          style: AppTextStyles.extraLargeLight,
        ),
        background: Padding(
          padding: const EdgeInsets.only(left: 60.0, right: 60.0, top: 20.0),
          child: Image.asset(
            imageUrl,
            color: AppColors.secondary,
            alignment: Alignment.centerRight,
          ),
        ),
      ),
    );
  }
}
