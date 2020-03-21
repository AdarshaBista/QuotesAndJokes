import 'package:quotes_and_jokes/models/quote.dart';

import 'package:quotes_and_jokes/services/quote_api_service.dart';

class QuotesStore {
  final QuoteApiService _quoteApiService;

  final Set<Quote> _quotes = {};
  List<Quote> get quotes => _quotes.toList();

  final Set<Quote> _favouriteQuotes = {};
  List<Quote> get favouriteJokes => _favouriteQuotes.toList();

  QuotesStore(this._quoteApiService);

  void toggleFavourite(Quote quote) {
    quote.isFavourite = !quote.isFavourite;

    if (quote.isFavourite) {
      _favouriteQuotes.add(quote);
    } else {
      _favouriteQuotes.remove(quote);
    }
  }

  void clearQuotes() {
    _quotes.clear();
  }

  Future<void> fetchQuote() async {
    Quote fetchedQuote = await _quoteApiService.getRandom();
    if (fetchedQuote == null) {
      fetchedQuote = Quote(
        id: 'error',
        text: 'An error has occured...',
        author: 'John Doe',
        isFavourite: false,
      );
    }
    _quotes.add(fetchedQuote);
  }
}
