import 'package:drift/drift.dart' as drift;
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../config/database/app_database.dart';

part 'genre_model.freezed.dart';
part 'genre_model.g.dart';

@Freezed(toJson: false, copyWith: false)
class GenreModel with _$GenreModel {
  const factory GenreModel({
    @Default(0) int id,
    @Default('') String name,
  }) = _GenreModel;

  factory GenreModel.fromJson(Map<String, dynamic> json) =>
      _$GenreModelFromJson(json);

  const GenreModel._();

  GenresCompanion getCompanion() {
    return GenresCompanion(
      id: drift.Value(id),
      name: drift.Value(name),
    );
  }
}
