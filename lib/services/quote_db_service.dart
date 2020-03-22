import 'package:sembast/sembast.dart';

import 'package:quotes_and_jokes/models/quote.dart';

import 'package:quotes_and_jokes/database/app_db.dart';

class QuoteDbService {
  static const String QUOTE_STORE_NAME = 'quotes';
  final _quotesDbStore = intMapStoreFactory.store(QUOTE_STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future<bool> insert(Quote quote) async {
    int key = await _quotesDbStore.add(
      await _db,
      quote.toJson(),
    );
    if (key == null) return false;

    quote.localId = key;
    return true;
  }

  Future<void> delete(Quote quote) async {
    await _quotesDbStore.delete(
      await _db,
      finder: Finder(
        filter: Filter.byKey(quote.localId),
      ),
    );
  }

  Future<List<Quote>> getFavQuotes() async {
    final recordSnapshots = await _quotesDbStore.find(
      await _db,
    );

    List<Quote> favQuotes = recordSnapshots
        .map((snapshot) => Quote.fromJson(
              snapshot.value,
            )..localId = snapshot.key)
        .toList();

    print('Quotes in db => ' + favQuotes.length.toString());
    return favQuotes..sort((q1, q2) => q2.localId.compareTo(q1.localId));
  }
}
