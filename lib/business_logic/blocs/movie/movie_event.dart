part of 'movie_bloc.dart';

@Freezed(toJson: false, fromJson: false, equal: false, copyWith: false)
class MovieEvent with _$MovieEvent {
  const factory MovieEvent.posterFetched({
    required int movieId,
    required String posterPath,
  }) = MoviePosterFetched;
}
