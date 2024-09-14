import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../config/flavor_config.dart';

class ImageConverter implements JsonConverter<String, String> {
  const ImageConverter();

  static final String _prefix = FlavorConfig.instance.values.posterUrl;

  @override
  String fromJson(String json) {
    if (json.isEmpty) return '';

    return _prefix + json;
  }

  @override
  String toJson(String object) {
    return object.replaceAll(_prefix, '');
  }
}
