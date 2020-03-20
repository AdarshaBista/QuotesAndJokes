import 'package:flutter/material.dart';

import 'package:quotes_and_jokes/ui/shared/styles.dart';

import 'package:quotes_and_jokes/models/joke.dart';

import 'package:flip_card/flip_card.dart';

class JokeFlipText extends StatelessWidget {
  final Joke joke;
  final GlobalKey<FlipCardState> cardKey;

  const JokeFlipText({
    @required this.cardKey,
    @required this.joke,
  })  : assert(joke != null),
        assert(cardKey != null);

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      key: cardKey,
      flipOnTouch: true,
      speed: 300,
      front: Container(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            joke.setup,
            style: AppTextStyles.mediumLight,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      back: Container(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            joke.punchline,
            style: AppTextStyles.mediumLight,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
