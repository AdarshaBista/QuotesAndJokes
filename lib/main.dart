import 'package:flutter/material.dart';

import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:quotes_and_jokes/ui/shared/styles.dart';

import 'package:quotes_and_jokes/stores/jokes_store.dart';
import 'package:quotes_and_jokes/stores/quotes_store.dart';

import 'package:quotes_and_jokes/services/joke_db_service.dart';
import 'package:quotes_and_jokes/services/quote_db_service.dart';
import 'package:quotes_and_jokes/services/joke_api_service.dart';
import 'package:quotes_and_jokes/services/quote_api_service.dart';

import 'package:quotes_and_jokes/ui/pages/nav_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jokes and Quotes',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.primary,
        appBarTheme: AppBarTheme(
          brightness: Brightness.dark,
          color: AppColors.primary,
        ),
        fontFamily: 'Sen',
        brightness: Brightness.light,
        primaryColor: AppColors.primary,
        accentColor: AppColors.accent,
      ),
      home: Injector(
        inject: [
          Inject<JokeApiService>(() => JokeApiService()),
          Inject<JokeDbService>(() => JokeDbService()),
          Inject<QuoteDbService>(() => QuoteDbService()),
          Inject<QuoteApiService>(() => QuoteApiService()),
          Inject<JokesStore>(
            () => JokesStore(
              Injector.get<JokeApiService>(),
              Injector.get<JokeDbService>(),
            ),
          ),
          Inject<QuotesStore>(
            () => QuotesStore(
              Injector.get<QuoteApiService>(),
              Injector.get<QuoteDbService>(),
            ),
          ),
        ],
        builder: (_) => NavPage(),
      ),
    );
  }
}
