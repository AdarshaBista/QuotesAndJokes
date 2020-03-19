import 'package:flutter/material.dart';

class Quote {
  final String id;
  final String text;
  final String author;
  bool isFavourite;

  Quote({
    @required this.id,
    @required this.text,
    @required this.author,
    @required this.isFavourite,
  })  : assert(id != null),
        assert(text != null),
        assert(author != null),
        assert(isFavourite != null);

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      id: json['_id'] as String,
      text: json['quoteText'] as String,
      author: json['quoteAuthor'] as String,
      isFavourite: json['isFavourite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'author': author,
      'isFavourite': isFavourite,
    };
  }
}
