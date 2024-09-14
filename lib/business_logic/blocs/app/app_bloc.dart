import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../config/dio/dio_client.dart';
import '../../../utils/utils.dart';

part 'app_bloc.freezed.dart';
part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState.initial()) {
    on<AppInitialized>(_onAppInitialized);
  }

  Future<void> _onAppInitialized(
    AppInitialized event,
    Emitter<AppState> emit,
  ) async {
    try {
      logger.i('AppInitialized()');

      await Future.wait([
        ConnectionUtil.instance.initialize(),
        DioClient.instance.initialize(),
        SharedPreferencesUtil.instance.initialize(),
      ]);

      emit(state.copyWith(
        uiAction: BlocStateUIAction.navigateToNext,
      ));
    } catch (e, stackTrace) {
      logger.e(
        'Failed to initialize app',
        error: e,
        stackTrace: stackTrace,
      );
      emit(state.copyWith(uiStatus: BlocStateUIStatus.error));
    }
  }
}
