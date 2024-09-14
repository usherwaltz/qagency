part of 'app_bloc.dart';

@Freezed(fromJson: false, toJson: false)
class AppState with _$AppState {
  const factory AppState({
    @Default(BlocStateUIAction.none) BlocStateUIAction uiAction,
    @Default(BlocStateUIStatus.initial) BlocStateUIStatus uiStatus,
  }) = _AppState;

  factory AppState.initial() {
    return const AppState();
  }
}
