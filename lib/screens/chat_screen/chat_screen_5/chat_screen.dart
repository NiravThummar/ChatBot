// ignore_for_file: prefer_const_constructors

//Main Chat Screen for backup

import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:chat_bot/dialogflow/dialogflowFlutter.dart';
import 'package:chat_bot/dialogflow/googleAuth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChatScreen5 extends StatefulWidget {
  const ChatScreen5({super.key});
  @override
  State<ChatScreen5> createState() => _ChatScreen5State();
}

class _ChatScreen5State extends State<ChatScreen5> {
  final messageInsert = TextEditingController();
  List<Map> messsages = [];
  void response(query) async {
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/cred.json").build();
    DialogFlow dialogflow = DialogFlow(authGoogle: authGoogle, language: "en");
    AIResponse aiResponse = await dialogflow.detectIntent(query);
    setState(() {
      messsages.insert(0, {
        "data": 0,
        "message": aiResponse.getListMessage()?[0]["text"]["text"][0].toString()
      });
      print(aiResponse.getListMessage()?[0]["text"]["text"][0].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                reverse: true,
                itemCount: messsages.length,
                itemBuilder: (context, index) => chat(
                    messsages[index]["message"].toString(),
                    messsages[index]["data"]),
              ),
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
                      // padding: EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(10),
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
                              fontWeight: FontWeight.bold, fontSize: 18.0),
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
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    child: IconButton(
                      icon: Icon(
                        Icons.send_rounded,
                        size: 30.0,
                      ),
                      onPressed: () {
                        if (messageInsert.text.isEmpty) {
                          print("Empty message");
                          Fluttertoast.showToast(msg: "Enter a message");
                        } else {
                          setState(() {
                            messsages.insert(
                                0, {"data": 1, "message": messageInsert.text});
                            print(messageInsert.text);
                          });
                          response(messageInsert.text);
                          messageInsert.clear();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20),
            //   margin: const EdgeInsets.symmetric(horizontal: 8.0),
            //   child: Row(
            //     children: <Widget>[
            //       Flexible(
            //         child: TextField(
            //           controller: messageInsert,
            //           decoration: InputDecoration(
            //             hintText: "Send your message",
            //             hintStyle: TextStyle(
            //                 fontWeight: FontWeight.bold, fontSize: 18.0),
            //           ),
            //         ),
            //       ),
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 4.0),
            //   child: IconButton(
            //     icon: Icon(
            //       Icons.send,
            //       size: 30.0,
            //     ),
            //     onPressed: () {
            //       if (messageInsert.text.isEmpty) {
            //         print("Empty message");
            //         Fluttertoast.showToast(msg: "Enter a message");
            //       } else {
            //         setState(() {
            //           messsages.insert(
            //               0, {"data": 1, "message": messageInsert.text});
            //           print(messageInsert.text);
            //         });
            //         response(messageInsert.text);
            //         messageInsert.clear();
            //       }
            //     },
            //   ),
            // ),
            // ],
            // ),
            // ),
            SizedBox(
              height: 15.0,
            )
          ],
        ),
      ),
    );
  }

  Widget chat(String message, int data) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Bubble(
        radius: Radius.circular(15.0),
        color: data == 0 ? Colors.blue : Colors.orangeAccent,
        elevation: 0.0,
        alignment: data == 0 ? Alignment.topLeft : Alignment.topRight,
        nip: data == 0 ? BubbleNip.leftBottom : BubbleNip.rightBottom,
        child: Padding(
          padding: EdgeInsets.all(2.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage(
                    data == 0 ? "assets/bot.png" : "assets/user.png"),
              ),
              SizedBox(
                width: 10.0,
              ),
              Flexible(
                child: Text(
                  message,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
