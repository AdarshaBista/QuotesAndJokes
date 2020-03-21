import 'package:flutter/material.dart';

import 'package:states_rebuilder/states_rebuilder.dart';

import 'package:quotes_and_jokes/stores/quotes_store.dart';

import 'package:quotes_and_jokes/ui/widgets/quote_card.dart';
import 'package:quotes_and_jokes/ui/widgets/error_icon.dart';

class QuotesList extends StatelessWidget {
  final ReactiveModel<QuotesStore> model;

  const QuotesList({
    @required this.model,
  }) : assert(model != null);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (sn) {
        if (sn.metrics.pixels == sn.metrics.maxScrollExtent) {
          model.state.fetchQuote().then((_) => model.setState((_) => null));
        }
        return true;
      },
      child: RefreshIndicator(
        onRefresh: () async {
          await model.setState((quotesStore) async {
            quotesStore.clearQuotes();
            return await quotesStore.fetchQuote();
          });
        },
        child: ListView.builder(
          itemCount: model.state.quotes.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == model.state.quotes.length)
              return model.isWaiting
                  ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : const ErrorIcon();

            return QuoteCard(
              quote: model.state.quotes[index],
            );
          },
        ),
      ),
    );
  }
}
