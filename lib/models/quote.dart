import 'package:flutter/material.dart';

class Quote {
  final String id;
  final String text;
  final String author;

  const Quote({
    @required this.id,
    @required this.text,
    @required this.author,
  })  : assert(id != null),
        assert(text != null),
        assert(author != null);

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      id: json['_id'] as String,
      text: json['quoteText'] as String,
      author: json['quoteAuthor'] as String,
    );
  }

  Map<String, String> toJson() {
    return {
      'id': id,
      'text': text,
      'author': author,
    };
  }
}
