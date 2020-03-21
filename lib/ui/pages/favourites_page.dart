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

  StateBuilder<QuotesStore> _buildFavQuotes() {
    return StateBuilder(
      models: [Injector.getAsReactive<QuotesStore>()],
      builder: (_, ReactiveModel<QuotesStore> model) => model.state.favouriteQuotes.isEmpty
          ? const EmptyIcon()
          : ListView.builder(
              itemCount: model.state.favouriteQuotes.length,
              itemBuilder: (BuildContext context, int index) => QuoteCard(
                quote: model.state.favouriteQuotes[index],
              ),
            ),
    );
  }

  StateBuilder<JokesStore> _buildFavJokes() {
    return StateBuilder(
      models: [Injector.getAsReactive<JokesStore>()],
      builder: (_, ReactiveModel<JokesStore> model) => model.state.favouriteJokes.isEmpty
          ? const EmptyIcon()
          : ListView.builder(
              itemCount: model.state.favouriteJokes.length,
              itemBuilder: (BuildContext context, int index) => JokeCard(
                joke: model.state.favouriteJokes[index],
              ),
            ),
    );
  }
}
