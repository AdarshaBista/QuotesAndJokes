import 'package:flutter/material.dart';

class AppTextStyles {
  static const TextStyle _base = TextStyle(
    color: Colors.black,
    fontFamily: 'RobotoSlab',
  );

  // Dark
  static final TextStyle extraLargeDark = _base.copyWith(
    fontSize: 28.0,
    fontWeight: FontWeight.w700,
    letterSpacing: 1,
  );

  static final TextStyle largeDark = _base.copyWith(
    fontSize: 21.0,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle mediumDark = _base.copyWith(
    fontSize: 18.0,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle smallDark = _base.copyWith(
    color: Colors.black87,
    fontSize: 15.0,
    fontWeight: FontWeight.w200,
  );

  static final TextStyle extraSmallDark = _base.copyWith(
    color: Colors.black54,
    fontSize: 12.0,
    fontWeight: FontWeight.w200,
  );

  // Light
  static final TextStyle extraLargeLight = extraLargeDark.copyWith(
    color: Colors.white,
  );

  static final TextStyle largeLight = largeDark.copyWith(
    color: Colors.white,
  );

  static final TextStyle mediumLight = mediumDark.copyWith(
    color: Colors.white,
  );

  static final TextStyle smallLight = smallDark.copyWith(
    color: Colors.white70,
  );

  static final TextStyle extraSmallLight = extraSmallDark.copyWith(
    color: Colors.white54,
  );
}
