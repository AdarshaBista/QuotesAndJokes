import 'package:flutter/material.dart';

abstract class Favouritable {
  int localId;
  bool isFavourite;

  Favouritable({
    this.localId,
    @required this.isFavourite,
  }) : assert(isFavourite != null);

  Map<String, dynamic> toJson();
}
