import 'package:freezed_annotation/freezed_annotation.dart';

import '../models.dart';

part 'movies_list_response_model.freezed.dart';
part 'movies_list_response_model.g.dart';

@Freezed(toJson: false)
class MoviesListResponseModel with _$MoviesListResponseModel {
  const factory MoviesListResponseModel({
    @Default(0) int page,
    @Default([]) List<MovieModel> results,
    @Default(0) @JsonKey(name: 'total_pages') int totalPages,
    @Default(0) @JsonKey(name: 'total_results') int totalResults,
  }) = _MoviesListResponseModel;

  factory MoviesListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MoviesListResponseModelFromJson(json);
}
