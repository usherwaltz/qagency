import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/utils.dart';
import '../../repositories/theme/theme_repository.dart';

part 'theme_bloc.freezed.dart';
part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.initial()) {
    on<ThemeLoaded>(_onThemeLoaded);
    on<ThemeModeChanged>(_onThemeModeChanged);
  }

  Future<void> _onThemeLoaded(
    ThemeLoaded event,
    Emitter<ThemeState> emit,
  ) async {
    final storedMode = await SharedPreferencesUtil.instance.getString(
      Constants.themeMode,
    );

    if (storedMode == null) return;

    emit(state.copyWith(
      themeMode: _stringToMode(storedMode),
    ));
  }

  Future<void> _onThemeModeChanged(
    ThemeModeChanged event,
    Emitter<ThemeState> emit,
  ) async {
    final newValue = state.themeMode.index + 1;

    final newMode = newValue > ThemeMode.values.length - 1
        ? ThemeMode.values[0]
        : ThemeMode.values[newValue];

    SharedPreferencesUtil.instance.setString(Constants.themeMode, newMode.name);

    emit(state.copyWith(themeMode: newMode));
  }

  ThemeMode _stringToMode(String mode) {
    switch (mode.toLowerCase()) {
      case 'dark':
        return ThemeMode.dark;

      case 'light':
        return ThemeMode.light;

      default:
        return ThemeMode.system;
    }
  }
}
