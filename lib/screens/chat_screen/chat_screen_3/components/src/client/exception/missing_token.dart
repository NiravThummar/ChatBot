import 'package:chat_bot/screens/chat_screen/chat_screen_3/components/src/client/exception/base_error.dart';

class MissionTokenException extends BaseErrorWrapper {
  @override
  String toString() =>
      "Not Missing Your Token look more <a>https://beta.openai.com/account/api-keys</a>";
}
