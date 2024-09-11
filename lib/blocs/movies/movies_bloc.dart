import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qagency/utils/enums.dart';
import 'package:qagency/utils/logger.dart';

import '../../models/models.dart';
import '../../repositories/repositories.dart';

part 'movies_bloc.freezed.dart';
part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc() : super(MoviesState.initial()) {
    on<MoviesLoaded>(_onMoviesLoaded);
  }

  static final MoviesRepository _moviesRepository = MoviesRepository();
  int _page = 1;

  Future<void> _onMoviesLoaded(
    MoviesLoaded event,
    Emitter<MoviesState> emit,
  ) async {
    logger.i('Movies Loaded');
    emit(state.copyWith(uiStatus: BlocStateUIStatus.loading));
    final page = event.refresh ? _page = 1 : _page += 1;
    List<MovieModel> movies = List.from(state.movies);
    List<GenreModel> genres = List.from(state.genres);

    final moviesResponse = await _moviesRepository.getPopular(page: page);
    movies.addAll(moviesResponse.results);
    genres = await _moviesRepository.getGenres();

    emit(state.copyWith(
      uiStatus: BlocStateUIStatus.loaded,
      movies: movies,
      totalPages: moviesResponse.totalPages,
      genres: genres,
    ));
  }
}
