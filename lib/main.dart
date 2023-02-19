import 'dart:async';

import 'package:chat_gpt/ui_components/receiver_card.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

import 'ui_components/sender_card.dart';
import 'constants.dart';
import 'data.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TranslateScreen(),
    );
  }
}

class TranslateScreen extends StatefulWidget {
  const TranslateScreen({Key? key}) : super(key: key);

  @override
  State<TranslateScreen> createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {
  /// text controller
  final _txtWord = TextEditingController();
  late List<MessageData> _chatHistory;

  late OpenAI openAI;

  ///t => translate
  final tController = StreamController<CTResponse?>.broadcast();

  void _createRequest() async {
    var sendingPrompt = _txtWord.text.toString();
    _txtWord.clear();

    setState(() {
      _chatHistory.add(MessageData(sendingPrompt, MessageType.sender));
    });

    final request = CompleteText(
        prompt: sendingPrompt.toString(),
        maxTokens: 200,
        model: kTranslateModelV3);

    openAI.onCompleteStream(request: request).asBroadcastStream().listen((res) {
      tController.sink.add(res);
    }).onError((err) {
      print("$err");
    });
  }

  @override
  void initState() {
    //UI
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    //Init list of data
    _chatHistory = List.empty(growable: true);

    //Init openAI object
    openAI = OpenAI.instance.build(
        token: token,
        baseOption: HttpSetup(receiveTimeout: 6000),
        isLogger: true);
    super.initState();
  }

  @override
  void dispose() {
    ///close stream complete text
    openAI.close();
    tController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NewGradientAppBar(
        gradient:
            const LinearGradient(colors: [Colors.teal, Colors.tealAccent]),
        title: const Text("ChatGPT OpenAPI"),
      ),
      body: Column(children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: _chatHistoryListener(size)
          ),
        ),
        _inputField(size),
      ]),
    );
  }


  Widget _chatHistoryListener(Size size) {
    return StreamBuilder<CTResponse?>(
      stream: tController.stream,
      builder: (context, snapshot) {
        final text = snapshot.data?.choices.last.text.trim();
        if (text!=null) {
          _chatHistory.add(MessageData(text, MessageType.receiver));
        }
        return BodyComponent(chatHistory: _chatHistory, size: size);
      },
    );
  }

  Widget _inputField(Size size) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0.0, 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller: _txtWord,
              decoration: const InputDecoration(
                fillColor: Colors.teal,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),
              ),
              maxLines: null,
              textInputAction: TextInputAction.newline,
              keyboardType: TextInputType.multiline,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            iconSize: 24.0,
            color: Colors.teal,
            onPressed: _createRequest,
          ),
        ],
      ),
    );
  }
}

class BodyComponent extends StatefulWidget {
  const BodyComponent({Key? key, required this.chatHistory, required this.size}) : super(key: key);
  final List<MessageData> chatHistory;
  final Size size;

  @override
  State<BodyComponent> createState() => _BodyComponentState();

}
class _BodyComponentState extends State<BodyComponent> {

  @override
  Widget build(BuildContext context) {
    if (widget.chatHistory.isNotEmpty) {
      return ListView.builder(
        itemCount: widget.chatHistory.length,
        itemBuilder: (BuildContext context, int index) {
          var value = widget.chatHistory[index];
          if (value.type == MessageType.sender) {
            return senderCard(widget.size, value.message);
          } else if (value.type == MessageType.receiver){
            return receiverCard(widget.size, value.message);
            // receiverCard(size, value.message);
          } else {
            return Container(
                alignment: Alignment.center,
                child: const Text("Invalid message card"));
          }
        },
      );

    } else {
      return Container(
          alignment: Alignment.center,
          child: const Text("No message"));
    }
  }
}
