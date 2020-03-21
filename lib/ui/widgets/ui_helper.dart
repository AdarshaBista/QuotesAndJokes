import 'package:flutter/material.dart';

import 'package:quotes_and_jokes/ui/shared/styles.dart';

class UiHelper {
  static void showFavouriteStatus(BuildContext context, Color bgColor, bool value) {
    String msg = value ? 'Added to favourites!' : 'Removed from favourites!';
    Color textColor = ThemeData.estimateBrightnessForColor(bgColor) == Brightness.light ? Colors.black : Colors.white;

    Scaffold.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 600),
        backgroundColor: bgColor,
        content: Row(
          children: <Widget>[
            Text(
              msg,
              style: AppTextStyles.smallDark.copyWith(color: textColor),
            ),
            const SizedBox(width: 12.0),
            Icon(
              value ? Icons.favorite : Icons.favorite_border,
              size: 20.0,
              color: textColor,
            ),
          ],
        ),
      ),
    );
  }
}
