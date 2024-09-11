import 'package:dio/dio.dart';
import 'package:qagency/dio/dio_client.dart';

import '../../models/models.dart';

class MoviesRepository {
  static final Dio _dio = DioClient().dio;

  Future<MoviesListResponseModel> getPopular({
    required int page,
  }) async {
    final result = await _dio.get(
      'https://api.themoviedb.org/3/movie/popular?language=en_US&page=$page',
    );

    return MoviesListResponseModel.fromJson(result.data);
  }

  Future<List<GenreModel>> getGenres() async {
    final result = await _dio.get(
      'https://api.themoviedb.org/3/genre/movie/list',
    );

    return GenresListResponseModel.fromJson(result.data).genres;
  }
}
