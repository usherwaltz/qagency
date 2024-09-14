import 'dart:async';

import 'package:drift/drift.dart' as drift;

import '../../business_logic/models/models.dart';
import '../../config/database/app_database.dart';

extension MovieToCompanion on MovieModel {
  Future<MoviesCompanion> toCompanion() async {
    return MoviesCompanion(
      adult: drift.Value(adult),
      backdropPath: drift.Value(backdropPath),
      genreIds: drift.Value(genreIds),
      movieId: drift.Value(id),
      originalLanguage: drift.Value(originalLanguage),
      originalTitle: drift.Value(originalTitle),
      overview: drift.Value(overview),
      popularity: drift.Value(popularity),
      posterPath: drift.Value(posterPath),
      posterBlob: const drift.Value(null), // stored later
      releaseDate: drift.Value(releaseDate),
      title: drift.Value(title),
      video: drift.Value(video),
      voteAverage: drift.Value(voteAverage),
      voteCount: drift.Value(voteCount),
    );
  }
}
