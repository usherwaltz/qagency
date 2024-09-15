import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../assets/assets.dart';
import '../../../../business_logic/models/models.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class HeadlineWidget extends StatelessWidget {
  const HeadlineWidget(this.movie, {super.key});

  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: context.textTheme.headlineMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Gap(8.sp),
                Row(
                  children: [
                    const QSvgWidget(assetPath: Assets.star),
                    Gap(4.sp),
                    Text(
                      strings.rating(movie.voteAverage.toStringAsFixed(1)),
                      style: context.textTheme.displaySmall,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Gap(16.sp),
        QFavouriteButtonWidget(movie),
      ],
    );
  }
}
