import 'package:drift/drift.dart';

import '../../../../../config/database/app_database.dart';
import '../../../../../config/database/tables/tables.dart';
import '../../../../../utils/utils.dart';
import '../../../../business_logic/models/models.dart';

part 'genres_dao.g.dart';

@DriftAccessor(tables: [Genres])
class GenresDao extends DatabaseAccessor<AppDatabase> with _$GenresDaoMixin {
  GenresDao(super.db);

  Future<void> storeGenres(List<GenreModel> genreModels) async {
    try {
      logger.i('GenresDao :: storeGenres()');

      logger.i('Mapping genres');
      List<GenresCompanion> genreEntries = _getGenreCompanions(genreModels);

      logger.i('Inserting Genres', time: DateTime.now());
      await batch((batch) {
        batch.insertAllOnConflictUpdate(genres, genreEntries);
      });

      logger.i('SUCCESS :: Inserted Genres', time: DateTime.now());
    } catch (e) {
      rethrow;
    }
  }

  Future<List<GenreModel>> getGenres() async {
    try {
      return (await select(genres).get()).map((genre) {
        return genre.toGenreModel;
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  List<GenresCompanion> _getGenreCompanions(List<GenreModel> genres) {
    List<GenresCompanion> genreEntries = [];

    // map genres
    for (final genre in genres) {
      final companion = genre.getCompanion();

      genreEntries.add(companion);
    }

    return genreEntries;
  }
}
