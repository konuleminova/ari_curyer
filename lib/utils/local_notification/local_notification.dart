import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationUtils {
  FlutterLocalNotificationsPlugin notifPlugin;

  static final NotificationUtils _singleton = NotificationUtils._internal();

  factory NotificationUtils() {
    return _singleton;
  }

  NotificationUtils._internal();

  void init() {
    if (notifPlugin == null) {
      notifPlugin = FlutterLocalNotificationsPlugin();
      var initializationSettingsAndroid =
          new AndroidInitializationSettings('app_icon');
      var initializationSettingsIOS = new IOSInitializationSettings();
      var initializationSettings = new InitializationSettings(
          initializationSettingsAndroid, initializationSettingsIOS);
      notifPlugin.initialize(initializationSettings);
    }
  }

  Future<void> scheduleNotification() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics =
        new IOSNotificationDetails(sound: "slow_spring_board.aiff");
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//    Timer.periodic(Duration(seconds: 3), (timer) async {
//
//    });
    await notifPlugin.show(
      0,
      'You have new order',
      'Please review your orders',
      platformChannelSpecifics,
      payload: 'Custom_Sound',
    );
  }
}
