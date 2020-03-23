import 'package:quotes_and_jokes/models/quote.dart';

import 'package:quotes_and_jokes/stores/base_store.dart';

import 'package:quotes_and_jokes/services/quote_db_service.dart';
import 'package:quotes_and_jokes/services/quote_api_service.dart';

class QuotesStore extends BaseStore<Quote> {
  List<Quote> get quotes => items.toList();
  List<Quote> get favouriteQuotes => favourites;

  QuotesStore(
    QuoteApiService quoteApiService,
    QuoteDbService quoteDbService,
  ) : super(
          maxItems: 4000,
          hasError: false,
          apiService: quoteApiService,
          dbService: quoteDbService,
        );
}
