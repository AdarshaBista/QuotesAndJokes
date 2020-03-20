import 'package:flutter/material.dart';

import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:quotes_and_jokes/stores/jokes_store.dart';

import 'package:quotes_and_jokes/ui/widgets/joke_card.dart';

class JokesList extends StatefulWidget {
  final ReactiveModel<JokesStore> model;

  const JokesList({
    @required this.model,
  }) : assert(model != null);

  @override
  _JokesListState createState() => _JokesListState();
}

class _JokesListState extends State<JokesList> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() async {
        if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
          await widget.model.state.fetchJokes();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: _scrollController,
        physics: BouncingScrollPhysics(),
        itemCount: widget.model.state.jokes.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == widget.model.state.jokes.length)
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          return JokeCard(
            joke: widget.model.state.jokes[index],
          );
        });
  }
}
