import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';


@JsonSerializable(explicitToJson: true)
class MessageModel {
  String? id;
  String? message;
  User? author;
  int? createdAt;
  bool isPlaying = false;

  MessageModel({this.message, this.author, this.id, this.createdAt});

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
