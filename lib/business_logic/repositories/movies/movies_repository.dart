import 'dart:typed_data';

import '../../models/models.dart';

abstract class MoviesRepository {
  Future<MoviesListResponseModel> getPopular({
    required int page,
  });

  Future<List<GenreModel>> getGenres();

  Future<Uint8List?> getPosterBytes({required String posterPath});
}
