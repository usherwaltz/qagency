part of 'theme_bloc.dart';

@Freezed(fromJson: false, toJson: false)
class ThemeState with _$ThemeState {
  const factory ThemeState({
    required QPalette palette,
    required ThemeMode themeMode,
  }) = _ThemeState;

  factory ThemeState.initial() {
    return ThemeState(
      palette: Blue(),
      themeMode: ThemeMode.system,
    );
  }
}
