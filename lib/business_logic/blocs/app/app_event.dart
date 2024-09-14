part of 'app_bloc.dart';

@Freezed(fromJson: false, toJson: false, copyWith: false, equal: false)
class AppEvent with _$AppEvent {
  const factory AppEvent.initialized() = AppInitialized;
}
