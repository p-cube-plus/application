import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Curriculum {
  final bool completed;
  final String? name;
  final DateTime? startDate;
  final DateTime? endDate;

  Curriculum({
    required this.completed,
    required this.name,
    required this.startDate,
    required this.endDate,
  });

  factory Curriculum.fromJson(Map<String, dynamic> json) {
    return Curriculum(
      completed: json['completed'],
      name: json['current_curriculum'],
      startDate: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date']),
      endDate:
          json['end_date'] == null ? null : DateTime.parse(json['end_date']),
    );
  }

  Map<String, dynamic> toJson() => {
        'completed': completed,
        'current_curriculum': name,
        'start_date': startDate?.toString() ?? null,
        'end_date': endDate?.toString() ?? null,
      };
}
