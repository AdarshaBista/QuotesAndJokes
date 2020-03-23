import 'package:flutter/material.dart';

import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:quotes_and_jokes/stores/quotes_store.dart';

import 'package:quotes_and_jokes/ui/widgets/quotes_page/quote_card.dart';
import 'package:quotes_and_jokes/ui/widgets/common/paginated_list_view.dart';

class QuotesList extends StatelessWidget {
  final ReactiveModel<QuotesStore> model;

  const QuotesList({
    @required this.model,
  }) : assert(model != null);

  @override
  Widget build(BuildContext context) {
    return PaginatedListView(
      onRefresh: () async {
        await model.setState(
          (quotesStore) async {
            quotesStore.clearQuotes();
            return await quotesStore.fetchQuote();
          },
        );
      },
      onLoadMore: () async {
        await model.state.fetchQuote().then((_) => model.setState((_) => null));
      },
      itemBuilder: (_, index) => QuoteCard(
        quote: model.state.quotes[index],
      ),
      hasError: model.state.hasError,
      hasMore: model.state.quotes.length < model.state.maxQuotes,
      itemCount: model.state.quotes.length,
    );
  }
}
