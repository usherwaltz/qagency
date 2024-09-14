part of 'theme_bloc.dart';

@Freezed(toJson: false, fromJson: false, copyWith: false, equal: false)
class ThemeEvent with _$ThemeEvent {
  const factory ThemeEvent() = _ThemeEvent;

  const factory ThemeEvent.loaded() = ThemeLoaded;

  const factory ThemeEvent.modeChanged() = ThemeModeChanged;
}
