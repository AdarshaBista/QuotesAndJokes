import 'package:quotes_and_jokes/models/joke.dart';

import 'package:quotes_and_jokes/stores/base_store.dart';

import 'package:quotes_and_jokes/services/joke_db_service.dart';
import 'package:quotes_and_jokes/services/joke_api_service.dart';

class JokesStore extends BaseStore<Joke> {
  List<Joke> get jokes => items.toList();
  List<Joke> get favouriteJokes => favourites;

  JokesStore(
    JokeApiService jokeApiService,
    JokeDbService jokeDbService,
  ) : super(
          maxItems: 300,
          hasError: false,
          apiService: jokeApiService,
          dbService: jokeDbService,
        );
}
