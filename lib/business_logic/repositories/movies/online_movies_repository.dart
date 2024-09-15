import 'dart:isolate';
import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../../../config/dio/dio_client.dart';
import '../../../config/dio/endpoints/endpoints.dart';
import '../../models/models.dart';
import 'movies.dart';

class OnlineMoviesRepository implements MoviesRepository {
  static final DioClient _dio = DioClient.instance;

  @override
  Future<MoviesListResponseModel> getPopular({
    required int page,
  }) async {
    try {
      final apiResponse = await _dio.get(
        MovieEndpoints.popular(page),
      );

      if (apiResponse.isSuccessful) {
        return MoviesListResponseModel.fromJson(apiResponse.data);
      }

      return const MoviesListResponseModel();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<GenreModel>> getGenres() async {
    try {
      final apiResponse = await _dio.get(
        MovieEndpoints.genres,
      );

      if (apiResponse.isSuccessful) {
        return GenresListResponseModel.fromJson(apiResponse.data).genres;
      }

      return [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Uint8List?> getPosterBytes({required String posterPath}) async {
    try {
      final apiResponse = await _dio.get(
        posterPath,
        options: Options(responseType: ResponseType.bytes),
      );

      if (apiResponse.isSuccessful) {
        // spawning isolate here to avoid ui jank
        return await Isolate.run<Uint8List>(() async {
          return Uint8List.fromList(apiResponse.data!);
        });
      }

      return null;
    } catch (e) {
      rethrow;
    }
  }
}
