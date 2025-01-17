import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class LocalNotificationService {
  static final LocalNotificationService _localNotificationService =
      LocalNotificationService._internal();

  factory LocalNotificationService() {
    return _localNotificationService;
  }

  LocalNotificationService._internal();

  // Local Notification Setup
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // fire when a notification has been tapped on
  // will trigger navigation to another page and display the payload associated with the notification.
  static foregroundNotificationResponse(
      NotificationResponse notificationResponse) {
    log('notificationResponseType: ${notificationResponse.notificationResponseType}');
    log('id: ${notificationResponse.id}');
    log('actionId: ${notificationResponse.actionId}');
    log('input: ${notificationResponse.input}');
    log('payload: ${notificationResponse.payload}');
  }

  static backgroundNotificationResponse(
      NotificationResponse notificationResponse) {
    log('notificationResponseType: ${notificationResponse.notificationResponseType}');
    log('id: ${notificationResponse.id}');
    log('actionId: ${notificationResponse.actionId}');
    log('input: ${notificationResponse.input}');
    log('payload: ${notificationResponse.payload}');
  }

  // Notification Initialization
  static Future<void> init() async {
    InitializationSettings settings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: foregroundNotificationResponse,
      onDidReceiveBackgroundNotificationResponse:
          backgroundNotificationResponse,
    );
  }

  // Basic Notification
  static Future<void> showBasicNotification() async {
    NotificationDetails details = const NotificationDetails(
      android: AndroidNotificationDetails(
        'channelId',
        'channelName',
        channelDescription: 'channelDescription',
        importance: Importance.max,
        priority: Priority.high,
        sound: RawResourceAndroidNotificationSound('provider_new_order'),
      ),
      iOS: DarwinNotificationDetails(),
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      'First Basic Notification',
      'This is the fisrt flutter local notifications of type Basic notification',
      details,
    );
  }

  // Repeated Notification
  static Future<void> showRepeatedNotification() async {
    NotificationDetails details = const NotificationDetails(
      android: AndroidNotificationDetails(
        'channelId Repeated',
        'channelName Repeated',
        channelDescription: 'channelDescription Repeated',
        importance: Importance.max,
        priority: Priority.high,
        sound: RawResourceAndroidNotificationSound('provider_new_order'),
      ),
      iOS: DarwinNotificationDetails(),
    );
    await flutterLocalNotificationsPlugin.periodicallyShow(
      1,
      'First Repeated Notification',
      'This is the fisrt flutter local notifications of type Repeated notification',
      RepeatInterval.everyMinute,
      details,
      androidScheduleMode: AndroidScheduleMode.alarmClock,
    );
  }

  // Scheduled Notification
  static Future<void> showScheduledNotification() async {
    tz.initializeTimeZones();
    log(tz.local.name);
    log(tz.TZDateTime.now(tz.local).hour.toString());
    log('tz local name: ${tz.local.name}');
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    log('current timezone: $currentTimeZone');
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    log('after - tz local name: ${tz.local.name}');
    NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        'channelId Scheduled',
        'channelName Scheduled',
        channelDescription: 'channelDescription Scheduled',
        importance: Importance.max,
        priority: Priority.high,
        // sound: RawResourceAndroidNotificationSound('provider_new_order'),
        sound: RawResourceAndroidNotificationSound(
            'provider_new_order.mp3'.split('.').first),
      ),
      iOS: const DarwinNotificationDetails(),
    );

    //tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.zonedSchedule(
        2,
        'First Scheduled Notification',
        'This is the fisrt flutter local notifications of type Scheduled notification',
        tz.TZDateTime.now(tz.local).add(
          const Duration(seconds: 10),
        ),
        details,
        androidScheduleMode: AndroidScheduleMode.alarmClock,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  static Future<void> cancelNotification(int id) async {
    // notifications can be canceled by ID and with or without TAG
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  static Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

// 1.Setup
// 2.Basic Notification
// 3.Repeated Notification
// 4.Schedule Notification