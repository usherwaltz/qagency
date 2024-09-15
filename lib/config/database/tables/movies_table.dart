import 'dart:convert';

import 'package:drift/drift.dart';

@DataClassName('Movie')
class Movies extends Table {
  @override
  String get tableName => 'movies';

  IntColumn get id => integer().autoIncrement()();
  BoolColumn get adult => boolean().withDefault(const Constant(true))();
  TextColumn get backdropPath => text()();
  TextColumn get genreIds =>
      text().withDefault(const Constant('{}')).map(const ListConverter())();
  IntColumn get movieId => integer().unique().withDefault(const Constant(0))();
  TextColumn get originalLanguage => text().withDefault(const Constant(''))();
  TextColumn get originalTitle => text().withDefault(const Constant(''))();
  TextColumn get overview => text().withDefault(const Constant(''))();
  RealColumn get popularity => real().withDefault(const Constant(0.0))();
  TextColumn get posterPath => text()();
  BlobColumn get posterBlob => blob().nullable()();
  DateTimeColumn get releaseDate => dateTime().nullable()();
  TextColumn get title => text()();
  BoolColumn get video => boolean().withDefault(const Constant(true))();
  RealColumn get voteAverage => real().withDefault(const Constant(0.0))();
  IntColumn get voteCount => integer().withDefault(const Constant(0))();
}

class ListConverter extends TypeConverter<List<int>, String> {
  const ListConverter();

  @override
  List<int> fromSql(String fromDb) {
    final List<dynamic> jsonList = jsonDecode(fromDb);
    return jsonList.cast<int>();
  }

  @override
  String toSql(List<int> value) {
    return jsonEncode(value);
  }
}
