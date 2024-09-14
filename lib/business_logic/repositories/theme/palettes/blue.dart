import 'package:flutter/material.dart';

import 'color_palette.dart';
import 'q_palette.dart';

class Blue implements QPalette {
  Blue();

  @override
  ColorPalette get darkPalette {
    return ColorPalette(
      primary: const Color(0xFFEC9B3E),
      primaryFaded: const Color(0xFFEC9B3E).withOpacity(0.2),
      secondary: const Color(0xFFF2CF16),
      text: const Color(0xFFE4ECEF),
      bottomNavBarColor: const Color(0xFF010510),
      backgroundColor: const Color(0xFF0E1324),
      chipTextColor: const Color(0xFFFFFFFF),
    );
  }

  @override
  ColorPalette get lightPalette {
    return ColorPalette(
      primary: const Color(0xFF253899),
      primaryFaded: const Color(0xFF253899).withOpacity(0.2),
      secondary: const Color(0xFFF2CF16),
      text: const Color(0xFF3A3D46),
      bottomNavBarColor: const Color(0xFFF8F8FA),
      backgroundColor: const Color(0xFFFFFFFF),
      chipTextColor: const Color(0xFFFFFFFF),
    );
  }

  @override
  ThemeData get dark {
    return QPalette.baseDark(darkPalette);
  }

  @override
  ThemeData get light {
    return QPalette.baseLight(lightPalette).copyWith(
      cardColor: lightPalette.primary,
    );
  }
}
