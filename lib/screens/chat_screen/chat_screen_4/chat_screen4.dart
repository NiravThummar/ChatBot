// ignore_for_file: prefer_const_constructors

//Main Chat Screen for backup

import 'package:chat_bot/consts/firebase_consts.dart';
import 'package:chat_bot/controller/authentication_repository.dart';
import 'package:chat_bot/controller/message_repository.dart';
import 'package:chat_bot/controller/profile_controller.dart';
import 'package:chat_bot/models/messagemodel.dart';
import 'package:chat_bot/models/usermodel.dart';
import 'package:chat_bot/screens/chat_screen/chat_screen_4/components/chat_message_type.dart';
import 'package:chat_bot/screens/chat_screen/chat_screen_4/components/chatmessagewidget.dart';
import 'package:flutter/material.dart';
import 'package:chat_bot/dialogflow/dialogflowFlutter.dart';
import 'package:chat_bot/dialogflow/googleAuth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ChatScreen4 extends StatefulWidget {
  const ChatScreen4({super.key});
  @override
  State<ChatScreen4> createState() => _ChatScreen4State();
}

class _ChatScreen4State extends State<ChatScreen4> {
  final messageInsert = TextEditingController();
  final _scrollController = ScrollController();
  final List<ChatMessage> me = [];

  @override
  void initState() {
    super.initState();
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(microseconds: 3000),
      curve: Curves.easeOut,
    );
  }

  Future<String> response(query) async {
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/cred.json").build();
    DialogFlow dialogflow = DialogFlow(authGoogle: authGoogle, language: "en");
    AIResponse aiResponse = await dialogflow.detectIntent(query);
    return aiResponse.getListMessage()?[0]["text"]["text"][0];
  }

  @override
  Widget build(BuildContext context) {
    final profile = Get.put(ProfileController());
    final controller = Get.put(MessageRepository());
    final authrepo = Get.put(AuthenticationRepository());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        toolbarHeight: 60,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        elevation: 10,
        title: Text("Chat Here"),
      ),
      body: FutureBuilder(
        future: profile.getUserData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel user = snapshot.data as UserModel;
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Flexible(
                    child: ListView.builder(
                        controller: _scrollController,
                        shrinkWrap: true,
                        itemCount: me.length,
                        itemBuilder: (context, index) {
                          var message = me[index];
                          return ChatMessageWidget(
                            text: message.text,
                            chatMessageType: message.chatMessageType,
                          );
                        }),
                  ),
                  Divider(
                    height: 6.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                            ),
                            width: 240,
                            height: 50,
                            child: TextField(
                              controller: messageInsert,
                              decoration: InputDecoration(
                                filled: true,
                                hintText: "Send your message...",
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                                focusedBorder: InputBorder.none,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: IconButton(
                            icon: Icon(
                              Icons.mic,
                              size: 30.0,
                            ),
                            onPressed: () {
                              print(currentUser!.uid);
                              print(authrepo.firebaseUser!.uid);
                            },
                          ),
                        ),
                        Container(
                          child: IconButton(
                            icon: Icon(
                              Icons.send_rounded,
                              size: 30.0,
                            ),
                            onPressed: () async {
                              if (messageInsert.text.isEmpty) {
                                print("Empty message");
                                Fluttertoast.showToast(msg: "Enter a message");
                              } else {
                                setState(() {
                                  me.add(ChatMessage(
                                    text: messageInsert.text,
                                    chatMessageType: ChatMessageType.user,
                                  ));
                                  print(messageInsert.text);
                                  Future.delayed(Duration(milliseconds: 250))
                                      .then((_) => _scrollDown());
                                });
                                var input = messageInsert.text;
                                response(messageInsert.text)
                                    .then((value) async {
                                  setState(() {
                                    me.add(
                                      ChatMessage(
                                        text: value,
                                        chatMessageType: ChatMessageType.bot,
                                      ),
                                    );
                                    Future.delayed(
                                      Duration(milliseconds: 100),
                                    ).then((_) => _scrollDown());
                                  });
                                  final message =
                                      MessageModel(user: input, bot: value);
                                  controller.createMessage(message, user);
                                });
                                messageInsert.clear();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
