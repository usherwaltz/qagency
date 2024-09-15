import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../../../assets/assets.dart';
import '../../../../../../business_logic/blocs/blocs.dart';
import '../../../../../../l10n/generated/app_localizations.dart';
import '../../../../../../utils/utils.dart';
import '../../../../../widgets/widgets.dart';

class BottomNavigationBarItemWidget extends StatelessWidget {
  const BottomNavigationBarItemWidget(this.tab, {super.key});

  final HomeLayout tab;

  void _onTap(BuildContext context) {
    context.read<HomeLayoutBloc>().add(HomeLayoutChanged(layout: tab));
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return BlocSelector<HomeLayoutBloc, HomeLayoutState, HomeLayout>(
      selector: (state) => state.layout,
      builder: (context, currentLayout) {
        // data for current tab
        final tabData = _TabData.get(
          tab: tab,
          context: context,
          strings: strings,
          currentLayout: currentLayout,
        );

        return Expanded(
          child: InkWell(
            onTap: () => _onTap(context),
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Stack(
                children: [
                  _buildIndicator(currentLayout, tabData),
                  _buildTab(context, tabData),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildIndicator(HomeLayout currentLayout, _TabData data) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: 110.sp,
        height: 2.0.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.0.sp),
          color: currentLayout == tab ? data.color : Colors.transparent,
        ),
      ),
    );
  }

  Widget _buildTab(BuildContext context, _TabData data) {
    return Positioned.fill(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          QSvgWidget(
            assetPath: data.iconPath,
            height: 24.sp,
            color: data.color,
          ),
          Gap(8.0.sp),
          Text(
            data.label,
            style: context.textTheme.displayMedium?.copyWith(
              color: data.color,
            ),
          ),
        ],
      ),
    );
  }
}

class _TabData {
  const _TabData({
    required this.label,
    required this.iconPath,
    required this.color,
  });

  final String label;
  final String iconPath;
  final Color color;

  factory _TabData.get({
    required BuildContext context,
    required AppLocalizations strings,
    required HomeLayout tab,
    required HomeLayout currentLayout,
  }) {
    final bottomNavTheme = context.theme.bottomNavigationBarTheme;

    final selectedColor = bottomNavTheme.selectedItemColor!;
    final unselectedColor = bottomNavTheme.unselectedItemColor!;

    final color = currentLayout == tab ? selectedColor : unselectedColor;

    switch (tab) {
      case HomeLayout.movies:
        return _TabData(
          label: strings.movies,
          iconPath: Assets.movie,
          color: color,
        );

      case HomeLayout.favourites:
        return _TabData(
          label: strings.favourites,
          iconPath: Assets.favouriteChecked,
          color: color,
        );
    }
  }
}
