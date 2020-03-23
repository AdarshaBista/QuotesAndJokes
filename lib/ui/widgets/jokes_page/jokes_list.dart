import 'package:flutter/material.dart';

import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:quotes_and_jokes/stores/jokes_store.dart';

import 'package:quotes_and_jokes/ui/widgets/jokes_page/joke_card.dart';
import 'package:quotes_and_jokes/ui/widgets/common/paginated_list_view.dart';

class JokesList extends StatelessWidget {
  final ReactiveModel<JokesStore> model;

  const JokesList({
    @required this.model,
  }) : assert(model != null);

  @override
  Widget build(BuildContext context) {
    return PaginatedListView(
      onRefresh: () async {
        await model.setState(
          (jokesStore) async {
            jokesStore.clear();
            return await jokesStore.fetch();
          },
        );
      },
      onLoadMore: () async {
        await model.state.fetch().then((_) => model.setState((_) => null));
      },
      itemBuilder: (_, index) => JokeCard(
        joke: model.state.jokes[index],
      ),
      hasError: model.state.hasError,
      hasMore: model.state.jokes.length < model.state.maxItems,
      itemCount: model.state.jokes.length,
      loadMoreOffset: 0.0,
    );
  }
}
