import 'package:flutter/material.dart';

import 'package:quotes_and_jokes/ui/shared/styles.dart';

class FavouritesTabBar extends StatelessWidget {
  const FavouritesTabBar();

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: const _SliverAppBarDelegate(
        tabBar: const TabBar(
          indicatorSize: TabBarIndicatorSize.label,
          isScrollable: true,
          indicatorWeight: 1.0,
          tabs: <Widget>[
            const Tab(
              icon: Icon(
                Icons.format_quote,
                color: Colors.blue,
              ),
            ),
            const Tab(
              icon: Icon(
                Icons.tag_faces,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSizeWidget tabBar;

  const _SliverAppBarDelegate({
    @required this.tabBar,
  }) : assert(tabBar != null);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      elevation: 8.0,
      color: AppColors.primary,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
