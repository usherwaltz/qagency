import 'package:freezed_annotation/freezed_annotation.dart';

import '../models.dart';

part 'genres_list_response_model.freezed.dart';
part 'genres_list_response_model.g.dart';

@Freezed(toJson: false, copyWith: false)
class GenresListResponseModel with _$GenresListResponseModel {
  const factory GenresListResponseModel({
    @Default([]) List<GenreModel> genres,
  }) = _GenresListResponseModel;

  factory GenresListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GenresListResponseModelFromJson(json);
}
