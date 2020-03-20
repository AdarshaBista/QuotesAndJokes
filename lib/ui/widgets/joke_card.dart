import 'package:flutter/material.dart';

import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:quotes_and_jokes/ui/shared/styles.dart';

import 'package:quotes_and_jokes/models/joke.dart';
import 'package:quotes_and_jokes/stores/jokes_store.dart';

import 'package:flip_card/flip_card.dart';
import 'package:quotes_and_jokes/ui/widgets/tag.dart';
import 'package:quotes_and_jokes/ui/widgets/favourite_icon.dart';
import 'package:quotes_and_jokes/ui/widgets/joke_flip_text.dart';

class JokeCard extends StatelessWidget {
  final Joke joke;
  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  JokeCard({
    @required this.joke,
  }) : assert(joke != null);

  @override
  Widget build(BuildContext context) {
    Color accent = AppColors.accentColors[joke.id % AppColors.accentColors.length];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: AppColors.secondary,
      ),
      child: Column(
        children: <Widget>[
          JokeFlipText(
            joke: joke,
            cardKey: cardKey,
          ),
          Divider(
            color: accent.withOpacity(0.3),
            height: 24.0,
          ),
          Row(
            children: <Widget>[
              Tag(
                label: joke.type,
                color: accent,
              ),
              const SizedBox(width: 16.0),
              FavouriteIcon(
                isFavourite: joke.isFavourite,
                color: accent,
                onPressed: () {
                  Injector.getAsReactive<JokesStore>().setState(
                    (jokesStore) => jokesStore.toggleFavourite(joke),
                  );
                  _showSnackBar(context, accent);
                },
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => cardKey.currentState.toggleCard(),
                child: Icon(
                  Icons.compare_arrows,
                  size: 24.0,
                  color: accent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, Color bgColor) {
    String msg = joke.isFavourite ? 'Added to favourites!' : 'Removed from favourites!';
    Color textColor = ThemeData.estimateBrightnessForColor(bgColor) == Brightness.light ? Colors.black : Colors.white;

    Scaffold.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 600),
        backgroundColor: bgColor,
        content: Row(
          children: <Widget>[
            Text(
              msg,
              style: AppTextStyles.smallDark.copyWith(color: textColor),
            ),
            const SizedBox(width: 12.0),
            Icon(
              joke.isFavourite ? Icons.favorite : Icons.favorite_border,
              size: 20.0,
              color: textColor,
            ),
          ],
        ),
      ),
    );
  }
}
