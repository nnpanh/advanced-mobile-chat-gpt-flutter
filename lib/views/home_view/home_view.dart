import 'dart:convert';

import 'package:flutgpt/controller/chat_controller.dart';
import 'package:flutgpt/model/conversation_model.dart';
import 'package:flutgpt/views/home_view/components/app_drawer.dart';
import 'package:flutgpt/views/home_view/components/appbar.dart';
import 'package:flutgpt/views/home_view/components/home_view_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ChatController chatController = Get.put(ChatController());
  bool hasReloaded = false;

  @override
  Widget build(BuildContext context) {
    if (!hasReloaded) {
      reloadConversations(chatController).then((_){
        setState(() {
          hasReloaded = true;
        });
      });
    }

    if (hasReloaded) {
      return SafeArea(
        child: Scaffold(
            appBar: appBar(), drawer: appDrawer(context), body: const HomeViewBody()),
      );
    } else {
      return const SafeArea(
        child: Scaffold(
      body: Center(
        child: CircularProgressIndicator()
      )),
      );
    }

  }
}

Future<void> reloadConversations(ChatController chatController) async {
  //Open db
  var dir = await getApplicationDocumentsDirectory();
  await dir.create(recursive: true);
  var dbPath = join(dir.path, 'my_database.db');
  var db = await databaseFactoryIo.openDatabase(dbPath);
  var store = StoreRef.main();
  //Get number of chats
  int? numberOfChats = await store.record('numberOfChats').get(db) as int?;
  numberOfChats ??= 0;
  //Get all chats
  List<ConversationModel> chats = [];
  for (int i = 0; i < numberOfChats; i++) {
    var conversation = await store.record('chat$i').get(db) as String;
    var decodeJson = json.decode(conversation);
    ConversationModel parsedChat = ConversationModel.fromJson(decodeJson);
    if (parsedChat.messages.isNotEmpty) {
      if (parsedChat.summary.isBlank == true) {
        parsedChat.summary = "Old chat";
      }
      chats.add(parsedChat);
    }
  }

  if (chats.isNotEmpty) {
    chatController.addOldChat(chats);
  }
  chatController.chats.add(chatController.conversation);

  await db.close();
}
