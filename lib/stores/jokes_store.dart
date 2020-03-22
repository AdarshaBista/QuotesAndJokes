import 'package:quotes_and_jokes/models/joke.dart';

import 'package:quotes_and_jokes/services/joke_api_service.dart';

class JokesStore {
  final int maxJokes = 300;
  bool hasError = false;

  final JokeApiService _jokeApiService;

  final Set<Joke> _jokes = {};
  List<Joke> get jokes => _jokes.toList();

  final List<Joke> _favouriteJokes = [];
  List<Joke> get favouriteJokes => _favouriteJokes;

  JokesStore(this._jokeApiService);

  void toggleFavourite(Joke joke) {
    joke.isFavourite = !joke.isFavourite;

    if (joke.isFavourite)
      _favouriteJokes.insert(0, joke);
    else
      _favouriteJokes.remove(joke);
  }

  void clearJokes() {
    _jokes.clear();
  }

  Future<void> fetchJokes() async {
    List<Joke> fetchedJokes = await _jokeApiService.getTen();
    if (fetchedJokes == null) {
      hasError = true;
      return;
    }

    hasError = false;
    fetchedJokes.forEach((j) => j.isFavourite = _favouriteJokes.contains(j));
    _jokes.addAll(fetchedJokes);
  }
}
