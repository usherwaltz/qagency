import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/utils.dart';

part 'api_response_model.freezed.dart';

@Freezed(fromJson: false, toJson: false, equal: false, copyWith: false)
class APIResponseModel<T> with _$APIResponseModel {
  const factory APIResponseModel({
    required ResponseTypes responseType,
    T? data,
    String? exception,
  }) = _APIResponseModel;

  const APIResponseModel._();

  bool get isSuccessful => responseType == ResponseTypes.ok;
}
