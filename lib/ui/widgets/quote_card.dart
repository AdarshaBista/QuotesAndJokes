import 'package:flutter/material.dart';

import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:quotes_and_jokes/ui/shared/styles.dart';

import 'package:quotes_and_jokes/models/quote.dart';
import 'package:quotes_and_jokes/stores/quotes_store.dart';

import 'package:quotes_and_jokes/ui/widgets/ui_helper.dart';
import 'package:quotes_and_jokes/ui/widgets/favourite_icon.dart';

class QuoteCard extends StatelessWidget {
  final Quote quote;

  QuoteCard({
    @required this.quote,
  }) : assert(quote != null);

  @override
  Widget build(BuildContext context) {
    final List<String> searchTerms = quote.text.split(' ').where((word) => word.length > 4).toList()
      ..addAll(quote.author.split(' '));
    final String searchTerm = searchTerms.join(',');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 48.0),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(16.0),
        image: DecorationImage(
          image: NetworkImage('https://source.unsplash.com/800x800/?$searchTerm'),
          fit: BoxFit.cover,
          alignment: Alignment.centerRight,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.65), BlendMode.srcATop),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            quote.text,
            textAlign: TextAlign.left,
            style: AppTextStyles.extraLargeLight.copyWith(
              fontFamily: 'Sura',
              fontSize: 30.0,
            ),
          ),
          const SizedBox(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Text(
                  '- ${quote.author}',
                  style: AppTextStyles.mediumLight.copyWith(color: Colors.white70),
                  textAlign: TextAlign.left,
                  maxLines: 2,
                ),
              ),
              const SizedBox(width: 16.0),
              FavouriteIcon(
                color: AppColors.accent,
                isFavourite: quote.isFavourite,
                onPressed: () {
                  Injector.getAsReactive<QuotesStore>().setState(
                    (quotesStore) => quotesStore.toggleFavourite(quote),
                  );
                  UiHelper.showFavouriteStatus(
                      context, quote.isFavourite ? Colors.green : Colors.redAccent, quote.isFavourite);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
