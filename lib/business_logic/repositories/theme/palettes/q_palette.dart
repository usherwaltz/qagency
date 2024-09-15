import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_palette.dart';

abstract class QPalette {
  ThemeData get dark;
  ThemeData get light;
  ColorPalette get darkPalette;
  ColorPalette get lightPalette;

  static ThemeData _basePalette(ColorPalette palette) => ThemeData(
        fontFamily: 'SFPro',
        useMaterial3: true,
        scaffoldBackgroundColor: palette.backgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: palette.backgroundColor,
          surfaceTintColor: Colors.transparent,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: palette.bottomNavBarColor,
          selectedItemColor: palette.primary,
          unselectedItemColor: palette.text,
        ),
        iconTheme: IconThemeData(color: palette.text),
        cardColor: palette.primaryFaded,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll<Color>(palette.primary),
            textStyle: WidgetStatePropertyAll<TextStyle?>(
              TextStyle(
                color: palette.text,
              ),
            ),
          ),
        ),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            color: palette.text,
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
          ),
          headlineMedium: TextStyle(
            color: palette.text,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
          displayMedium: TextStyle(
            color: palette.text,
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
          displaySmall: TextStyle(
            color: palette.text,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
          labelLarge: TextStyle(
            color: palette.text,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
          labelMedium: TextStyle(
            color: palette.text,
            fontSize: 13.sp,
            fontWeight: FontWeight.w300,
          ),
          labelSmall: TextStyle(
            color: palette.chipTextColor,
            fontSize: 11.sp,
            fontWeight: FontWeight.w400,
          ),
          bodySmall: TextStyle(
            color: palette.text,
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      );

  static ThemeData baseLight(ColorPalette palette) {
    return _basePalette(palette).copyWith(
      brightness: Brightness.light,
    );
  }

  static ThemeData baseDark(ColorPalette palette) {
    return _basePalette(palette).copyWith(
      brightness: Brightness.dark,
    );
  }
}
