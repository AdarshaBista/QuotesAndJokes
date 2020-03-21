import 'package:flutter/material.dart';

import 'package:states_rebuilder/states_rebuilder.dart';

import 'package:quotes_and_jokes/stores/quotes_store.dart';

import 'package:quotes_and_jokes/ui/widgets/error_icon.dart';
import 'package:quotes_and_jokes/ui/widgets/quotes_list.dart';
import 'package:quotes_and_jokes/ui/widgets/collapsible_app_bar.dart';

class QuotesPage extends StatelessWidget {
  const QuotesPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [
          const CollapsibleAppBar(
            title: 'QUOTES',
            imageUrl: 'assets/images/quotes_header.png',
          ),
        ],
        body: StateBuilder<QuotesStore>(
          models: [
            Injector.getAsReactive<QuotesStore>(),
          ],
          initState: (_, model) async {
            await model.setState((jokesStore) async => await jokesStore.fetchQuote());
          },
          builder: (_, model) {
            return model.whenConnectionState(
              onIdle: () => Center(child: CircularProgressIndicator()),
              onWaiting: () => Center(child: CircularProgressIndicator()),
              onData: (_) => QuotesList(model: model),
              onError: (_) => const ErrorIcon(),
            );
          },
        ),
      ),
    );
  }
}
