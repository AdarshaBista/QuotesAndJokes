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
    Color cardColor = AppColors.cardColors[joke.id % AppColors.cardColors.length];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          colors: [
            cardColor.withOpacity(0.4),
            cardColor.withOpacity(0.2),
          ],
        ),
      ),
      child: Column(
        children: <Widget>[
          JokeFlipText(
            cardKey: cardKey,
            joke: joke,
          ),
          Divider(
            color: cardColor.withOpacity(0.2),
            height: 20.0,
          ),
          Row(
            children: <Widget>[
              Tag(
                label: joke.type,
                color: cardColor,
              ),
              const Spacer(),
              FavouriteIcon(
                isFavourite: joke.isFavourite,
                color: cardColor,
                onPressed: () {
                  Injector.getAsReactive<JokesStore>().setState(
                    (jokesStore) => jokesStore.toggleFavourite(joke),
                  );
                  _showSnackBar(context, cardColor);
                },
              ),
              const SizedBox(width: 16.0),
              GestureDetector(
                onTap: () => cardKey.currentState.toggleCard(),
                child: Icon(
                  Icons.arrow_forward,
                  size: 20.0,
                  color: cardColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, Color cardColor) {
    String msg = joke.isFavourite ? 'Added to favourites!' : 'Removed from favourites!';
    Color textColor = ThemeData.estimateBrightnessForColor(cardColor) == Brightness.light ? Colors.black : Colors.white;

    Scaffold.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 600),
        backgroundColor: cardColor,
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
