import 'package:flutter/material.dart';

import 'package:sembast/sembast.dart';

import 'package:quotes_and_jokes/database/app_db.dart';

import 'package:quotes_and_jokes/models/favouritable.dart';

abstract class DbService<T extends Favouritable> {
  final StoreRef<int, Map<String, dynamic>> dbStore;
  Future<Database> get _db async => await AppDatabase.instance.database;

  DbService({
    @required this.dbStore,
  }) : assert(dbStore != null);

  Future<bool> insert(T t) async {
    int key = await dbStore.add(
      await _db,
      t.toJson(),
    );
    if (key == null) return false;

    t.localId = key;
    return true;
  }

  Future<void> delete(T t) async {
    await dbStore.delete(
      await _db,
      finder: Finder(
        filter: Filter.byKey(t.localId),
      ),
    );
  }

  Future<List<T>> getFavourites() async {
    final recordSnapshots = await dbStore.find(
      await _db,
    );

    List<T> favourites = parseJson(recordSnapshots);

    print('${T.toString()} => ' + favourites.length.toString());
    return favourites..sort((a, b) => b.localId.compareTo(a.localId));
  }

  List<T> parseJson(
      List<RecordSnapshot<int, Map<String, dynamic>>> recordSnapshots);
}
