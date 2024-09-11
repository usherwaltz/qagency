import 'package:freezed_annotation/freezed_annotation.dart';

part 'genre_model.freezed.dart';
part 'genre_model.g.dart';

@Freezed(toJson: false, copyWith: false)
class GenreModel with _$GenreModel {
  const factory GenreModel({
    @Default(0) id,
    @Default('') name,
  }) = _GenreModel;

  factory GenreModel.fromJson(Map<String, dynamic> json) =>
      _$GenreModelFromJson(json);
}
