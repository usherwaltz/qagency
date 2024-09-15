import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../assets/assets.dart';
import '../../../business_logic/blocs/blocs.dart';
import '../../../config/router/routes.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return BlocProvider(
      lazy: false,
      create: (context) => AppBloc()..add(const AppInitialized()),
      child: BlocConsumer<AppBloc, AppState>(
        listener: (context, state) {
          if (state.uiAction == BlocStateUIAction.navigateToNext) {
            context.go(Routes.home);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  QSvgWidget(
                    assetPath: Assets.logo,
                    height: 80.sp,
                  ),
                  if (state.uiStatus == BlocStateUIStatus.error) ...[
                    Gap(20.sp),
                    Text(
                      strings.somethingWentWrong,
                      style: context.textTheme.headlineLarge,
                    ),
                    Gap(20.0.sp),
                    ElevatedButton(
                      style: context.theme.elevatedButtonTheme.style?.copyWith(
                        backgroundColor: WidgetStatePropertyAll(
                          context.theme.colorScheme.error,
                        ),
                      ),
                      onPressed: () {
                        context.read<AppBloc>().add(const AppInitialized());
                      },
                      child: Text(
                        strings.retry,
                        style: context.textTheme.displayMedium,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
