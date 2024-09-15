import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../assets/assets.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../utils/utils.dart';
import 'q_svg_widget.dart';

class QErrorWidget extends StatelessWidget {
  const QErrorWidget({
    this.buttonCallback,
    super.key,
  });

  final VoidCallback? buttonCallback;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Gap(100.sp),
          QSvgWidget(
            assetPath: Assets.logo,
            color: context.theme.colorScheme.error,
            height: 80.sp,
          ),
          Gap(16.sp),
          Text(
            strings.somethingWentWrong,
            style: context.textTheme.displayMedium,
          ),
          if (buttonCallback != null) ...[
            Gap(20.0.sp),
            ElevatedButton(
              style: context.theme.elevatedButtonTheme.style?.copyWith(
                backgroundColor: WidgetStatePropertyAll(
                  context.theme.colorScheme.error,
                ),
              ),
              onPressed: buttonCallback,
              child: Text(
                strings.retry,
                style: context.textTheme.displayMedium,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
