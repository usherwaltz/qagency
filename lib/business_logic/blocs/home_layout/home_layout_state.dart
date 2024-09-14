part of 'home_layout_bloc.dart';

@Freezed(fromJson: false, toJson: false)
class HomeLayoutState with _$HomeLayoutState {
  const factory HomeLayoutState({
    @Default(HomeLayout.movies) HomeLayout layout,
  }) = _HomeLayoutState;

  factory HomeLayoutState.initial() {
    return const HomeLayoutState();
  }
}
