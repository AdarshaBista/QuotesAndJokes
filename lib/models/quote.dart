import 'package:flutter/material.dart';

import 'package:quotes_and_jokes/models/favouritable.dart';

class Quote extends Favouritable {
  final String text;
  final String author;

  Quote({
    localId,
    @required isFavourite,
    @required this.text,
    @required this.author,
  })  : assert(text != null),
        assert(author != null),
        assert(isFavourite != null),
        super(
          localId: localId,
          isFavourite: isFavourite,
        );

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      localId: json['localId'],
      text: json['text'] as String,
      author: (json['author'] as String).isEmpty
          ? 'Unknown'
          : json['author'] as String,
      isFavourite: json['isFavourite'] ?? false,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'author': author,
      'localId': localId,
      'isFavourite': isFavourite,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Quote && runtimeType == other.runtimeType;

  @override
  int get hashCode => text.hashCode ^ author.hashCode;
}
