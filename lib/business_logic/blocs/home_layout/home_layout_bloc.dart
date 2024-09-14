import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/utils.dart';

part 'home_layout_bloc.freezed.dart';
part 'home_layout_event.dart';
part 'home_layout_state.dart';

class HomeLayoutBloc extends Bloc<HomeLayoutEvent, HomeLayoutState> {
  HomeLayoutBloc() : super(HomeLayoutState.initial()) {
    on<HomeLayoutChanged>(_onHomeLayoutChanged);
  }

  void _onHomeLayoutChanged(
    HomeLayoutChanged event,
    Emitter<HomeLayoutState> emit,
  ) {
    emit(state.copyWith(
      layout: event.layout,
    ));
  }
}
