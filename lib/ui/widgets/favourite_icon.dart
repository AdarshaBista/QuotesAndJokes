import 'package:flutter/material.dart';

class FavouriteIcon extends StatelessWidget {
  final Color color;
  final bool isFavourite;
  final Function onPressed;

  const FavouriteIcon({
    @required this.color,
    @required this.onPressed,
    @required this.isFavourite,
  })  : assert(color != null),
        assert(onPressed != null),
        assert(isFavourite != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Icon(
        isFavourite ? Icons.favorite : Icons.favorite_border,
        size: 24.0,
        color: color,
      ),
    );
  }
}
