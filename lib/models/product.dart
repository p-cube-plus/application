import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ProductStatus {
  final String value; // ["대여 가능", "대여 중", "대여 불가"]
  final String? rentUser;

  ProductStatus({
    required this.value,
    required this.rentUser,
  });

  factory ProductStatus.fromJson(Map<String, dynamic> json) {
    return ProductStatus(
      value: json['value'],
      rentUser: json['rent_user'],
    );
  }
}

@JsonSerializable()
class Product {
  final int code;
  final bool isAvailable;
  final String name;
  final String category;
  final String? location; // ex. 서랍..
  final String? detailLocation; // ex. 서랍 2번째 줄..?
  final String? modelName; // ex. 모니터 종류?
  final ProductStatus status;
  final String? author; // 물품 주인 (기증자 등)
  final String? publisher;

  Product({
    required this.code,
    required this.isAvailable,
    required this.name,
    required this.category,
    required this.location,
    required this.detailLocation,
    required this.modelName,
    required this.status,
    this.author,
    this.publisher,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      code: json['code'],
      isAvailable: json['is_available'],
      name: json['name'],
      category: json['category'],
      location: json['location'],
      detailLocation: json['detail_location'],
      modelName: json['model_name'],
      status: ProductStatus.fromJson(json['status']),
      author: json['author'],
      publisher: json['publisher'],
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'is_available': isAvailable,
        'name': name,
        'category': category,
        'location': location,
        'detail_location': detailLocation,
        'model_name': modelName,
        'status': {
          'value': status.value,
          'rent_user': status.rentUser,
        },
        'author': author,
        'publisher': publisher,
      };
}
