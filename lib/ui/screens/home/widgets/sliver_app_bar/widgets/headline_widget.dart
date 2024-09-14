import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../business_logic/blocs/blocs.dart';
import '../../../../../../l10n/generated/app_localizations.dart';
import '../../../../../../utils/utils.dart';

class HeadlineWidget extends StatelessWidget implements PreferredSizeWidget {
  const HeadlineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return BlocSelector<HomeLayoutBloc, HomeLayoutState, HomeLayout>(
      selector: (state) => state.layout,
      builder: (context, layout) {
        String title;

        switch (layout) {
          case HomeLayout.movies:
            title = strings.popular;
            break;

          case HomeLayout.favourites:
            title = strings.favourites;
            break;
        }

        return Text(
          title,
          style: context.textTheme.headlineLarge,
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.sp);
}
