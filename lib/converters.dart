import 'dart:convert';
import 'package:floor/floor.dart';

class StringListConverter extends TypeConverter<List<String>, String> {
  @override
  List<String> decode(String databaseValue) {
    return List<String>.from(json.decode(databaseValue));
  }

  @override
  String encode(List<String> value) {
    return json.encode(value);
  }
}

class StatsMapConverter extends TypeConverter<Map<String, int>, String> {
  @override
  Map<String, int> decode(String databaseValue) {
    final decoded = json.decode(databaseValue);
    return Map<String, int>.from(decoded);
  }

  @override
  String encode(Map<String, int> value) {
    return json.encode(value);
  }
}
