part of 'home_layout_bloc.dart';

@Freezed(toJson: false, fromJson: false, equal: false, copyWith: false)
class HomeLayoutEvent with _$HomeLayoutEvent {
  const factory HomeLayoutEvent.changed({
    required HomeLayout layout,
  }) = HomeLayoutChanged;
}
