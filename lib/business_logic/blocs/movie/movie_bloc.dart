import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/utils.dart';
import '../../repositories/repositories.dart';

part 'movie_bloc.freezed.dart';
part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final DatabaseRepository _databaseRepository = DatabaseRepository();
  static late MoviesRepository _moviesRepository;
  bool _initialized = false;

  MovieBloc() : super(MovieState.initial()) {
    _connectionListener();
    on<MoviePosterFetched>(_onMoviePosterFetched);
  }

  void _setRepository(bool isOnline) {
    _moviesRepository =
        isOnline ? OnlineMoviesRepository() : OfflineMoviesRepository();
  }

  Future<void> _connectionListener() async {
    if (!_initialized) {
      final isOnline = await ConnectionUtil.instance.hasInternetConnection();
      _setRepository(isOnline);
      _initialized = true;
    }

    ConnectionUtil.instance.connectionStream.listen((bool event) {
      _setRepository(event);
    });
  }

  Future<void> _onMoviePosterFetched(
    MoviePosterFetched event,
    Emitter<MovieState> emit,
  ) async {
    try {
      if (!_initialized) await _connectionListener();
      emit(state.copyWith(uiStatus: BlocStateUIStatus.loading));

      // Try to fetch image from localDB
      final localImage = await _databaseRepository.getMoviePoster(
        event.movieId,
      );

      if (localImage != null) {
        emit(state.copyWith(
          uiStatus: BlocStateUIStatus.loaded,
          bytes: localImage,
        ));
        return;
      }

      // If the user is offline emit error
      if (_moviesRepository is OfflineMoviesRepository) {
        emit(state.copyWith(uiStatus: BlocStateUIStatus.error));
      }

      final image = await _moviesRepository.getPosterBytes(
        posterPath: event.posterPath,
      );

      if (image == null) {
        emit(state.copyWith(uiStatus: BlocStateUIStatus.error));
      }

      emit(state.copyWith(
        uiStatus: BlocStateUIStatus.loaded,
        bytes: image,
      ));

      await _storePoster(event.movieId, image!);
    } catch (e) {
      emit(state.copyWith(uiStatus: BlocStateUIStatus.error));
      logger.e(
        'Failed to load poster data for path :: ${event.posterPath}',
        error: e,
      );
      return;
    }
  }

  Future<void> _storePoster(
    int movieId,
    Uint8List image,
  ) async {
    try {
      await _databaseRepository.storeMoviePoster(movieId, image);
    } catch (e) {
      logger.e(
        'Failed to save poster for movie id :: $movieId',
        error: e,
      );
      return;
    }
  }
}
