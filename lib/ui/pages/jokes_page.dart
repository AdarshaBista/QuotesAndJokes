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
          SliverAppBar(
            backgroundColor: Colors.white,
            elevation: 8.0,
            expandedHeight: 110.0,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              titlePadding: const EdgeInsets.all(8.0),
              title: Text(
                'JOKES',
                style: AppTextStyles.extraLargeDark,
              ),
            ),
          ),
        ],
        body: StateBuilder<JokesStore>(
          models: [
            Injector.getAsReactive<JokesStore>(),
          ],
          initState: (_, reactiveModel) async {
            await reactiveModel.setState((jokesProvider) async => await jokesProvider.fetchJokes());
          },
          builder: (_, reactiveModel) {
            return reactiveModel.whenConnectionState(
              onIdle: () => Center(child: CircularProgressIndicator()),
              onWaiting: () => Center(child: CircularProgressIndicator()),
              onData: (jokesProvider) => RefreshIndicator(
                onRefresh: () async {
                  await reactiveModel.setState((jokesProvider) async => await jokesProvider.fetchJokes());
                },
                child: ListView.builder(
                  itemCount: reactiveModel.state.jokes.length,
                  itemBuilder: (BuildContext context, int index) => JokeCard(
                    joke: reactiveModel.state.jokes[index],
                  ),
                ),
              ),
              onError: (_) => Icon(
                Icons.error_outline,
                size: 100.0,
                color: Colors.red,
              ),
            );
          },
        ),
      ),
    );
  }
}
