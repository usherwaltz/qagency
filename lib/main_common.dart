import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'blocs/blocs.dart';
import 'flavor_config.dart';
import 'l10n/generated/app_localizations.dart';
import 'router/router.dart';

Future<void> mainCommon() async {
  runApp(const QAgency());
}

class QAgency extends StatelessWidget {
  const QAgency({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeBloc>(
            create: (context) => ThemeBloc(),
          ),
          BlocProvider<MoviesBloc>(
            create: (context) => MoviesBloc(),
          ),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp.router(
              title: FlavorConfig.instance.values.appTitle,
              debugShowCheckedModeBanner: false,
              theme: state.palette.light,
              darkTheme: state.palette.dark,
              themeMode: state.themeMode,
              routerConfig: router,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
            );
          },
        ),
      ),
    );
  }
}
