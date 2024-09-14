import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'business_logic/blocs/blocs.dart';
import 'config/flavor_config.dart';
import 'config/router/router.dart';
import 'l10n/generated/app_localizations.dart';

Future<void> mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();
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
            lazy: false,
            create: (context) => ThemeBloc()..add(const ThemeLoaded()),
          ),
          BlocProvider<MoviesBloc>(
            lazy: false,
            create: (context) => MoviesBloc(),
          ),
          BlocProvider(
            create: (context) => HomeLayoutBloc(),
          ),
          BlocProvider(
            create: (context) => FavouritesBloc(),
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
