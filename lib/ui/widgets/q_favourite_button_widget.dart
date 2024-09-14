import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qagency/utils/utils.dart';

import '../../assets/assets.dart';
import '../../business_logic/blocs/blocs.dart';
import '../../business_logic/models/models.dart';
import '../../business_logic/repositories/repositories.dart';
import 'widgets.dart';

class QFavouriteButtonWidget extends StatelessWidget {
  const QFavouriteButtonWidget(this.movie, {super.key});

  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    final palette = context.select<ThemeBloc, ColorPalette>((bloc) {
      return bloc.state.palette.getColors(context);
    });
    return BlocSelector<FavouritesBloc, FavouritesState, bool>(
      selector: (state) => state.movies.any((e) => e.id == movie.id),
      builder: (context, isFavourite) {
        return GestureDetector(
          onTap: () {
            context.read<FavouritesBloc>().add(FavouritesUpdated(movie: movie));
          },
          child: QSvgWidget(
            assetPath:
                isFavourite ? Assets.favouriteFilled : Assets.favouriteEmpty,
            height: 24.sp,
            color: isFavourite ? palette.primary : palette.text,
          ),
        );
      },
    );
  }
}
