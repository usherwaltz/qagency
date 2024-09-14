import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../../assets/assets.dart';
import '../../../../../business_logic/blocs/blocs.dart';
import '../../../../../business_logic/repositories/repositories.dart';
import '../../../../../l10n/generated/app_localizations.dart';
import '../../../../../utils/utils.dart';
import '../../../../widgets/widgets.dart';

class BottomNavigationBarItemWidget extends StatelessWidget {
  const BottomNavigationBarItemWidget(this.layout, {super.key});

  final HomeLayout layout;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final currentLayout = context.select<HomeLayoutBloc, HomeLayout>(
      (bloc) => bloc.state.layout,
    );

    final palette = context.select<ThemeBloc, ColorPalette>(
      (bloc) => bloc.state.palette.getColors(context),
    );

    final color = _getColor(currentLayout, palette);

    return Expanded(
      child: InkWell(
        onTap: () {
          context.read<HomeLayoutBloc>().add(HomeLayoutChanged(layout: layout));
        },
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 110.sp,
                  height: 2.0.sp,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.0.sp),
                    color: currentLayout == layout ? palette.primary : Colors.transparent,
                  ),
                ),
              ),
              Positioned.fill(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    QSvgWidget(
                      assetPath: _getIcon(),
                      height: 24.sp,
                      color: color,
                    ),
                    Gap(8.0.sp),
                    Text(
                      _getLabel(strings),
                      style: context.textTheme.displayMedium?.copyWith(
                        color: color,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getIcon() {
    return layout == HomeLayout.movies ? Assets.movie : Assets.favouriteChecked;
  }

  String _getLabel(AppLocalizations strings) {
    switch (layout) {
      case HomeLayout.movies:
        return strings.movies;

      case HomeLayout.favourites:
        return strings.favourites;
    }
  }

  Color _getColor(
    HomeLayout currentLayout,
    ColorPalette palette,
  ) {
    return currentLayout == layout ? palette.primary : palette.text;
  }
}
