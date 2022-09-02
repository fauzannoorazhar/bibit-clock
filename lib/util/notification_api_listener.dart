import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as timeZone;

class NotificationApiListener {
  static final notification = FlutterLocalNotificationsPlugin();
  static final listener = BehaviorSubject<String?>();

  static Future init({bool initScheduled = false}) async {
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final ios = IOSInitializationSettings();
    final initializationSettings = InitializationSettings(android: android, iOS: ios);
    await notification.initialize(
      initializationSettings,
      onSelectNotification: (payload) async {
        listener.add(payload);
      },
    );
  }

  static Future showNotificationSchedule({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduleDate,
  }) async =>
      notification.zonedSchedule(
          id,
          title,
          body,
          timeZone.TZDateTime.from(scheduleDate, timeZone.local),
          await notificationDetails(),
          payload: payload,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);

  static Future notificationDetails() async {
    const sound = 'alarm.wav';
    return const NotificationDetails(
        iOS: IOSNotificationDetails(
          sound: sound,
        ),
        android: AndroidNotificationDetails(
          'notif channel 1',
          'notificationChannel',
          channelDescription: '-',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          sound: RawResourceAndroidNotificationSound('alarm'),
          enableVibration: true,
        ));
  }

  static void cancel() => notification.cancelAll();
}
