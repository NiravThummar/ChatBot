import 'package:chat_bot/screens/chat_screen/chat_screen_1/chat_screen1.dart';
import 'package:chat_bot/screens/chat_screen/chat_screen_2/chat_screen2.dart';
import 'package:chat_bot/screens/chat_screen/chat_screen_3/chat_screen3.dart';
import 'package:chat_bot/screens/chat_screen/chat_screen_5/chat_screen.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (c) => ChatScreen1()));
              },
              child: Text("chat 1"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (c) => ChatScreen2()));
              },
              child: Text("chat 2"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (c) => ChatScreen3()));
              },
              child: Text("chat 3"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (c) => ChatScreen5()));
              },
              child: Text("chat 4"),
            ),
          ],
        ),
      ),
    );
  }
}
