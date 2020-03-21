import 'package:flutter/material.dart';

import 'package:quotes_and_jokes/ui/shared/styles.dart';

import 'package:quotes_and_jokes/stores/jokes_store.dart';
import 'package:quotes_and_jokes/stores/quotes_store.dart';

import 'package:quotes_and_jokes/services/joke_api_service.dart';
import 'package:quotes_and_jokes/services/quote_api_service.dart';

import 'package:quotes_and_jokes/ui/pages/nav_page.dart';

import 'package:states_rebuilder/states_rebuilder.dart';

import 'dart:io';
import 'package:flutter/foundation.dart' show debugDefaultTargetPlatformOverride;

void _setTargetPlatformForDesktop() {
  TargetPlatform targetPlatform;
  if (Platform.isMacOS) {
    targetPlatform = TargetPlatform.iOS;
  } else if (Platform.isLinux || Platform.isWindows) {
    targetPlatform = TargetPlatform.android;
  }
  if (targetPlatform != null) {
    debugDefaultTargetPlatformOverride = targetPlatform;
  }
}

void main() {
  _setTargetPlatformForDesktop();
  runApp(App());
}

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
          Inject<JokesStore>(() => JokesStore(JokeApiService())),
          Inject<QuotesStore>(() => QuotesStore(QuoteApiService())),
        ],
        builder: (_) => NavPage(),
      ),
    );
  }
}
