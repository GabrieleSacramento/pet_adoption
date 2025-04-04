import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class TimestampConverter implements JsonConverter<DateTime?, dynamic> {
  const TimestampConverter();

  @override
  DateTime? fromJson(dynamic timestamp) {
    if (timestamp is Timestamp) {
      return timestamp.toDate();
    } else if (timestamp is String) {
      return DateTime.tryParse(timestamp);
    }
    return null;
  }

  @override
  dynamic toJson(DateTime? date) {
    return date != null ? Timestamp.fromDate(date) : null;
  }
}