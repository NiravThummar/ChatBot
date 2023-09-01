import 'package:chat_bot/widgets/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<bool> showExitDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Exit App',
    content: 'Are you sure you want to Exit?',
    optionsBuilder: () => {
      'No': false,
      'Yes': true,
    },
  ).then((value) => value ?? false);
}
