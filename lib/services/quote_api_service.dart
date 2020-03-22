import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:quotes_and_jokes/models/quote.dart';

class QuoteApiService {
  Future<Quote> getRandom() async {
    try {
      http.Response res =
          await http.get('https://quote-garden.herokuapp.com/quotes/random');
      return Quote.fromJson(jsonDecode(res.body));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
