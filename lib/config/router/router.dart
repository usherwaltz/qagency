import 'package:go_router/go_router.dart';

import '../../ui/screens/screens.dart';
import 'routes.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: Routes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: Routes.home,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
