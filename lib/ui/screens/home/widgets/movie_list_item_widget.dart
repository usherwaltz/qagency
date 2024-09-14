import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:qagency/config/router/routes.dart';

import '../../../../assets/assets.dart';
import '../../../../business_logic/models/models.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class MovieListItemWidget extends StatelessWidget {
  const MovieListItemWidget({
    required this.movie,
    required this.genres,
    super.key,
  });

  final MovieModel movie;
  final List<GenreModel> genres;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () => context.push(Routes.movieDetails, extra: movie),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0.sp),
            child: QImageWidget(
              movie: movie,
              fit: BoxFit.cover,
              height: 100.sp,
              width: 100.sp,
            ),
          ),
          Gap(16.0.sp),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.displayMedium,
                          ),
                          Gap(4.0.sp),
                          Row(
                            children: [
                              QSvgWidget(
                                assetPath: Assets.star,
                                height: 16.sp,
                              ),
                              Gap(4.0.sp),
                              Text(
                                strings.rating(
                                    movie.voteAverage.toStringAsFixed(1)),
                                style: context.textTheme.displaySmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    QFavouriteButtonWidget(movie),
                  ],
                ),
                Gap(12.sp),
                QGenresChipListWidget(genres),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
