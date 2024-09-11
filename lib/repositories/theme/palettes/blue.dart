import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qagency/ui/widgets/q_svg_widget.dart';

import '../../../assets/assets.dart';
import 'q_palette.dart';

class Blue implements QPalette {
  const Blue();

  static const Color _primary = Color(0xFFEC9B3E);
  static final Color _primaryFaded = const Color(0xFFEC9B3E).withOpacity(0.2);
  static const Color _secondary = Color(0xFFF2CF16);
  static const Color _text = Color(0xFFE4ECEF);
  static const Color _bottomNavBarColor = Color(0xFF010510);

  @override
  ThemeData get dark {
    return QPalette.baseDark.copyWith(
      scaffoldBackgroundColor: const Color(0xFF0E1324),
      appBarTheme: QPalette.baseDark.appBarTheme.copyWith(
        backgroundColor: const Color(0xFF0E1324),
      ),
      bottomNavigationBarTheme:
          QPalette.baseDark.bottomNavigationBarTheme.copyWith(
        backgroundColor: _bottomNavBarColor,
      ),
      iconTheme: QPalette.baseDark.iconTheme.copyWith(
        color: _text,
      ),
      actionIconTheme: QPalette.baseDark.actionIconTheme?.copyWith(
        backButtonIconBuilder: (context) {
          return QSvgWidget(
            assetPath: Assets.back,
            width: 16.sp,
          );
        },
      ),
      cardColor: _primaryFaded,
      textTheme: QPalette.baseDark.textTheme.copyWith(
        headlineLarge: QPalette.baseDark.textTheme.headlineLarge?.copyWith(
          color: _text,
          fontSize: 22.sp,
          fontWeight: FontWeight.w600,
        ),
        displayMedium: QPalette.baseDark.textTheme.displayMedium?.copyWith(
          color: _text,
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
        ),
        displaySmall: QPalette.baseDark.textTheme.displaySmall?.copyWith(
          color: _text,
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
        ),
        labelSmall: QPalette.baseDark.textTheme.labelSmall?.copyWith(
          color: _text,
          fontSize: 11.sp,
          fontWeight: FontWeight.w400,
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
