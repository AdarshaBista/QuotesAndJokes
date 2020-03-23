import 'package:flutter/material.dart';

import 'package:quotes_and_jokes/models/favouritable.dart';

import 'package:quotes_and_jokes/services/db_service.dart';
import 'package:quotes_and_jokes/services/api_service.dart';

class BaseStore<T extends Favouritable> {
  final int maxItems;
  bool hasError;

  final Set<T> items = {};
  final List<T> favourites = [];

  final ApiService apiService;
  final DbService dbService;

  BaseStore({
    @required this.maxItems,
    @required this.hasError,
    @required this.apiService,
    @required this.dbService,
  }) {
    loadFavourites();
  }

  void loadFavourites() async {
    List<T> favs = await dbService.getFavourites();
    favourites.addAll(favs);
  }

  void toggleFavourite(T t) {
    t.isFavourite = !t.isFavourite;

    if (t.isFavourite) {
      favourites.insert(0, t);
      dbService.insert(t);
    } else {
      favourites.remove(t);
      dbService.delete(t);
    }
  }

  void clear() {
    items.clear();
  }

  Future<void> fetch() async {
    List<T> fetchedItems = await apiService.fetch();
    if (fetchedItems == null) {
      hasError = true;
      return;
    }

    hasError = false;
    fetchedItems.forEach((i) => i.isFavourite = favourites.contains(i));
    items.addAll(fetchedItems);
  }
}
