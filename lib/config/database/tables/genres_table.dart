import 'package:drift/drift.dart';

class Genres extends Table {
  @override
  String get tableName => 'genres';

  IntColumn get id => integer()();
  TextColumn get name => text().withDefault(const Constant(''))();

  @override
  Set<Column> get primaryKey => {id};
}
