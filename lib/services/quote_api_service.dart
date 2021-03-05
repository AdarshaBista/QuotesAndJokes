import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:quotes_and_jokes/models/quote.dart';

import 'package:quotes_and_jokes/services/api_service.dart';

class QuoteApiService implements ApiService<Quote> {
  Future<List<Quote>> fetch() async {
    try {
      http.Response res = await http
          .get('https://goquotes-api.herokuapp.com/api/v1/random?count=10');
      final resMap = jsonDecode(res.body);
      final quotes = resMap['quotes'] as List;
      return quotes
          .map((q) => Quote.fromJson(q as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
