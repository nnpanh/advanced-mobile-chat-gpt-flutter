import 'package:flutter_chat_types/flutter_chat_types.dart';

class MessageModel {
  String? id;
  String? message;
  User? author;
  int? createdAt;
  bool isPlaying = false;

  MessageModel({this.message, this.author, this.id, this.createdAt});
}
