import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qagency/l10n/generated/app_localizations.dart';
import 'package:qagency/ui/widgets/q_connection_wrapper_widget.dart';

import '../../../../../utils/utils.dart';
import '../widgets.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 60.sp,
          color: context.theme.bottomNavigationBarTheme.backgroundColor,
          child: const Row(
            children: [
              BottomNavigationBarItemWidget(HomeLayout.movies),
              BottomNavigationBarItemWidget(HomeLayout.favourites),
            ],
          ),
        ),
        QConnectionWrapperWidget(
          child: Container(
            color: Theme.of(context).colorScheme.error,
            height: 20.sp,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text(
                strings.offline,
                style: context.textTheme.bodySmall,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
