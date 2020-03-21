import 'package:flutter/material.dart';

import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:quotes_and_jokes/stores/jokes_store.dart';

import 'package:quotes_and_jokes/ui/widgets/joke_card.dart';
import 'package:quotes_and_jokes/ui/widgets/error_icon.dart';

class JokesList extends StatelessWidget {
  final ReactiveModel<JokesStore> model;

  const JokesList({
    @required this.model,
  }) : assert(model != null);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (sn) {
        if (sn.metrics.pixels == sn.metrics.maxScrollExtent) {
          model.state.fetchJokes().then((_) => model.setState((_) => null));
        }
        return true;
      },
      child: RefreshIndicator(
        onRefresh: () async {
          await model.setState((jokesStore) async {
            jokesStore.clearJokes();
            return await jokesStore.fetchJokes();
          });
        },
        child: ListView.builder(
          itemCount: model.state.jokes.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == model.state.jokes.length)
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            return JokeCard(
              joke: model.state.jokes[index],
            );
          },
        ),
      ),
    );
  }
}
