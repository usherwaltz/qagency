import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'q_palette.dart';

class Blue implements QPalette {
  Blue();

  @override
  Color primary = const Color(0xFFEC9B3E);

  @override
  Color primaryFaded = const Color(0xFFEC9B3E).withOpacity(0.2);

  @override
  Color secondary = const Color(0xFFF2CF16);

  @override
  Color text = const Color(0xFFE4ECEF);

  @override
  Color bottomNavBarColor = const Color(0xFF010510);

  @override
  Color backgroundColor = const Color(0xFF0E1324);

  @override
  ThemeData get dark {
    return QPalette.baseDark.copyWith(
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: QPalette.baseDark.appBarTheme.copyWith(
        backgroundColor: backgroundColor,
        surfaceTintColor: Colors.transparent,
      ),
      bottomNavigationBarTheme:
          QPalette.baseDark.bottomNavigationBarTheme.copyWith(
        backgroundColor: bottomNavBarColor,
      ),
      iconTheme: QPalette.baseDark.iconTheme.copyWith(
        color: text,
      ),
      cardColor: primaryFaded,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll<Color>(primary),
          textStyle: WidgetStatePropertyAll<TextStyle?>(
            TextStyle(
              color: text,
            ),
          ),
        ),
      ),
      textTheme: QPalette.baseDark.textTheme.copyWith(
        headlineLarge: QPalette.baseDark.textTheme.headlineLarge?.copyWith(
          color: text,
          fontSize: 22.sp,
          fontWeight: FontWeight.w600,
        ),
        displayMedium: QPalette.baseDark.textTheme.displayMedium?.copyWith(
          color: text,
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
        ),
        displaySmall: QPalette.baseDark.textTheme.displaySmall?.copyWith(
          color: text,
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
        ),
        labelSmall: QPalette.baseDark.textTheme.labelSmall?.copyWith(
          color: text,
          fontSize: 11.sp,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: QPalette.baseDark.textTheme.bodySmall?.copyWith(
          color: text,
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  ThemeData get light {
    return QPalette.baseLight.copyWith(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: QPalette.baseDark.appBarTheme.copyWith(
        backgroundColor: const Color(0xFF0E1324),
      ),
    );
  }
}
