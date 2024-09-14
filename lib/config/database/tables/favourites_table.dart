import 'package:drift/drift.dart';

import 'tables.dart';

/// Defining this table because it allows me to override entries in the
/// [Movies] without worrying about if I'm gonna lose the favourite value.
class Favourites extends Table {
  @override
  String get tableName => 'favourites';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get movie => integer().references(Movies, #movieId)();
}
