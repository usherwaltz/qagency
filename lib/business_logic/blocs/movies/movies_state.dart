part of 'movies_bloc.dart';

@Freezed(fromJson: false, toJson: false)
class MoviesState with _$MoviesState {
  const factory MoviesState({
    @Default(BlocStateUIStatus.initial) BlocStateUIStatus uiStatus,
    @Default([]) List<MovieModel> movies,
    @Default(0) int totalPages,
    @Default(1) int page,
    @Default([]) List<GenreModel> genres,
  }) = _MoviesState;

  factory MoviesState.initial() {
    return const MoviesState();
  }
}
