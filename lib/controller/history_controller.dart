import 'package:chat_bot/controller/message_repository.dart';
import 'package:chat_bot/models/messagemodel.dart';

import 'package:get/get.dart';

class HistoryController extends GetxController {
  static HistoryController get instance => Get.find();

  final _messagerepo = Get.put(MessageRepository());

  Future<List<MessageModel>> getMessageData({id}) async {
    final List<MessageModel> me = await _messagerepo.getAllMessage(id: id);
    return me;
  }
}
