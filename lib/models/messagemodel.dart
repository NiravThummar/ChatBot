import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String? id;
  final String? user;
  final String? bot;

  MessageModel({
    this.id,
    required this.user,
    required this.bot,
  });

  toJson() {
    return {
      "user": user,
      "bot": bot,
    };
  }

  factory MessageModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return MessageModel(
      id: document.id,
      user: data!['user'],
      bot: data['bot'],
    );
  }
}
