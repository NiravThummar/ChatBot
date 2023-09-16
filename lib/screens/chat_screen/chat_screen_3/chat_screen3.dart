// ignore_for_file: unused_local_variable

import 'dart:async';
import 'package:chat_bot/screens/chat_screen/chat_screen_3/components/chat_gpt_sdk.dart';
import 'package:chat_bot/screens/chat_screen/chat_screen_3/components/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatScreen3 extends StatefulWidget {
  const ChatScreen3({super.key});

  @override
  State<ChatScreen3> createState() => _ChatScreen3State();
}

class _ChatScreen3State extends State<ChatScreen3> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];
  late OpenAI? chatGPT;

  StreamSubscription? _subscription;

  @override
  void initState() {
    chatGPT = OpenAI.instance;
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _sendMessage() {
    ChatMessage message = ChatMessage(text: _controller.text, sender: "user");
    setState(() {
      _messages.insert(0, message);
    });
    _controller.clear();

    final request = CompleteText(
      prompt: message.text,
      model: kTextDavinci3,
      maxTokens: 200,
    );

    // _subscription = chatGPT!
    //     .build("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")
    //     .onCompletionStream(request: request)
    //     .listen((response) {
    //   Vx.log(response!.choices[0].text);
    //   ChatMessage botMessage = ChatMessage(
    //     text: response!.choices[0].text,
    //     sender: "bot",
    //   );
    //   setState(() {
    //     _messages.insert(0, botMessage);
    //   });
    // });
  }

  Widget _buildTextComposer() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            onSubmitted: (value) => _sendMessage(),
            decoration: InputDecoration.collapsed(hintText: "Send a Message"),
          ),
        ),
        IconButton(
          onPressed: () => _sendMessage(),
          icon: Icon(Icons.send),
        ),
      ],
    ).px8();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ChatScreen")),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                reverse: true,
                padding: Vx.m8,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _messages[index];
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: context.cardColor,
              ),
              child: _buildTextComposer(),
            ),
          ],
        ),
      ),
    );
  }
}
