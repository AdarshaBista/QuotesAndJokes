import 'package:sembast/sembast.dart';

import 'package:quotes_and_jokes/models/joke.dart';

import 'package:quotes_and_jokes/database/app_db.dart';

class JokeDbService {
  static const String JOKE_STORE_NAME = 'jokes';
  final _jokesDbStore = intMapStoreFactory.store(JOKE_STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future<bool> insert(Joke joke) async {
    int key = await _jokesDbStore.add(
      await _db,
      joke.toJson(),
    );
    if (key == null) return false;

    joke.localId = key;
    return true;
  }

  Future<void> delete(Joke joke) async {
    await _jokesDbStore.delete(
      await _db,
      finder: Finder(
        filter: Filter.byKey(joke.localId),
      ),
    );
  }

  Future<List<Joke>> getFavJokes() async {
    final recordSnapshots = await _jokesDbStore.find(
      await _db,
    );

    List<Joke> favJokes = recordSnapshots
        .map((snapshot) => Joke.fromJson(
              snapshot.value,
            )..localId = snapshot.key)
        .toList();

    print('Jokes in db => ' + favJokes.length.toString());
    return favJokes..sort((j1, j2) => j2.localId.compareTo(j1.localId));
  }
}
