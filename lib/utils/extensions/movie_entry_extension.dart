import '../../business_logic/models/models.dart';
import '../../config/database/app_database.dart';

extension MovieEntryToMovieModel on Movie {
  MovieModel get toMovieModel {
    return MovieModel(
      adult: adult,
      id: movieId,
      backdropPath: backdropPath,
      genreIds: genreIds,
      originalLanguage: originalLanguage,
      originalTitle: originalTitle,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      releaseDate: releaseDate,
      title: title,
      video: video,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }
}
