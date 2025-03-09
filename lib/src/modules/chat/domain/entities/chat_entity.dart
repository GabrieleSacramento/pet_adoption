import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pet_adoption/src/modules/chat/domain/entities/times_tamp_converter.dart';
part 'chat_entity.g.dart';

@JsonSerializable()
class ChatEntity {
  final String message;
  @TimestampConverter()
  final DateTime? createdAt;
  final String? userName;

  ChatEntity({
    required this.message,
    this.createdAt,
    this.userName,
  });

  factory ChatEntity.fromJson(Map<String, dynamic> json) =>
      _$ChatEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ChatEntityToJson(this);

  factory ChatEntity.fromMap(Map<String, dynamic> data) {
    return ChatEntity(
      message: data['message'] as String,
      createdAt: _convertTimestamp(data['createdAt']),
      userName: data['userName'] as String?,
    );
  }

  static DateTime? _convertTimestamp(dynamic timestamp) {
    if (timestamp is Timestamp) {
      return timestamp.toDate();
    } else if (timestamp is String) {
      return DateTime.tryParse(timestamp);
    }
    return null;
  }
}