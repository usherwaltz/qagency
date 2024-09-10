import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../assets/assets.dart';
import '../../../ui/widgets/widgets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E1324),
      body: Center(
        child: QSvgAsset(
          assetPath: Assets.logo,
          height: 68.sp,
        ),
      ),
    );
  }
}
