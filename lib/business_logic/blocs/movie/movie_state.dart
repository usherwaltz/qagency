part of 'movie_bloc.dart';

@Freezed(toJson: false, fromJson: false)
class MovieState with _$MovieState {
  const factory MovieState({
    @Default(BlocStateUIStatus.initial) BlocStateUIStatus uiStatus,
    Uint8List? bytes,
  }) = _MovieState;

  factory MovieState.initial() {
    return const MovieState(
      bytes: null,
    );
  }
}
