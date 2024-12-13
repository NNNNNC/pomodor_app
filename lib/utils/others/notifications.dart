import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService() {
    tz.initializeTimeZones();
  }

  Future<void> initializeNotifications() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'daily_reminder',
      'Daily Reminder',
      description: 'Notification for daily study reminder',
      importance: Importance.high,
      playSound: true,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        // Handle notification tap
      },
    );
  }

  Future<void> _configureLocalTimeZone() async {
    final String? timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
  }

  Future<void> scheduleDailyNotification(TimeOfDay time) async {
    await _configureLocalTimeZone();

    var now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    try {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Study Reminder',
        'It\'s time to study! Stay focused and productive.',
        scheduledDate,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'daily_reminder',
            'Daily Reminder',
            channelDescription: 'Notification for daily study reminder',
            importance: Importance.high,
            priority: Priority.high,
            enableLights: true,
            enableVibration: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
      print(
          'Success scheduling notification, scheduled date: ${scheduledDate}');
    } catch (e) {
      print('Error scheduling notification: $e');
    }
  }

  Future<void> cancelNotification() async {
    try {
      await flutterLocalNotificationsPlugin.cancel(0);
      print('Success canceling notification');
    } catch (e) {
      print('Error canceling notification: $e');
    }
  }
}
