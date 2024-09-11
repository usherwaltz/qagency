import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qagency/utils/context_extension.dart';

class QChipWidget extends StatelessWidget {
  const QChipWidget(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(4.sp),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 4.sp),
      child: Text(
        text,
        style: context.textTheme.labelSmall,
      ),
    );
  }
}
