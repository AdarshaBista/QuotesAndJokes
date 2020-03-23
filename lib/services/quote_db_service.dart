import 'package:sembast/sembast.dart';

import 'package:quotes_and_jokes/models/quote.dart';

import 'package:quotes_and_jokes/services/db_service.dart';

class QuoteDbService extends DbService<Quote> {
  static const String QUOTE_STORE_NAME = 'quotes';

  QuoteDbService()
      : super(
          dbStore: intMapStoreFactory.store(QUOTE_STORE_NAME),
        );

  List<Quote> parseJson(
      List<RecordSnapshot<int, Map<String, dynamic>>> recordSnapshots) {
    return recordSnapshots
        .map((snapshot) => Quote.fromJson(
              snapshot.value,
            )..localId = snapshot.key)
        .toList();
  }
}
