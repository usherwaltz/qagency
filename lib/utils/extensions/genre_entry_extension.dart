import '../../business_logic/models/models.dart';
import '../../config/database/app_database.dart';

extension GenreEntryExtension on Genre {
  GenreModel get toGenreModel {
    return GenreModel(
      id: id,
      name: name,
    );
  }
}
