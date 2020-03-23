import 'package:sembast/sembast.dart';

import 'package:quotes_and_jokes/models/joke.dart';

import 'package:quotes_and_jokes/services/db_service.dart';

class JokeDbService extends DbService<Joke> {
  static const String JOKE_STORE_NAME = 'jokes';

  JokeDbService()
      : super(
          dbStore: intMapStoreFactory.store(JOKE_STORE_NAME),
        );

  List<Joke> parseJson(
      List<RecordSnapshot<int, Map<String, dynamic>>> recordSnapshots) {
    return recordSnapshots
        .map((snapshot) => Joke.fromJson(
              snapshot.value,
            )..localId = snapshot.key)
        .toList();
  }
}
