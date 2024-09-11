import '../../dio/dio_client.dart';
import '../../dio/endpoints/endpoints.dart';
import '../../models/models.dart';

class MoviesRepository {
  static final DioClient _dio = DioClient();

  Future<MoviesListResponseModel> getPopular({
    required int page,
  }) async {
    final apiResponse = await _dio.get(
      MovieEndpoints.popular(page),
    );

    if (apiResponse.isSuccessful) {
      return MoviesListResponseModel.fromJson(apiResponse.data);
    }

    return const MoviesListResponseModel();
  }

  Future<List<GenreModel>> getGenres() async {
    final apiResponse = await _dio.get(
      MovieEndpoints.genres,
    );

    if (apiResponse.isSuccessful) {
      return GenresListResponseModel.fromJson(apiResponse.data).genres;
    }

    return [];
  }
}
