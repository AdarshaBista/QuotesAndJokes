import 'package:flutter/material.dart';

class Joke {
  final int id;
  final bool error;
  final String type;
  final String category;
  final String joke;
  final String setup;
  final String delivery;

  Joke({
    @required this.id,
    @required this.error,
    @required this.type,
    @required this.category,
    this.joke,
    this.setup,
    this.delivery,
  })  : assert(id != null),
        assert(error != null),
        assert(type != null),
        assert(category != null),
        assert(joke != null || (setup != null && delivery != null));

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      id: json['id'] as int,
      error: json['error'] as bool,
      type: json['type'] as String,
      category: json['category'] as String,
      joke: json['joke'] as String,
      setup: json['setup'] as String,
      delivery: json['delivery'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'error': error,
      'type': type,
      'category': category,
      'joke': joke,
      'setup': setup,
      'delivery': delivery,
    };
  }
}
