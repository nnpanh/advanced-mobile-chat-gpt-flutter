import 'package:flutter/cupertino.dart';

enum MessageType {
  sender, receiver
}

class MessageData{
  late String message;
  late MessageType type;

  MessageData(this.message, this.type);
}
