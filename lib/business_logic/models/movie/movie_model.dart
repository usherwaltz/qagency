import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../business_logic/models/models.dart';
import '../converters/converters.dart';

part 'movie_model.freezed.dart';
part 'movie_model.g.dart';

@Freezed(toJson: false)
class MovieModel with _$MovieModel {
  const factory MovieModel({
    @Default(true) bool adult,
    @ImageConverter()
    @Default('')
    @JsonKey(name: 'backdrop_path')
    String backdropPath,
    @Default([]) @JsonKey(name: 'genre_ids') List<int> genreIds,
    @Default(0) int id,
    @Default('') @JsonKey(name: 'original_language') String originalLanguage,
    @Default('') @JsonKey(name: 'original_title') String originalTitle,
    @Default('') @JsonKey(name: 'overview') String overview,
    @Default(0.0) @JsonKey(name: 'popularity') double popularity,
    @ImageConverter()
    @Default('')
    @JsonKey(name: 'poster_path')
    String posterPath,
    @DateConverter() @JsonKey(name: 'release_date') DateTime? releaseDate,
    @Default('') String title,
    @Default(true) bool video,
    @Default(0.0) @JsonKey(name: 'vote_average') double voteAverage,
    @Default(0) @JsonKey(name: 'vote_count') int voteCount,
  }) = _MovieModel;

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  const MovieModel._();

  List<GenreModel> getGenres(List<GenreModel> genres) {
    return genres.where((e) => genreIds.contains(e.id)).toList();
  }
}
