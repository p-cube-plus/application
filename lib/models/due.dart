import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Due {
  final DateTime date;
  final String name;
  final int charge;

  Due({
    required this.date,
    required this.name,
    required this.charge,
  });

  //ProduDuect({
  //});

  // factory Due.fromJson(Map<String, dynamic> json) {
  //   return Due(
  //   );
  // }

  // Map<String, dynamic> toJson() => {
  //     };
}
