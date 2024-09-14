import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../../../business_logic/blocs/blocs.dart';
import '../../../../../../business_logic/repositories/repositories.dart';
import '../../../../../../ui/widgets/widgets.dart';
import '../../../../../../utils/utils.dart';
import '../../widgets.dart';

class BodyWidget extends StatelessWidget {
  const BodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final palette =
        context.select<ThemeBloc, QPalette>((bloc) => bloc.state.palette);
    return BlocBuilder<FavouritesBloc, FavouritesState>(
      buildWhen: (p, c) => p.movies != c.movies,
      builder: (context, state) {
        return RefreshIndicator(
          color: palette.text,
          backgroundColor: palette.primary,
          onRefresh: () async {
            return context
                .read<MoviesBloc>()
                .add(const MoviesLoaded(refresh: true));
          },
          child: state.movies.isNotEmpty
              ? BlocBuilder<MoviesBloc, MoviesState>(
                  builder: (context, moviesState) {
                    return ListView.separated(
                      key: PageStorageKey<String>(HomeLayout.movies.name),
                      padding:
                          EdgeInsets.fromLTRB(16.0.sp, 0.0, 16.0.sp, 16.0.sp),
                      itemCount: state.movies.length,
                      separatorBuilder: (context, index) => Gap(20.0.sp),
                      itemBuilder: (context, index) {
                        final movie = state.movies[index];

                        final genres = movie.getGenres(moviesState.genres);

                        return MovieListItemWidget(
                            movie: movie, genres: genres);
                      },
                    );
                  },
                )
              : const QNoDataWidget(showRetry: false),
        );
      },
    );
  }
}
