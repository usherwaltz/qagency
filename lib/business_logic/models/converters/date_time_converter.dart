import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

class DateConverter implements JsonConverter<DateTime?, String> {
  const DateConverter();

  @override
  DateTime? fromJson(String json) {
    if (json.isEmpty) return null;

    return DateTime.tryParse(json);
  }

  @override
  String toJson(DateTime? object) {
    return object == null ? '' : DateFormat('yyyy-MM-dd').format(object);
  }
}
