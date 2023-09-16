import 'package:chat_bot/consts/firebase_consts.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  static Future initialize() async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/launcher_icon');
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future showNotification({
    var id = 0,
    required String title,
    required String body,
    var payload,
  }) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'My Channel Id',
      'My Channel',
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );

    var notification = NotificationDetails(
      android: androidNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(0, title, body, notification);
  }
}
