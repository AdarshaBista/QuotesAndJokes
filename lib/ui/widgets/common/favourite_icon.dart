import 'package:flutter/material.dart';

class FavouriteIcon extends StatefulWidget {
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
  _FavouriteIconState createState() => _FavouriteIconState();
}

class _FavouriteIconState extends State<FavouriteIcon>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double _scale;

  @override
  Widget build(BuildContext context) {
    _scale = widget.isFavourite
        ? 1.0 + _animationController.value * 3.0
        : 1.0 - _animationController.value * 3.0;
    return GestureDetector(
      onTap: () {
        _animationController
            .forward()
            .then((_) => _animationController.reverse());
        widget.onPressed();
      },
      child: Transform.scale(
        scale: _scale,
        child: favIcon,
      ),
    );
  }

  Widget get favIcon => Icon(
        widget.isFavourite ? Icons.favorite : Icons.favorite_border,
        size: 24.0,
        color: widget.color,
      );
}
