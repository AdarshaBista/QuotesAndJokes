import 'package:flutter/material.dart';

import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:quotes_and_jokes/ui/shared/styles.dart';

import 'package:quotes_and_jokes/stores/jokes_store.dart';

import 'package:quotes_and_jokes/ui/widgets/joke_card.dart';

class JokesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [
          _buildAppBar(),
        ],
        body: StateBuilder<JokesStore>(
          models: [
            Injector.getAsReactive<JokesStore>(),
          ],
          initState: (_, model) async {
            await model.setState((jokesStore) async => await jokesStore.fetchJokes());
          },
          builder: (_, model) {
            return model.whenConnectionState(
              onIdle: () => Center(child: CircularProgressIndicator()),
              onWaiting: () => Center(child: CircularProgressIndicator()),
              onData: (_) => _buildJokesList(model),
              onError: (_) => _buildErrorIcon(),
            );
          },
        ),
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      pinned: true,
      elevation: 8.0,
      expandedHeight: 140.0,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        titlePadding: const EdgeInsets.all(16.0),
        title: Text(
          'JOKES',
          style: AppTextStyles.extraLargeLight,
        ),
        background: Padding(
          padding: const EdgeInsets.only(left: 60.0, right: 60.0, top: 20.0),
          child: Image.asset(
            'assets/images/jokes_header.png',
            color: AppColors.secondary,
            alignment: Alignment.centerRight,
          ),
        ),
      ),
    );
  }

  RefreshIndicator _buildJokesList(ReactiveModel<JokesStore> model) {
    return RefreshIndicator(
      onRefresh: () async {
        await model.setState((js) async => await js.fetchJokes());
      },
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: model.state.jokes.length,
        itemBuilder: (BuildContext context, int index) => JokeCard(
          joke: model.state.jokes[index],
        ),
      ),
    );
  }

  Center _buildErrorIcon() {
    return Center(
      child: Icon(
        Icons.error_outline,
        size: 100.0,
        color: Colors.red,
      ),
    );
  }
}
