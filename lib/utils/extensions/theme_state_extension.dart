import 'package:flutter/material.dart';

import '../../business_logic/repositories/repositories.dart';
import 'extensions.dart';

extension ThemeStateExtension on QPalette {
  ColorPalette getColors(BuildContext context) {
    return context.isDark ? darkPalette : lightPalette;
  }
}
