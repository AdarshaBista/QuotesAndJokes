import 'package:quotes_and_jokes/models/quote.dart';

import 'package:quotes_and_jokes/services/quote_db_service.dart';
import 'package:quotes_and_jokes/services/quote_api_service.dart';

class QuotesStore {
  final int maxQuotes = 4000;
  bool hasError = false;

  final QuoteApiService _quoteApiService;
  final QuoteDbService _quoteDbService;

  final Set<Quote> _quotes = {};
  List<Quote> get quotes => _quotes.toList();

  final List<Quote> _favouriteQuotes = [];
  List<Quote> get favouriteQuotes => _favouriteQuotes;

  QuotesStore(this._quoteApiService, this._quoteDbService) {
    loadFavouriteQuotes();
  }

  void loadFavouriteQuotes() async {
    _favouriteQuotes.addAll(await _quoteDbService.getFavQuotes());
  }

  void toggleFavourite(Quote quote) {
    quote.isFavourite = !quote.isFavourite;

    if (quote.isFavourite) {
      _favouriteQuotes.insert(0, quote);
      _quoteDbService.insert(quote);
    } else {
      _favouriteQuotes.remove(quote);
      _quoteDbService.delete(quote);
    }
  }

  void clearQuotes() {
    _quotes.clear();
  }

  Future<void> fetchQuote() async {
    List<Quote> fetchedQuotes = await Future.wait([
      _quoteApiService.getRandom(),
      _quoteApiService.getRandom(),
      _quoteApiService.getRandom(),
    ]);

    if (fetchedQuotes == null) {
      hasError = true;
      return;
    }

    hasError = false;
    fetchedQuotes.forEach((q) => q.isFavourite = _favouriteQuotes.contains(q));
    _quotes.addAll(fetchedQuotes);
  }
}
