import 'package:chat_bot/widgets/theme/change_theme_widget.dart';
import 'package:chat_bot/widgets/theme/theme_manager.dart';
import 'package:flutter/material.dart';

Future<void> showThemeChangerDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return ThemePickerDialog(
        onSelectedTheme: (BrightnessPreference preference) {
          ThemeManager.of(context).setBrightnessPreference(preference);
        },
      );
    },
  );
}
