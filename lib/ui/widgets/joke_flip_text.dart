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
      flipOnTouch: false,
      speed: 300,
      front: Container(
        child: Center(
          child: Text(
            joke.setup,
            style: AppTextStyles.largeDark,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      back: Container(
        child: Center(
          child: Text(
            joke.punchline,
            style: AppTextStyles.largeDark,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
