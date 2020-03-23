import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:quotes_and_jokes/models/quote.dart';

class QuoteApiService {
  Future<List<Quote>> fetchThree() async {
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
