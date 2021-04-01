import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:ari_kuryer/services/api_helper/api_config.dart';
import 'package:ari_kuryer/utils/sharedpref/sp_util.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:ari_kuryer/business_logic/models/Order.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;

class NotificationUtils {
  FlutterLocalNotificationsPlugin notifPlugin;
  ApiConfig apiConfig;
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
    bg.BackgroundGeolocation.ready(bg.Config(
            desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
            distanceFilter: 10.0,
            stopOnTerminate: false,
            startOnBoot: true,
            foregroundService: false,
            notification: Notification(sticky: true),
            showsBackgroundLocationIndicator: false,
            debug: false,
            logLevel: bg.Config.LOG_LEVEL_VERBOSE))
        .then((bg.State state) {
      if (!state.enabled) {}
    });
  }

  Future<void> scheduleNotification() async {
    Timer.periodic(Duration(seconds: 5), (timer) async {
      updateCurrentCoords();
      fetchOrderStatus();
    });
  }

  Future<OrderList> fetchOrderStatus() async {
    if (apiConfig == null) {
      apiConfig = new ApiConfig();
    }
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics =
        new IOSNotificationDetails(sound: "slow_spring_board.aiff");
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    final response =
        await http.get(apiConfig.FETCH_ORDER_STATUS(SpUtil.getString('token')));
    if (response.statusCode == 200) {
      OrderList apiResponse = OrderList.fromJson(jsonDecode(response.body));
      for (int i = 0; i < apiResponse.found; i++) {
        if (apiResponse?.order[i].status == 'i want this') {
          await notifPlugin.show(
            0,
            'You have new order',
            'Please review your orders',
            platformChannelSpecifics,
            payload: 'Custom_Sound',
          );
        }
        break;
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  updateCurrentCoords() {
    if (Platform.isAndroid) {
      bg.BackgroundGeolocation.stop().then((value) {
        bg.BackgroundGeolocation.start().then((value) {
          bg.BackgroundGeolocation.getCurrentPosition(samples: 1, persist: true)
              .then((bg.Location location) {
            http
                .get(apiConfig.UPDATE_COORDS(
                    '${location.coords.latitude},${location.coords.longitude}',
                    SpUtil.getString('orderId') ?? '0',
                    SpUtil.getString('token')))
                .then((response) {
              if (response.statusCode == 200) {}
            });
          });
        });
      });
    }
  }
}
