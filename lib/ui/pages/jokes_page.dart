import 'package:flutter/material.dart';

import 'package:states_rebuilder/states_rebuilder.dart';

import 'package:quotes_and_jokes/stores/jokes_store.dart';

import 'package:quotes_and_jokes/ui/widgets/jokes_page/jokes_list.dart';
import 'package:quotes_and_jokes/ui/widgets/indicators/error_icon.dart';
import 'package:quotes_and_jokes/ui/widgets/common/collapsible_app_bar.dart';

class JokesPage extends StatelessWidget {
  const JokesPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, _) => [
          const CollapsibleAppBar(
            title: 'JOKES',
            imageUrl: 'assets/images/jokes_header.png',
          ),
        ],
        body: StateBuilder<JokesStore>(
          models: [Injector.getAsReactive<JokesStore>()],
          initState: (_, model) async {
            await model
                .setState((jokesStore) async => await jokesStore.fetch());
          },
          builder: (_, model) {
            return model.whenConnectionState(
              onIdle: () => const Center(child: CircularProgressIndicator()),
              onWaiting: () => const Center(child: CircularProgressIndicator()),
              onData: (_) => JokesList(model: model),
              onError: (_) => const ErrorIcon(),
            );
          },
        ),
      ),
    );
  }
}
