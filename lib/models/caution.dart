import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Caution {
  final int id;
  final int type;
  final double amount;
  final String description;
  final DateTime date;

  Caution({
    required this.id,
    required this.type,
    required this.description,
    required this.date,
    required this.amount,
  });

  factory Caution.fromJson(Map<String, dynamic> json) {
    return Caution(
      id: json['id'],
      type: json['type'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      amount: json['warning_amount'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'warning_amount': amount,
        'description': description,
        'date': date.toString(),
      };
}
