import 'dart:typed_data';

import '../../../config/database/app_database.dart';
import '../../../config/database/daos/daos.dart';
import '../../../utils/utils.dart';
import '../../models/models.dart';

class DatabaseRepository {
  static final AppDatabase _db = AppDatabase();

  Future<void> storeMovies(List<MovieModel> movies) async {
    try {
      await MoviesDao(_db).storeMovies(movies);
    } catch (e, stackTrace) {
      logger.e(
        'Failed to store movies',
        error: e,
        stackTrace: stackTrace,
        time: DateTime.now(),
      );
      rethrow;
    }
  }

  Future<void> storeGenres(List<GenreModel> genres) async {
    try {
      await GenresDao(_db).storeGenres(genres);
    } catch (e, stackTrace) {
      logger.e(
        'Failed to store genres',
        error: e,
        stackTrace: stackTrace,
        time: DateTime.now(),
      );
      rethrow;
    }
  }

  Future<List<GenreModel>> getGenres() async {
    try {
      return await GenresDao(_db).getGenres();
    } catch (e, stackTrace) {
      logger.e(
        'Failed to fetch genres',
        error: e,
        stackTrace: stackTrace,
        time: DateTime.now(),
      );
      rethrow;
    }
  }

  Future<MoviesListResponseModel> getMovies({required int page}) async {
    try {
      return await MoviesDao(_db).getMovies(page: page);
    } catch (e, stackTrace) {
      logger.e(
        'Failed to fetch movies',
        error: e,
        stackTrace: stackTrace,
        time: DateTime.now(),
      );
      rethrow;
    }
  }

  Future<void> storeFavourite(int movieId) async {
    try {
      await FavouritesDao(_db).storeFavourite(movieId);
    } catch (e, stackTrace) {
      logger.e(
        'Failed to store Favourite',
        error: e,
        stackTrace: stackTrace,
        time: DateTime.now(),
      );
      rethrow;
    }
  }

  Future<void> deleteFavourite(int movieId) async {
    try {
      await FavouritesDao(_db).deleteFavourite(movieId);
    } catch (e, stackTrace) {
      logger.e(
        'Failed to delete Favourite',
        error: e,
        stackTrace: stackTrace,
        time: DateTime.now(),
      );
      rethrow;
    }
  }

  Future<List<MovieModel>> getFavourites() async {
    try {
      return await FavouritesDao(_db).getFavourites();
    } catch (e, stackTrace) {
      logger.e(
        'Failed to fetch Favourites',
        error: e,
        stackTrace: stackTrace,
        time: DateTime.now(),
      );
      rethrow;
    }
  }

  Future<int?> storeMoviePoster(int movieId, Uint8List bytes) async {
    try {
      return await MoviesDao(_db).storeMoviePoster(movieId, bytes);
    } catch (e) {
      rethrow;
    }
  }

  Future<Uint8List?> getMoviePoster(int movieId) async {
    try {
      return await MoviesDao(_db).getMoviePoster(movieId);
    } catch (e) {
      rethrow;
    }
  }
}
