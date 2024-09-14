import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../assets/assets.dart';
import '../../business_logic/blocs/blocs.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../utils/utils.dart';
import 'widgets.dart';

class QNoDataWidget extends StatelessWidget {
  const QNoDataWidget({
    super.key,
    this.showRetry = true,
  });

  final bool showRetry;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Gap(100.sp),
          QSvgWidget(
            assetPath: Assets.logo,
            color: context.textTheme.headlineLarge?.color,
            height: 80.sp,
          ),
          Gap(20.0.sp),
          Text(
            strings.noData,
            textAlign: TextAlign.center,
            style: context.textTheme.headlineLarge,
          ),
          if (showRetry) ...[
            Gap(20.0.sp),
            ElevatedButton(
              onPressed: () {
                context
                    .read<MoviesBloc>()
                    .add(const MoviesLoaded(refresh: true));
              },
              child: Text(
                strings.retry,
                style: context.textTheme.displayMedium,
              ),
            )
          ],
        ],
      ),
    );
  }
}
