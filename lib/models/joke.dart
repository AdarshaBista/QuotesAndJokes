import 'package:flutter/material.dart';

class Joke {
  final int id;
  final String type;
  final String setup;
  final String punchline;
  bool isFavourite;

  Joke({
    @required this.id,
    @required this.type,
    @required this.setup,
    @required this.punchline,
    @required this.isFavourite,
  })  : assert(id != null),
        assert(type != null),
        assert(setup != null),
        assert(punchline != null),
        assert(isFavourite != null);

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      id: json['id'] as int,
      type: json['type'] as String,
      setup: json['setup'] as String,
      punchline: json['punchline'] as String,
      isFavourite: json['isFavourite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'setup': setup,
      'punchline': punchline,
      'isFavourite': isFavourite,
    };
  }
}
