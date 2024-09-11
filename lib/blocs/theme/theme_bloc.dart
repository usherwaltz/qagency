import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../repositories/theme/palettes/palettes.dart';

part 'theme_bloc.freezed.dart';
part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.initial()) {
    on<ThemeLoaded>(_onThemeLoaded);
    on<ThemeModeChanged>(_onThemeModeChanged);
  }

  void _onThemeLoaded(
    ThemeLoaded event,
    Emitter<ThemeState> emit,
  ) {
    emit(state.copyWith());
  }

  void _onThemeModeChanged(
    ThemeModeChanged event,
    Emitter<ThemeState> emit,
  ) {
    final newValue = state.themeMode.index + 1;

    final newMode = newValue > ThemeMode.values.length - 1
        ? ThemeMode.values[0]
        : ThemeMode.values[newValue];

    emit(state.copyWith(themeMode: newMode));
  }
}
