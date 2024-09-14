part of 'favourites_bloc.dart';

@Freezed(fromJson: false, toJson: false, equal: false, copyWith: false)
class FavouritesEvent with _$FavouritesEvent {
  const factory FavouritesEvent.loaded() = FavouritesLoaded;

  const factory FavouritesEvent.updated({
    required MovieModel movie,
  }) = FavouritesUpdated;
}
