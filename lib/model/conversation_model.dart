import 'package:flutgpt/model/message_model.dart';
import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';

part 'conversation_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ConversationModel {
  String? id;
  String? prompt;
  List<MessageModel> messages = [];
  String? summary;
  bool? isSummarized;

  @JsonKey(includeFromJson: false, includeToJson: false)
  Response? error;

  ConversationModel({
    this.id,
    this.prompt,
    required this.messages,
    this.summary,
    this.isSummarized,
    this.error,
  });

  clearConversation() {
    id = null;
    prompt = "";
    messages = [];
    summary = "";
    isSummarized = false;
  }

  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationModelFromJson(json);
  Map<String, dynamic> toJson() => _$ConversationModelToJson(this);
}
