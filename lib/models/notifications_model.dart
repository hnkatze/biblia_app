import 'package:hive/hive.dart';

part 'notifications_model.g.dart';

@HiveType(typeId: 0)
class NotificationModel {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String body;

  @HiveField(2)
  final DateTime dateTime;

  @HiveField(3)
  final bool isRead;

  @HiveField(4)
  final String verse;

  NotificationModel({
    required this.title,
    required this.body,
    required this.dateTime,
    required this.verse,
    this.isRead = false,
  });
}
