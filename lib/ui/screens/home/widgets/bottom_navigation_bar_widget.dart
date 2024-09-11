import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../assets/assets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _currentIndex = Constants.homeTabIndex;

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return Container(
      height: 60.sp,
      color: context.theme.bottomNavigationBarTheme.backgroundColor,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => _onTabSelected(Constants.homeTabIndex),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  QSvgWidget(
                    assetPath: Assets.movie,
                    height: 24.sp,
                    color: _currentIndex == Constants.homeTabIndex
                        ? Colors.red
                        : Colors.white,
                  ),
                  Gap(8.0.sp),
                  Text(
                    strings.movies,
                    style: context.textTheme.displayMedium?.copyWith(
                      color: _currentIndex == Constants.homeTabIndex
                          ? Colors.red
                          : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => _onTabSelected(Constants.favouritesTabIndex),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  QSvgWidget(
                    assetPath: Assets.favouriteChecked,
                    height: 24.sp,
                    color: _currentIndex == Constants.favouritesTabIndex
                        ? Colors.red
                        : Colors.white,
                  ),
                  Gap(8.0.sp),
                  Text(
                    strings.favourites,
                    style: context.textTheme.displayMedium?.copyWith(
                      color: _currentIndex == Constants.favouritesTabIndex
                          ? Colors.red
                          : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
