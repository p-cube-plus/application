import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class NotificationNode {
  final int id;
  final String? date;
  final String? day;
  final String time;
  final String? location;
  final String? schedule;
  final String? message;
  final bool isRead;

  NotificationNode({
    required this.id,
    required this.date,
    required this.day,
    required this.time,
    required this.location,
    required this.schedule,
    required this.message,
    required this.isRead,
  });

  factory NotificationNode.fromJson(Map<String, dynamic> json) {
    return NotificationNode(
      id: json["id"],
      date: json["date"],
      day: json["day"],
      time: json["time"],
      location: json["location"],
      schedule: json["schedule"],
      message: json["message"],
      isRead: json["is_read"],
    );
  }
}
