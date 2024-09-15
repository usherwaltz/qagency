import 'dart:typed_data';

import '../../models/models.dart';
import '../repositories.dart';

class OfflineMoviesRepository implements MoviesRepository {
  static final _databaseRepository = DatabaseRepository();

  @override
  Future<List<GenreModel>> getGenres() async {
    try {
      return await _databaseRepository.getGenres();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MoviesListResponseModel> getPopular({required int page}) async {
    try {
      return await _databaseRepository.getMovies(page: page);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Uint8List?> getPosterBytes({required String posterPath}) async {
    try {
      return Uint8List(0);
    } catch (e) {
      rethrow;
    }
  }
}
