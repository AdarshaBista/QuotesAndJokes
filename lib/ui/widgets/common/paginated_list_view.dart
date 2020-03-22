import 'package:flutter/material.dart';

import 'package:quotes_and_jokes/ui/widgets/indicators/empty_icon.dart';
import 'package:quotes_and_jokes/ui/widgets/indicators/error_icon.dart';
import 'package:quotes_and_jokes/ui/widgets/indicators/finished_icon.dart';
import 'package:quotes_and_jokes/ui/widgets/indicators/loading_indicator.dart';

class PaginatedListView extends StatelessWidget {
  final RefreshCallback onRefresh;
  final Function onLoadMore;
  final IndexedWidgetBuilder itemBuilder;
  final bool hasMore;
  final bool hasError;
  final int itemCount;
  final double loadMoreOffset;

  const PaginatedListView({
    @required this.onRefresh,
    @required this.onLoadMore,
    @required this.hasMore,
    @required this.hasError,
    @required this.itemBuilder,
    @required this.itemCount,
    this.loadMoreOffset = 100.0,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification sn) {
        if (sn.metrics.pixels >= sn.metrics.maxScrollExtent - loadMoreOffset) {
          if (hasMore) onLoadMore();
        }
        return true;
      },
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: itemCount == 0
            ? SingleChildScrollView(
                child: hasError ? const ErrorIcon() : const EmptyIcon(),
              )
            : ListView.builder(
                itemCount: itemCount + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == itemCount) {
                    if (hasMore && !hasError) return const LoadingIndicator();
                    if (hasError) return const ErrorIcon();
                    return const FinishedIcon();
                  }
                  return itemBuilder(context, index);
                },
              ),
      ),
    );
  }
}
