import 'dart:async';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

import 'constants.dart';

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

  late OpenAI openAI;

  ///t => translate
  final tController = StreamController<CTResponse?>.broadcast();

  void _createRequest() async {
    final request = CompleteText(
        prompt: _txtWord.text.toString(),
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
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

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
        gradient: const LinearGradient(colors: [Colors.teal, Colors.tealAccent]),

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
            child: ListView(children: [
              Column(
                children: [
                  _inputCard(size, _txtWord.text.toString()),
                  _resultCard(size),
                ],
              ),
            ]),
          ),
        ),
        _inputField(size),
      ]),
    );
  }

  Widget _inputCard(Size size, String text) {
    return Container(
      alignment: Alignment.topRight,
      margin: const EdgeInsets.only(right: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            padding: const EdgeInsets.all(16.0),
            // width: size.width * .64,
            decoration: myCard,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: size.width * .64),
                child:
                  Text(
                    text,
                    style: const TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
              ),
          ),
        ],
      ),
    );
  }



  Widget _resultCard(Size size) {
    return StreamBuilder<CTResponse?>(
      stream: tController.stream,
      builder: (context, snapshot) {
        final text = snapshot.data?.choices.last.text.trim() ?? "Loading...";
        return Container(
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.only(left: 16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16.0),
                padding: const EdgeInsets.all(16.0),
                // width: size.width * .64,
                decoration: gptCard,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: size.width * .64),
                  child:
                  Text(
                    text,
                    style: const TextStyle(color: Colors.black, fontSize: 18.0),
                  ),
                ),
              ),
            ],
          ),
        );
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
