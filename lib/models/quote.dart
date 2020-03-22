import 'package:flutter/material.dart';

class Quote {
  int localId;
  final String id;
  final String text;
  final String author;
  bool isFavourite;

  Quote({
    this.localId,
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
      localId: json['localId'],
      id: json['_id'] as String,
      text: json['quoteText'] as String,
      author: (json['quoteAuthor'] as String).isEmpty
          ? 'Unknown'
          : json['quoteAuthor'] as String,
      isFavourite: json['isFavourite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'localId': localId,
      '_id': id,
      'quoteText': text,
      'quoteAuthor': author,
      'isFavourite': isFavourite,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Quote && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
