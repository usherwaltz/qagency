part of 'favourites_bloc.dart';

@Freezed(fromJson: false, toJson: false)
class FavouritesState with _$FavouritesState {
  const factory FavouritesState({
    @Default(BlocStateUIStatus.initial) BlocStateUIStatus uiStatus,
    @Default([]) List<MovieModel> movies,
  }) = _FavouritesState;

  factory FavouritesState.initial() {
    return const FavouritesState();
  }
}
