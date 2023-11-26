import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class NotificationNode {
  final String date;
  final String description;
  final int id;
  final String name;
  final int type;

  NotificationNode({
    required this.date,
    required this.description,
    required this.id,
    required this.name,
    required this.type,
  });

  factory NotificationNode.fromJson(Map<String, dynamic> json) {
    return NotificationNode(
      date: json['date'],
      description: json['description'],
      id: json['id'],
      name: json['name'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date,
        'description': description,
        'id': id,
        'name': name,
        'type': type,
      };
}
