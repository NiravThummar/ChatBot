import 'package:chat_bot/consts/firebase_consts.dart';
import 'package:chat_bot/controller/authentication_repository.dart';
import 'package:chat_bot/models/messagemodel.dart';
import 'package:chat_bot/models/usermodel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class MessageRepository extends GetxController {
  static MessageRepository get instance => Get.find();
  final authrepo = Get.put(AuthenticationRepository());
  createMessage(MessageModel message, UserModel user) async {
    try {
      await firestore
          .collection(userCollection)
          .doc(user.id)
          .collection(messageCollection)
          .add(message.toJson());
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<List<MessageModel>> getAllMessage({id}) async {
    final snapshot = await firestore
        .collection(userCollection)
        .doc(id)
        .collection(messageCollection)
        .get();
    final userdata =
        snapshot.docs.map((e) => MessageModel.fromSnapshot(e)).toList();
    return userdata;
  }

  Future<void> deleteMessage({userid, messageid}) async {
    try {
      await firestore
          .collection(userCollection)
          .doc(userid)
          .collection(messageCollection)
          .doc(messageid)
          .delete();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
