import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:p_cube_plus_application/models/product.dart';

@JsonSerializable()
class Rent {
  final Product product;
  final DateTime deadline;
  final DateTime rentDay;
  final int dDay;
  final DateTime? returnDay;

  Rent({
    required this.product,
    required this.deadline,
    required this.rentDay,
    required this.dDay,
    required this.returnDay,
  });

  factory Rent.fromJson(Map<String, dynamic> json) {
    return Rent(
      product: Product.fromJson(json['product']),
      deadline: DateTime.parse(json['deadline']),
      rentDay: DateTime.parse(json['rent_day']),
      dDay: json['d_day'],
      returnDay: DateTime.parse(json['return_day']),
    );
  }

  Map<String, dynamic> toJson() => {
        'product': product.toJson(),
        'deadline': DateFormat('yyyy-mm-dd').format(deadline),
        'rent_day': DateFormat('yyyy-mm-dd').format(rentDay),
        'd_day': dDay,
        'return_day': returnDay == null
            ? null
            : DateFormat('yyyy-mm-dd').format(returnDay!),
      };
}
