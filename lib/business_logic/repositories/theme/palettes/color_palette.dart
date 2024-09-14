import 'dart:ui';

class ColorPalette {
  const ColorPalette({
    required this.primary,
    required this.primaryFaded,
    required this.secondary,
    required this.text,
    required this.bottomNavBarColor,
    required this.backgroundColor,
    required this.chipTextColor,
  });

  final Color primary;
  final Color primaryFaded;
  final Color secondary;
  final Color text;
  final Color bottomNavBarColor;
  final Color backgroundColor;
  final Color chipTextColor;
}
