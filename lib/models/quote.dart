import 'package:flutter/material.dart';

import 'package:quotes_and_jokes/models/favouritable.dart';

class Quote extends Favouritable {
  final String id;
  final String text;
  final String author;

  Quote({
    localId,
    @required isFavourite,
    @required this.id,
    @required this.text,
    @required this.author,
  })  : assert(id != null),
        assert(text != null),
        assert(author != null),
        assert(isFavourite != null),
        super(
          localId: localId,
          isFavourite: isFavourite,
        );

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

  @override
  Map<String, dynamic> toJson() {
    return {
      'localId': localId,
      'isFavourite': isFavourite,
      '_id': id,
      'quoteText': text,
      'quoteAuthor': author,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Quote && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
