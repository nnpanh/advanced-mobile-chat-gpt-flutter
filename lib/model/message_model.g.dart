// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      message: json['message'] as String?,
      author: json['author'] == null
          ? null
          : User.fromJson(json['author'] as Map<String, dynamic>),
      id: json['id'] as String?,
      createdAt: json['createdAt'] as int?,
    )..isPlaying = json['isPlaying'] as bool;

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'author': instance.author,
      'createdAt': instance.createdAt,
      'isPlaying': instance.isPlaying,
    };
