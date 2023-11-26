import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Seminar {
  final int id;
  final int type; // 0 수습, 1 정회원, 2 졸업생?
  final String description;
  final DateTime date; // 시작 시간

  Seminar({
    required this.id,
    required this.type,
    required this.description,
    required this.date,
  });

  factory Seminar.fromJson(Map<String, dynamic> json) {
    return Seminar(
      id: json['id'],
      type: json['type'],
      description: json['description'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'description': description,
        'date': date.toString(),
      };
}
