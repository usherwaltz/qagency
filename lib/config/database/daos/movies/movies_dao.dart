import 'package:drift/drift.dart';

import '../../../../../config/database/app_database.dart';
import '../../../../../config/database/tables/tables.dart';
import '../../../../../utils/utils.dart';
import '../../../../business_logic/models/models.dart';

part 'movies_dao.g.dart';

@DriftAccessor(tables: [Movies])
class MoviesDao extends DatabaseAccessor<AppDatabase> with _$MoviesDaoMixin {
  MoviesDao(super.db);

  Future<void> storeMovies(List<MovieModel> movieModels) async {
    try {
      logger.i('MoviesDao :: storeMovies()');

      logger.i('Mapping movies');
      List<MoviesCompanion> movieEntries =
          await _getMovieCompanions(movieModels);

      logger.i('Inserting Movies', time: DateTime.now());
      await transaction(() async {
        for (final entry in movieEntries) {
          final exists = await (select(movies)
                ..where((movies) => movies.movieId.equals(entry.movieId.value)))
              .getSingleOrNull();

          if (exists != null) continue;

          await into(movies).insertOnConflictUpdate(entry);
        }
      });

      logger.i('SUCCESS :: Inserted Movies', time: DateTime.now());
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<MoviesCompanion>> _getMovieCompanions(
    List<MovieModel> movies,
  ) async {
    List<MoviesCompanion> movieEntries = [];

    for (final movie in movies) {
      final companion = await movie.toCompanion();

      movieEntries.add(companion);
    }

    return movieEntries;
  }

  Future<MoviesListResponseModel> getMovies({required int page}) async {
    try {
      final query = select(movies)
        ..where((e) => e.posterBlob.isNotNull())
        ..limit(20, offset: (page - 1) * 20);

      final results = await Future.wait([
        query.get(),
        _getMoviesCount(),
      ]);

      final movieResults = results[0] as List<Movie>;
      final totalPages = results[1] as int;

      final moviesList = movieResults.map((e) {
        return e.toMovieModel;
      }).toList();

      return MoviesListResponseModel(
        page: page,
        totalPages: totalPages,
        totalResults: movieResults.length,
        results: moviesList,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<int> _getMoviesCount() async {
    try {
      final countQuery = await (selectOnly(movies)
            ..addColumns([movies.id.count()]))
          .getSingle();

      return countQuery.read(movies.id.count()) ?? 0;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> storeMoviePoster(int movieId, Uint8List bytes) async {
    try {
      final companion = MoviesCompanion(
        movieId: Value(movieId),
        posterBlob: Value(bytes),
      );

      return await (update(movies)..where((e) => e.movieId.equals(movieId)))
          .write(companion);
    } catch (e) {
      rethrow;
    }
  }

  Future<Uint8List?> getMoviePoster(int movieId) async {
    try {
      final query = select(movies)..where((e) => e.movieId.equals(movieId));

      final movie = await query.getSingle();

      return movie.posterBlob;
    } catch (e) {
      logger.w('No image in local DB');
      return null;
    }
  }
}
