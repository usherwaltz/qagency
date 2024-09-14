import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../business_logic/blocs/blocs.dart';
import '../../../../../../utils/utils.dart';

class ThemeToggleWidget extends StatelessWidget {
  const ThemeToggleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ThemeBloc, ThemeState, ThemeMode>(
      selector: (state) => state.themeMode,
      builder: (context, themeMode) {
        return IconButton(
          onPressed: () {
            context.read<ThemeBloc>().add(const ThemeModeChanged());
          },
          icon: Icon(
            _getIcon(themeMode),
            color: context.theme.textTheme.displayMedium?.color,
          ),
        );
      },
    );
  }

  IconData _getIcon(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.system:
        return Icons.auto_mode;

      case ThemeMode.dark:
        return Icons.dark_mode;

      case ThemeMode.light:
        return Icons.light_mode;
    }
  }
}
