import 'package:flutter/material.dart';

abstract class QPalette {
  ThemeData get dark;
  ThemeData get light;

  static final ThemeData _basePalette = ThemeData(
    fontFamily: 'SFPro',
    useMaterial3: true,
  );

  static ThemeData baseLight = _basePalette.copyWith(
    brightness: Brightness.light,
  );

  static ThemeData baseDark = _basePalette.copyWith(
    brightness: Brightness.dark,
  );
}
