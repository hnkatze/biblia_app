import 'package:biblia_meno/models/notifications_model.dart';
import 'package:biblia_meno/utils/local_notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:timezone/timezone.dart';

Future<void> saveVerse(NotificationModel verse) async {
  final box = Hive.box<NotificationModel>('notifications');
  await box.put(verse.verse, verse);
}

Future<void> scheduleVerseNotification(NotificationModel verse) async {
  final timeZone = getLocation('America/Tegucigalpa');
  final scheduledDate = TZDateTime.from(
    verse.dateTime,
    timeZone,
  );

  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'verse_channel',
    'verse Reminders',
    importance: Importance.max,
    priority: Priority.high,
  );

  const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

  const NotificationDetails platformDetails = NotificationDetails(
    android: androidDetails,
    iOS: iosDetails,
  );

  await notificationsPlugin.zonedSchedule(
    verse.hashCode, // ID único
    'versiculo diario',
    verse.body,
    scheduledDate,
    platformDetails,
    matchDateTimeComponents: DateTimeComponents.time,
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  );
}
