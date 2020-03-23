import 'package:flutter/material.dart';

import 'package:quotes_and_jokes/models/favouritable.dart';

class Joke extends Favouritable {
  final int id;
  final String type;
  final String setup;
  final String punchline;

  Joke({
    localId,
    @required isFavourite,
    @required this.id,
    @required this.type,
    @required this.setup,
    @required this.punchline,
  })  : assert(id != null),
        assert(type != null),
        assert(setup != null),
        assert(punchline != null),
        assert(isFavourite != null),
        super(
          localId: localId,
          isFavourite: isFavourite,
        );

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      localId: json['localId'],
      id: json['id'] as int,
      type: json['type'] as String,
      setup: json['setup'] as String,
      punchline: json['punchline'] as String,
      isFavourite: json['isFavourite'] ?? false,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'localId': localId,
      'isFavourite': isFavourite,
      'id': id,
      'type': type,
      'setup': setup,
      'punchline': punchline,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Joke && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
