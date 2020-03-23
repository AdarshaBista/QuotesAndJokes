import 'package:quotes_and_jokes/models/joke.dart';

import 'package:quotes_and_jokes/services/joke_db_service.dart';
import 'package:quotes_and_jokes/services/joke_api_service.dart';

class JokesStore {
  final int maxJokes = 300;
  bool hasError = false;

  final JokeApiService _jokeApiService;
  final JokeDbService _jokeDbService;

  final Set<Joke> _jokes = {};
  List<Joke> get jokes => _jokes.toList();

  final List<Joke> _favouriteJokes = [];
  List<Joke> get favouriteJokes => _favouriteJokes;

  JokesStore(this._jokeApiService, this._jokeDbService) {
    loadFavouriteJokes();
  }

  void loadFavouriteJokes() async {
    _favouriteJokes.addAll(await _jokeDbService.getFavJokes());
  }

  void toggleFavourite(Joke joke) {
    joke.isFavourite = !joke.isFavourite;

    if (joke.isFavourite) {
      _favouriteJokes.insert(0, joke);
      _jokeDbService.insert(joke);
    } else {
      _favouriteJokes.remove(joke);
      _jokeDbService.delete(joke);
    }
  }

  void clearJokes() {
    _jokes.clear();
  }

  Future<void> fetchJokes() async {
    List<Joke> fetchedJokes = await _jokeApiService.fetchTen();
    if (fetchedJokes == null) {
      hasError = true;
      return;
    }

    hasError = false;
    fetchedJokes.forEach((j) => j.isFavourite = _favouriteJokes.contains(j));
    _jokes.addAll(fetchedJokes);
  }
}
