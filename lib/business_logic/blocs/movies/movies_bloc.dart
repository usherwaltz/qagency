import 'dart:async';
import 'dart:collection';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/utils.dart';
import '../../models/models.dart';
import '../../repositories/repositories.dart';

part 'movies_bloc.freezed.dart';
part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  static final _databaseRepository = DatabaseRepository();
  static late MoviesRepository _moviesRepository;
  bool _initialized = false;

  MoviesBloc() : super(MoviesState.initial()) {
    _connectionListener();
    on<MoviesLoaded>(_onMoviesLoaded);
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

  Future<void> _onMoviesLoaded(
    MoviesLoaded event,
    Emitter<MoviesState> emit,
  ) async {
    try {
      logger.i('MoviesLoaded()');

      // determine current status and emit
      final uiStatus = event.refresh
          ? BlocStateUIStatus.loading
          : BlocStateUIStatus.loadingMore;
      emit(state.copyWith(uiStatus: uiStatus));

      Set<MovieModel> moviesSet = LinkedHashSet<MovieModel>.from(state.movies);
      Set<GenreModel> genresSet = LinkedHashSet<GenreModel>.from(state.genres);

      // clear if refreshing data
      if (event.refresh) {
        moviesSet.clear();
        genresSet.clear();
      }

      // determine page and fetch data
      final page = event.refresh ? 1 : state.page + 1;
      final results = await Future.wait([
        _moviesRepository.getPopular(page: page),
        _moviesRepository.getGenres(),
      ]);

      // map data and add to copy
      final moviesResponse = results[0] as MoviesListResponseModel;
      final genresResponse = results[1] as List<GenreModel>;

      // populate / update sets and emit as lists to state
      moviesSet.addAll(moviesResponse.results);
      genresSet.addAll(genresResponse);

      emit(state.copyWith(
        uiStatus: BlocStateUIStatus.loaded,
        movies: moviesSet.toList(),
        totalPages: moviesResponse.totalPages,
        page: page,
        genres: genresSet.toList(),
      ));

      await _storeMoviesAndGenresToDatabase(
        moviesResponse.results,
        genresResponse,
      );
    } catch (e, stackTrace) {
      logger.e(
        'Failed to Load Movies',
        error: e,
        stackTrace: stackTrace,
      );

      emit(state.copyWith(uiStatus: BlocStateUIStatus.error));
    }
  }

  Future<void> _storeMoviesAndGenresToDatabase(
    List<MovieModel> movies,
    List<GenreModel> genres,
  ) async {
    try {
      // if offline, do nothing, else store / update movies to local DB
      if (_moviesRepository is OfflineMoviesRepository) return;

      await Future.wait([
        _databaseRepository.storeMovies(movies),
        _databaseRepository.storeGenres(genres),
      ]);
    } catch (e) {
      rethrow;
    }
  }
}
