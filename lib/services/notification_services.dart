import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  NotificationService._internal();
  BehaviorSubject<String> notificationSubject = BehaviorSubject<String>();

  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> deleteAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> deleteNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/notification_icon');
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await FlutterLocalNotificationsPlugin()
            .getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      notificationSubject.add(notificationAppLaunchDetails!.payload ?? '');
    }

    await FlutterLocalNotificationsPlugin().initialize(
      initializationSettings,
      onSelectNotification: (payload) {
        notificationSubject.add(payload ?? "");
      },
    );
  }

  Future<void> setTestNotification(
      BuildContext context, String title, String body) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        10,
        title,
        body,
        tz.TZDateTime.now(tz.local).add(Duration(seconds: 2)),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'main_channel',
            'Main Channel',
            importance: Importance.max,
            priority: Priority.max,
            playSound: true,
            enableVibration: true,
          ),
        ),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        payload: "Test notification");
  }

  Future<void> setNotification(int id, String title, String body, int hour,
      int minute, String payload, BuildContext context) async {
    //  Use zonedSchedule instead by passing a date in the future
    //with the same time and pass DateTimeComponents.matchTime as
    //the value of the matchDateTimeComponents parameter..
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        setTiming(hour, minute),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'main_channel',
            'Main Channel',
            importance: Importance.max,
            priority: Priority.max,
            playSound: true,
            enableVibration: true,
          ),
        ),
        matchDateTimeComponents: DateTimeComponents.time,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        payload: payload);
    print("Notification set daily at time $hour:$minute");
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

tz.TZDateTime setTiming(int hour, int minute) {
  Duration offsetTime = DateTime.now().timeZoneOffset;
  tz.initializeTimeZones();
  var now = DateTime.now();
  tz.TZDateTime scheduledDate = (offsetTime.isNegative)
      ? tz.TZDateTime(tz.UTC, now.year, now.month, now.day, hour, minute)
          .add(offsetTime)
      : tz.TZDateTime(tz.UTC, now.year, now.month, now.day, hour, minute)
          .subtract(offsetTime);

  return scheduledDate;
}
