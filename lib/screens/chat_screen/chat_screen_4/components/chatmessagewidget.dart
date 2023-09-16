import 'package:bubble/bubble.dart';
import 'package:chat_bot/screens/chat_screen/chat_screen_4/components/chat_message_type.dart';
import 'package:flutter/material.dart';

class ChatMessageWidget extends StatelessWidget {
  final String text;
  final ChatMessageType chatMessageType;
  ChatMessageWidget({required this.text, required this.chatMessageType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Bubble(
        radius: Radius.circular(15.0),
        color: chatMessageType == ChatMessageType.bot
            ? Colors.blue
            : Colors.orangeAccent,
        elevation: 0.0,
        alignment: chatMessageType == ChatMessageType.bot
            ? Alignment.topLeft
            : Alignment.topRight,
        nip: chatMessageType == ChatMessageType.bot
            ? BubbleNip.leftBottom
            : BubbleNip.rightBottom,
        child: Padding(
          padding: EdgeInsets.all(2.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage(
                    chatMessageType == ChatMessageType.bot
                        ? "assets/bot.png"
                        : "assets/user.png"),
              ),
              SizedBox(
                width: 10.0,
              ),
              Flexible(
                child: Text(
                  text,
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

// import 'package:chat_bot/screens/chat_screen/chat_screen_4/components/chat_message_type.dart';
// import 'package:flutter/material.dart';

// class ChatMessageWidget extends StatelessWidget {
//   final String text;
//   final ChatMessageType chatMessageType;
//   ChatMessageWidget({required this.text, required this.chatMessageType});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 10),
//       padding: EdgeInsets.all(16),
//       color: chatMessageType == ChatMessageType.bot
//           ? Color(0xFF444654)
//           : Color(0xFF343541),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           chatMessageType == ChatMessageType.bot
//               ? Container(
//                   margin: EdgeInsets.only(right: 16),
//                   child: CircleAvatar(
//                     backgroundColor: Color.fromRGBO(16, 163, 127, 1),
//                     child: Icon(Icons.chat),
//                   ),
//                 )
//               : Container(
//                   margin: EdgeInsets.only(right: 16),
//                   child: CircleAvatar(
//                     backgroundColor: Color(0xFF444654),
//                     child: Icon(Icons.person),
//                   ),
//                 ),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Text(
//                     text,
//                     style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                           color: Colors.white,
//                         ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
