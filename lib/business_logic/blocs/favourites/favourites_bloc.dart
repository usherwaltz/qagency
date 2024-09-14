import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/utils.dart';
import '../../models/models.dart';
import '../../repositories/repositories.dart';

part 'favourites_bloc.freezed.dart';
part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  static final _databaseRepository = DatabaseRepository();

  FavouritesBloc() : super(FavouritesState.initial()) {
    on<FavouritesLoaded>(_onFavouritesLoaded);
    on<FavouritesSaved>(_onFavouritesSaved);
  }

  Future<void> _onFavouritesLoaded(
    FavouritesLoaded event,
    Emitter<FavouritesState> emit,
  ) async {
    try {
      logger.i('FavouritesLoaded()');
      emit(state.copyWith(uiStatus: BlocStateUIStatus.loading));
      final movies = await _databaseRepository.getFavourites();

      emit(state.copyWith(
        uiStatus: BlocStateUIStatus.loaded,
        movies: movies,
      ));
    } catch (e) {
      emit(state.copyWith(uiStatus: BlocStateUIStatus.error));
    }
  }

  Future<void> _onFavouritesSaved(
    FavouritesSaved event,
    Emitter<FavouritesState> emit,
  ) async {
    try {
      logger.i('Favourites Saved :: Movie => ${event.movie}');

      Set<MovieModel> movies = List<MovieModel>.from(state.movies).toSet();

      if (movies.contains(event.movie)) {
        await _databaseRepository.deleteFavourite(event.movie.id);
        movies.remove(event.movie);
      } else {
        await _databaseRepository.storeFavourite(event.movie.id);
        movies.add(event.movie);
      }

      emit(state.copyWith(movies: movies.toList()));
    } catch (e) {
      emit(state.copyWith(
        uiStatus: BlocStateUIStatus.error,
      ));
    }
  }
}
