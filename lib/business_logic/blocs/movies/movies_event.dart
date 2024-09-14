part of 'movies_bloc.dart';

@Freezed(fromJson: false, toJson: false, equal: false, copyWith: false)
class MoviesEvent with _$MoviesEvent {
  const factory MoviesEvent.loaded({
    @Default(false) bool refresh,
  }) = MoviesLoaded;
}
