import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:qagency/utils/context_extension.dart';

import '../../../../assets/assets.dart';
import '../../../../blocs/blocs.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../widgets/widgets.dart';
import 'widgets.dart';

class BodyWidget extends StatelessWidget {
  const BodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              automaticallyImplyLeading: true,
              title: QSvgWidget(
                assetPath: Assets.logo,
                height: 28.sp,
              ),
              forceElevated: innerBoxIsScrolled,
              actions: const [ThemeToggleWidget()],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.0.sp, 0.0, 16.0.sp, 20.0.sp),
              child: Text(
                strings.popular,
                style: context.textTheme.headlineLarge,
              ),
            ),
          )
        ];
      },
      body: BlocBuilder<MoviesBloc, MoviesState>(
        builder: (context, state) {
          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
            itemCount: state.movies.length,
            separatorBuilder: (context, index) => Gap(20.0.sp),
            itemBuilder: (context, index) {
              final movie = state.movies[index];
              final genres = movie.getGenres(state.genres);

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: movie.posterPath,
                    fit: BoxFit.cover,
                    height: 100.sp,
                    width: 100.sp,
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
                                        '${movie.voteAverage.toStringAsFixed(1)} / 10 IMDb',
                                        style: context.textTheme.displaySmall,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            QSvgWidget(
                              assetPath: Assets.favouriteEmpty,
                              height: 24.sp,
                            ),
                          ],
                        ),
                        Gap(12.sp),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: IntrinsicHeight(
                            child: Wrap(
                              spacing: 4.sp,
                              runSpacing: 4.sp,
                              clipBehavior: Clip.hardEdge,
                              children: genres.map((genre) {
                                return QChipWidget(genre.name);
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
