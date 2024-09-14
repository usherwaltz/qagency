import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../../../business_logic/blocs/blocs.dart';
import '../../../../../../business_logic/models/models.dart';
import '../../../../../../business_logic/repositories/repositories.dart';
import '../../../../../../ui/widgets/widgets.dart';
import '../../../../../../utils/utils.dart';
import '../../widgets.dart';

class BodyWidget extends StatelessWidget {
  const BodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = context.select<ThemeBloc, ColorPalette>((bloc) {
      return bloc.state.palette.getColors(context);
    });

    final genres = context
        .select<MoviesBloc, List<GenreModel>>((bloc) => bloc.state.genres);

    return BlocBuilder<FavouritesBloc, FavouritesState>(
      buildWhen: (p, c) => p.movies != c.movies,
      builder: (context, state) {
        return RefreshIndicator(
          color: Colors.white,
          backgroundColor: palette.primary,
          onRefresh: () async {
            return context.read<FavouritesBloc>().add(const FavouritesLoaded());
          },
          child: state.movies.isNotEmpty
              ? ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  key: PageStorageKey<String>(HomeLayout.movies.name),
                  padding: EdgeInsets.fromLTRB(16.0.sp, 0.0, 16.0.sp, 16.0.sp),
                  itemCount: state.movies.length,
                  separatorBuilder: (context, index) => Gap(20.0.sp),
                  itemBuilder: (context, index) {
                    final movie = state.movies[index];

                    return MovieListItemWidget(
                      key: ValueKey(movie.id),
                      movie: movie,
                      genres: movie.getGenres(genres),
                    );
                  },
                )
              : const QNoDataWidget(showRetry: false),
        );
      },
    );
  }
}
