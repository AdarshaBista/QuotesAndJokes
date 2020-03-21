import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:quotes_and_jokes/models/joke.dart';

class JokeApiService {
  Future<List<Joke>> getTen() async {
    try {
      http.Response res = await http.get('https://official-joke-api.appspot.com/jokes/ten');
      return (jsonDecode(res.body) as List).map((j) => Joke.fromJson(j as Map<String, dynamic>)).toList();
    } catch (e) {
      return null;
    }
  }
}
