import 'package:quotes_and_jokes/models/joke.dart';

import 'package:quotes_and_jokes/services/joke_api_service.dart';

class JokesStore {
  JokeApiService _jokeApiService;

  Set<Joke> _jokes = {};
  List<Joke> get jokes => _jokes.toList();

  Set<Joke> _favouriteJokes = {};
  List<Joke> get favouriteJokes => _favouriteJokes.toList();

  JokesStore(
    this._jokeApiService,
  );

  void toggleFavourite(Joke joke) {
    joke.isFavourite = !joke.isFavourite;

    if (joke.isFavourite) {
      _favouriteJokes.add(joke);
    } else {
      _favouriteJokes.remove(joke);
    }
  }

  Future<void> fetchJokes() async {
    List<Joke> fetchedJokes = await _jokeApiService.getTen();
    if (fetchedJokes == null) {
      fetchedJokes = [
        Joke(
          id: -1,
          type: 'error',
          setup: 'The only joke here is ...',
          punchline: 'Your internet connection.',
          isFavourite: false,
        )
      ];
    }

    _jokes.addAll(fetchedJokes);
  }
}
