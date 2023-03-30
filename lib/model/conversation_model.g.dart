// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationModel _$ConversationModelFromJson(Map<String, dynamic> json) =>
    ConversationModel(
      id: json['id'] as String?,
      prompt: json['prompt'] as String?,
      messages: (json['messages'] as List<dynamic>)
          .map((e) => MessageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      summary: json['summary'] as String?,
      isSummarized: json['isSummarized'] as bool?,
    );

Map<String, dynamic> _$ConversationModelToJson(ConversationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'prompt': instance.prompt,
      'messages': instance.messages,
      'summary': instance.summary,
      'isSummarized': instance.isSummarized,
    };
