import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:quotes_and_jokes/models/joke.dart';

class JokeApiService {
  Future<Joke> getRandom() async {
    try {
      http.Response res = await http.get('https://sv443.net/jokeapi/v2/joke/Any');
      return Joke.fromJson(jsonDecode(res.body));
    } catch (e) {
      return null;
    }
  }
}
