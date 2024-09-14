import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:qagency/l10n/generated/app_localizations.dart';
import 'package:qagency/utils/utils.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget(this.description, {super.key});

  final String description;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          strings.description,
          style: context.textTheme.displayMedium,
        ),
        Gap(8.sp),
        Text(
          description,
          style: context.textTheme.labelMedium,
        )
      ],
    );
  }
}
