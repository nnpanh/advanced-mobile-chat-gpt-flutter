// import 'package:hive/hive.dart';
//
// part 'hive_data_model.g.dart';
//
// // @HiveType(typeId: 0)
// // class HiveData extends HiveObject {
// //   @HiveField(0)
// //   List<ConversationDTO> conversations = [];
// // }
//
// @HiveType(typeId: 0)
// class ConversationDTO extends HiveObject{
//   @HiveField(0)
//   String? id;
//   @HiveField(1)
//   String? prompt;
//   @HiveField(2)
//   List<String> messagesId = [];
//   @HiveField(3)
//   String? summary;
//   @HiveField(4)
//   bool? isSummarized;
//
//   ConversationDTO({this.id, this.prompt, required this.messagesId, this.summary, this.isSummarized});
// }
//
// @HiveType(typeId: 1)
// class MessageDTO extends HiveObject {
//   @HiveField(0)
//   String? id;
//   @HiveField(1)
//   String? message;
//   @HiveField(2)
//   int? createdAt;
//   @HiveField(3)
//   String? authorId;
//
//   MessageDTO({this.id, this.message, this.createdAt, this.authorId});
// }
//
