// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:chat_bot/screens/chat_screen/chat_screen_1/components/chat_message_type.dart';
import 'package:chat_bot/screens/chat_screen/chat_screen_1/components/chatmessagewidget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatScreen1 extends StatefulWidget {
  const ChatScreen1({super.key});

  @override
  State<ChatScreen1> createState() => _ChatScreen1State();
}

Future<String> generateResponse(String prompt) async {
  final apiKey = "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";
  // var url = Uri.https("api.openai.com", "/v1/completions");
  var url = Uri.parse('https://api.openai.com/v1/completions');
  final response = await http.post(
    url,
    // headers: {
    // HttpHeaders.contentTypeHeader: 'application/json',
    // HttpHeaders.authorizationHeader: 'Bearer ${apiKey}',
    // },
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey'
    },
    body: jsonEncode({
      'model': 'text-davinci-003',
      'prompt': prompt,
      'temperature': 0,
      'max_tokens': 2000,
      'top_p': 1,
      'frequency_penalty': 0.0,
      'presence_penalty': 0.0,
    }),
  );
  Map<String, dynamic> newResponse = jsonDecode(response.body);

  return newResponse['choices'][0]['text'];
}

class _ChatScreen1State extends State<ChatScreen1> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(microseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ai Chatbot"),
        backgroundColor: Color.fromRGBO(16, 163, 127, 1),
        elevation: 0,
      ),
      backgroundColor: Color(0xFF343541),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  var message = _messages[index];

                  return ChatMessageWidget(
                    text: message.text,
                    chatMessageType: message.chatMessageType,
                  );
                },
              ),
            ),
            Visibility(
              visible: isLoading,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      textCapitalization: TextCapitalization.characters,
                      style: TextStyle(color: Colors.white),
                      controller: _textController,
                      decoration: InputDecoration(
                        fillColor: Color(0xFF444654),
                        filled: true,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !isLoading,
                    child: Container(
                      color: Color(0xFF444654),
                      child: IconButton(
                        icon: Icon(
                          Icons.send_rounded,
                        ),
                        color: Color.fromRGBO(142, 142, 160, 1),
                        onPressed: () async {
                          setState(() {
                            _messages.add(
                              ChatMessage(
                                text: _textController.text,
                                chatMessageType: ChatMessageType.user,
                              ),
                            );
                            isLoading = true;
                          });
                          var input = _textController.text;
                          _textController.clear();
                          Future.delayed(Duration(milliseconds: 50))
                              .then((_) => _scrollDown());
                          generateResponse(input).then((value) {
                            setState(() {
                              isLoading = false;
                              _messages.add(
                                ChatMessage(
                                  text: value,
                                  chatMessageType: ChatMessageType.bot,
                                ),
                              );
                            });
                          });
                          _textController.clear();
                          Future.delayed(
                            Duration(milliseconds: 50),
                          ).then((_) => _scrollDown());
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
