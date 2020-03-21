import 'package:quotes_and_jokes/models/quote.dart';

import 'package:quotes_and_jokes/services/quote_api_service.dart';

class QuotesStore {
  final QuoteApiService _quoteApiService;

  final Set<Quote> _quotes = {};
  List<Quote> get quotes => _quotes.toList();

  final List<Quote> _favouriteQuotes = [];
  List<Quote> get favouriteQuotes => _favouriteQuotes;

  QuotesStore(this._quoteApiService);

  void toggleFavourite(Quote quote) {
    quote.isFavourite = !quote.isFavourite;

    if (quote.isFavourite) {
      _favouriteQuotes.insert(0, quote);
    } else {
      _favouriteQuotes.remove(quote);
    }
  }

  void clearQuotes() {
    _quotes.clear();
  }

  Future<void> fetchQuote() async {
    Quote fetchedQuote = await _quoteApiService.getRandom();
    if (fetchedQuote == null) return;

    fetchedQuote.isFavourite = _favouriteQuotes.contains(fetchedQuote);
    _quotes.add(fetchedQuote);
  }
}
