import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:quotes_and_jokes/models/quote.dart';

import 'package:quotes_and_jokes/services/api_service.dart';

class QuoteApiService implements ApiService<Quote> {
  Future<List<Quote>> fetch() async {
    final List<Quote> fetchedQuotes = [];
    try {
      for (int i = 0; i < 3; ++i) {
        http.Response res =
            await http.get('https://quote-garden.herokuapp.com/quotes/random');
        fetchedQuotes.add(Quote.fromJson(jsonDecode(res.body)));
      }
      return fetchedQuotes;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
