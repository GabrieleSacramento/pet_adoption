// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatEntity _$ChatEntityFromJson(Map<String, dynamic> json) => ChatEntity(
      message: json['message'] as String,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      userName: json['userName'] as String?,
    );

Map<String, dynamic> _$ChatEntityToJson(ChatEntity instance) =>
    <String, dynamic>{
      'message': instance.message,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'userName': instance.userName,
    };
