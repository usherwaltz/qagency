import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class QSvgWidget extends StatelessWidget {
  const QSvgWidget({
    super.key,
    required this.assetPath,
    this.color,
    this.height,
    this.width,
    this.boxFit = BoxFit.contain,
  });

  final String assetPath;
  final Color? color;
  final double? height;
  final double? width;
  final BoxFit boxFit;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetPath,
      colorFilter: _colorFilter,
      height: height,
      width: width,
      fit: boxFit,
    );
  }

  /// Using [BlendMode.srcIn] because there are no use cases elsewhere
  ColorFilter? get _colorFilter {
    if (color == null) return null;

    return ColorFilter.mode(
      color!,
      BlendMode.srcIn,
    );
  }
}
