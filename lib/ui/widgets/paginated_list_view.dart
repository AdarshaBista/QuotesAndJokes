import 'package:flutter/material.dart';
import 'package:quotes_and_jokes/ui/shared/app_text_styles.dart';

class PaginatedListView<T> extends StatefulWidget {
  final Function onRefresh;
  final Function onLoadMore;
  final IndexedWidgetBuilder itemBuilder;
  final Widget loadingWidget;
  final Widget errorWidget;
  final bool hasMore;
  final List<T> items;

  const PaginatedListView({
    @required this.onRefresh,
    @required this.onLoadMore,
    @required this.itemBuilder,
    @required this.loadingWidget,
    @required this.errorWidget,
    @required this.hasMore,
    @required this.items,
  });

  @override
  _PaginatedListViewState<T> createState() => _PaginatedListViewState<T>();
}

class _PaginatedListViewState<T> extends State<PaginatedListView<T>> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
          widget.onLoadMore();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == widget.items.length) {
            if (widget.hasMore) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  "That's it for now",
                  style: AppTextStyles.mediumLight,
                ),
              ),
            );
          }

          return widget.itemBuilder(context, index);
        },
      ),
    );
  }
}
