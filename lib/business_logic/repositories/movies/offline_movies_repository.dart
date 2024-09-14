import 'dart:typed_data';

import '../../models/models.dart';
import '../repositories.dart';

class OfflineMoviesRepository implements MoviesRepository {
  static final _databaseRepository = DatabaseRepository();

  @override
  Future<List<GenreModel>> getGenres() async {
    return await _databaseRepository.getGenres();
  }

  @override
  Future<MoviesListResponseModel> getPopular({required int page}) async {
    return await _databaseRepository.getMovies(page: page);
  }

  @override
  Future<Uint8List?> getPosterBytes({required String posterPath}) async {
    return Uint8List(0);
  }
}
