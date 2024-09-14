import 'package:drift/drift.dart';

import '../../../../../business_logic/models/models.dart';
import '../../../../../config/database/app_database.dart';
import '../../../../../config/database/tables/tables.dart';
import '../../../../../utils/utils.dart';

part 'favourites_dao.g.dart';

@DriftAccessor(tables: [Favourites])
class FavouritesDao extends DatabaseAccessor<AppDatabase>
    with _$FavouritesDaoMixin {
  FavouritesDao(super.db);

  Future<void> storeFavourite(int movieId) async {
    try {
      logger.i('Saving Favourite :: Movie ID => $movieId');
      final companion = FavouritesCompanion(
        movie: Value(movieId),
      );

      await into(favourites).insertOnConflictUpdate(companion);

      logger.i('SUCCESS :: Favourite saved Movie ID => $movieId');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteFavourite(int movieId) async {
    try {
      logger.i('Deleting Favourite :: Movie ID => $movieId');
      await (delete(favourites)..where((t) => t.movie.equals(movieId))).go();
      logger.i('SUCCESS :: Favourite removed Movie ID => $movieId');
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MovieModel>> getFavourites() async {
    try {
      logger.i('Fetching Favourites');
      final query = select(db.movies).join([
        innerJoin(favourites, db.favourites.movie.equalsExp(db.movies.movieId)),
      ]);

      final result = await query.get();

      return result.map((row) {
        final movie = row.readTable(db.movies);
        return movie.toMovieModel;
      }).toList();
    } catch (e) {
      rethrow;
    }
  }
}
