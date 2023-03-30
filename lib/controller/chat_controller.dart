import 'dart:collection';
import 'dart:convert';
import 'dart:math';
import 'package:flutgpt/api/api_key.dart';
import 'package:flutgpt/controller/speaker_controller.dart';
import 'package:flutgpt/controller/user_controller.dart';
import 'package:flutgpt/model/conversation_model.dart';
import 'package:flutgpt/model/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ChatController extends GetxController {
  int _chatIndex = 0;

  // Adds a message to the current chat even if it's not the active one
  int promptIndex = 0;

  int get chatIndex => _chatIndex;
  late String chatId;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  //Control speaking
  FlutterTts textToSpeech = FlutterTts();
  final ListQueue<String> _speechIdToReadQueue = ListQueue<String>();
  String? currentReadingText;
  bool isAutoSpeaking = false;

  void changeAutoSpeakingMode(bool autoRead) {
    if (isAutoSpeaking == autoRead) return; //do nothing

    textToSpeech.stop();
    if (currentReadingText !=null) {
      chats[promptIndex].messages.firstWhere((element) => element.id == currentReadingText).isPlaying = false;
      currentReadingText = null;
    }
    _speechIdToReadQueue.clear();
    isAutoSpeaking = autoRead;

    update();
  }

  void onClickSpeakerIcon(String? clickedId) {
    //If has icon -> isAutoSpeaking = false;
    if (currentReadingText !=null) {
      if (currentReadingText != clickedId) {
        //Is speaking another message
        textToSpeech.stop();
        //Stop old one
        chats[promptIndex].messages.firstWhere((element) => element.id == currentReadingText).isPlaying = false;
        //Start new one
        currentReadingText = clickedId;
        chats[promptIndex].messages.firstWhere((element) => element.id == clickedId).isPlaying = true;
        _speechIdToReadQueue.add(chats[promptIndex].messages.firstWhere((element) => element.id == clickedId).id??"");
        startSpeakingFirstMessageInQueue();
      } else if (currentReadingText == clickedId) {
        //current = null
        textToSpeech.stop();
        chats[promptIndex].messages.firstWhere((element) => element.id == currentReadingText).isPlaying = false;
        currentReadingText = null;
      }
      //Not speaking
    } else {
        currentReadingText = clickedId;
        chats[promptIndex].messages.firstWhere((element) => element.id == clickedId).isPlaying = true;
        _speechIdToReadQueue.add(chats[promptIndex].messages.firstWhere((element) => element.id == clickedId).id??"");
        startSpeakingFirstMessageInQueue();
    }
    update();
  }

  void setLoading(bool value) {
    _isLoading = value;
    update();
  }

  //List of chat history
  final List<ConversationModel> _chats = [];
  List<ConversationModel> get chats => _chats;

  //Current chat
  final ConversationModel _conversation = ConversationModel(
      isSummarized: false, summary: "", prompt: "", messages: []);
  ConversationModel get conversation => _conversation;

  @override
  void onInit() {
    super.onInit();
    _chats.add(_conversation);
    //On finish read one-line
    textToSpeech.setCompletionHandler((){
      chats[promptIndex].messages.firstWhere((element) => element.id == currentReadingText).isPlaying = false;
      currentReadingText = null;

      if (isAutoSpeaking) {
        if (_speechIdToReadQueue.isNotEmpty) {
          chats[promptIndex].messages.firstWhere((element) => element.id == _speechIdToReadQueue.first).isPlaying = true;
          startSpeakingFirstMessageInQueue();
        }
      }
    });

  }

  Future postRequestToChatGPT() async {
    final url = Uri.parse("https://api.openai.com/v1/completions");
    // Combine all the messages into a single string with \n as a separator
    var header = {
      "Authorization": "Bearer $token",
      'Content-Type': 'application/json',
    };
    var body = jsonEncode({
      "model": "text-davinci-003",
      "prompt": chats[chatIndex].prompt,
      "temperature": 0,
      "max_tokens": 500
    });
    try {
      // post request using dio
      final response = await http.post(url, headers: header, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        data["choices"][0]["text"] =
            data["choices"][0]["text"].toString().trim();
        addChatGPTMessage(data["choices"][0]["text"]);
      } else {
        addErrorMessage(response);
        debugPrint("Error: ${response.statusCode}");
        debugPrint("Error: ${response.body}");
      }
    } catch (e) {
      debugPrint("Catch Error: $e");
    }

    setLoading(false);
  }

  void handleSendPressed(String message) async {
    if (message.isEmpty) return;
    addErrorMessage(null);
    promptIndex = chatIndex;
    setLoading(true);

    final textMessage = MessageModel(
      author: UserController.user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      message: message,
    );

    _addMessage(textMessage);
    addToPrompt(textMessage.message!);
    postRequestToChatGPT();
  }

  void _addMessage(MessageModel messageBlock) {
    _chats[promptIndex].messages.insert(0, messageBlock);
    update();
  }

  void addChatGPTMessage(String message) async {
    final textMessage = MessageModel(
        author: UserController.chatGPTId,
        message: message,
        id: randomString(),
        createdAt: DateTime.now().millisecondsSinceEpoch);

    addToPrompt(textMessage.message!);
    _addMessage(textMessage);
    if (!chats[promptIndex].isSummarized!) {
      summarizeThePrompt();
      chats[promptIndex].isSummarized = true;
    }

    //Che do tu doc
    if (isAutoSpeaking) {
      _speechIdToReadQueue.add(textMessage.id!);
      if (currentReadingText == null) {
        chats[promptIndex].messages.firstWhere((element) => element.id == _speechIdToReadQueue.first).isPlaying = true;
        startSpeakingFirstMessageInQueue();
      }
    }
    update();
  }

  Future<void> startSpeakingFirstMessageInQueue() async {
      currentReadingText = _speechIdToReadQueue.first;
      await textToSpeech.setSpeechRate(0.5); //speed of speech
      await textToSpeech.setVolume(1.0); //volume of speech
      await textToSpeech.setPitch(1); //pitc of sound
      await textToSpeech.speak(chats[promptIndex].messages.firstWhere((element) => element.id == _speechIdToReadQueue.first).message??"");
      _speechIdToReadQueue.removeFirst();
      update();
  }

  void addToPrompt(String message) {
    chats[promptIndex].prompt = "${chats[promptIndex].prompt}$message\n";
    debugPrint("prompt: ${chats[promptIndex].prompt}");
  }

  void clearConversation() {
    if (_chats.length <= 1) {
      _chats[0].clearConversation();
    } else {
      _chats.removeAt(chatIndex);
      if (chatIndex > 1) {
        changeConversation(chatIndex - 1);
      } else {
        changeConversation(0);
      }
    }

    debugPrint("Conversation Cleared");
    update();
  }

  Future summarizeThePrompt() async {
    final url = Uri.parse("https://api.openai.com/v1/completions");
    // Combine all the messages into a single string with \n as a separator
    var header = {
      "Authorization": "Bearer $token",
      'Content-Type': 'application/json',
    };
    var body = jsonEncode({
      "model": "text-davinci-003",
      "prompt": "${chats[promptIndex].prompt}\nMake it a title",
      "temperature": 0,
      "max_tokens": 150
    });
    try {
      // post request using dio
      final response = await http.post(url, headers: header, body: body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        data["choices"][0]["text"] =
            data["choices"][0]["text"].toString().trim();
        updateSummary(data["choices"][0]["text"]);
        debugPrint("summary: ${chats[promptIndex].summary}");
      } else {
        debugPrint("Error: ${response.statusCode}");
        debugPrint("Error: ${response.body}");
      }
    } catch (e) {
      debugPrint("Catch Error: $e");
    }
  }

  void updateSummary(String newSummary) {
    _chats[promptIndex].summary = newSummary;
    update();
  }

  addChat() {
    if (chats.isNotEmpty && chats[chats.length - 1].prompt!.isNotEmpty) {
      _chats.add(ConversationModel(
          isSummarized: false, summary: "", prompt: "", messages: []));
      _chatIndex = _chats.length - 1;
      update();
    }
  }

  void changeConversation(int index) {
    _chatIndex = index;
    update();
  }

  void addErrorMessage(http.Response? response) {
    _chats[promptIndex].error = response;
    update();
  }
}

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}
