import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../business_logic/models/models.dart';
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
    GoRoute(
      path: Routes.movieDetails,
      pageBuilder: (context, state) {
        final movie = state.extra! as MovieModel;

        return _slideFromBottomTransition(
          key: state.pageKey,
          child: MovieDetailsScreen(movie),
        );
      },
    ),
  ],
);

CustomTransitionPage _slideFromBottomTransition({
  required LocalKey? key,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: key,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0); // Start from the bottom
      const end = Offset.zero; // End at the top
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
