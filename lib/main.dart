import 'package:flutter/material.dart';

import 'package:quotes_and_jokes/models/joke.dart';
import 'package:quotes_and_jokes/models/quote.dart';

import 'package:quotes_and_jokes/services/joke_api_service.dart';
import 'package:quotes_and_jokes/services/quote_api_service.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  final QuoteApiService quoteApiService = QuoteApiService();
  final JokeApiService jokeApiService = JokeApiService();

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Joke joke;
  Quote quote;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quotes and Jokes',
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        fontFamily: 'RobotoSlab',
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Quotes and Jokes'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text('RANDOM JOKE'),
                onPressed: () async {
                  joke = await widget.jokeApiService.getRandom();
                  setState(() {});
                },
              ),
              if (joke != null)
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(joke.type == 'single' ? joke.joke : joke.setup + '\n' + joke.delivery),
                ),
              SizedBox(height: 16.0),
              Divider(thickness: 2.0),
              SizedBox(height: 16.0),
              FlatButton(
                child: Text('RANDOM QUOTE'),
                onPressed: () async {
                  quote = await widget.quoteApiService.getRandom();
                  setState(() {});
                },
              ),
              if (quote != null)
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('${quote.text} - ${quote.author}'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
