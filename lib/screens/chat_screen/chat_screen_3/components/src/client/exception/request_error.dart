import 'package:chat_bot/screens/chat_screen/chat_screen_3/components/src/client/exception/base_error.dart';

class RequestError extends BaseErrorWrapper {
  final String? message;
  final int? code;

  RequestError({this.message, this.code});

  @override
  String toString() => "\nstatus code :$code  message :$message\n";
}
