import 'package:flutter/material.dart';

import 'package:quotes_and_jokes/ui/widgets/indicators/empty_icon.dart';
import 'package:quotes_and_jokes/ui/widgets/indicators/error_icon.dart';
import 'package:quotes_and_jokes/ui/widgets/indicators/finished_icon.dart';
import 'package:quotes_and_jokes/ui/widgets/indicators/loading_indicator.dart';

class PaginatedListView extends StatefulWidget {
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
  _PaginatedListViewState createState() => _PaginatedListViewState();
}

class _PaginatedListViewState<T> extends State<PaginatedListView> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent -
                widget.loadMoreOffset) {
          if (widget.hasMore) widget.onLoadMore();
        }
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: widget.itemCount == 0
          ? SingleChildScrollView(
              child: widget.hasError ? const ErrorIcon() : const EmptyIcon(),
            )
          : ListView.builder(
              controller: _scrollController,
              itemCount: widget.itemCount + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == widget.itemCount) {
                  if (widget.hasMore && !widget.hasError)
                    return const LoadingIndicator();
                  if (widget.hasError) return const ErrorIcon();
                  return const FinishedIcon();
                }

                return widget.itemBuilder(context, index);
              },
            ),
    );
  }
}
