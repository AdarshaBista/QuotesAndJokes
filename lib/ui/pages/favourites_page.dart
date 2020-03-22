import 'package:flutter/material.dart';

import 'package:states_rebuilder/states_rebuilder.dart';

import 'package:quotes_and_jokes/stores/jokes_store.dart';
import 'package:quotes_and_jokes/stores/quotes_store.dart';

import 'package:quotes_and_jokes/ui/widgets/joke_card.dart';
import 'package:quotes_and_jokes/ui/widgets/quote_card.dart';
import 'package:quotes_and_jokes/ui/widgets/empty_icon.dart';
import 'package:quotes_and_jokes/ui/widgets/favourites_tab_bar.dart';
import 'package:quotes_and_jokes/ui/widgets/collapsible_app_bar.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [
            const CollapsibleAppBar(
              elevation: 0.0,
              title: 'FAVOURITES',
              imageUrl: 'assets/images/favourites_header.png',
            ),
            const FavouritesTabBar(),
          ],
          body: TabBarView(
            children: <Widget>[
              _buildFavQuotes(),
              _buildFavJokes(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFavQuotes() {
    QuotesStore quotesStore = Injector.get<QuotesStore>();
    return quotesStore.favouriteQuotes.isEmpty
        ? const EmptyIcon()
        : ListView.builder(
            itemCount: quotesStore.favouriteQuotes.length,
            itemBuilder: (BuildContext context, int index) => QuoteCard(
              quote: quotesStore.favouriteQuotes[index],
            ),
          );
  }

  Widget _buildFavJokes() {
    JokesStore jokesStore = Injector.get<JokesStore>();
    return jokesStore.favouriteJokes.isEmpty
        ? const EmptyIcon()
        : ListView.builder(
            itemCount: jokesStore.favouriteJokes.length,
            itemBuilder: (BuildContext context, int index) => JokeCard(
              joke: jokesStore.favouriteJokes[index],
            ),
          );
  }
}
