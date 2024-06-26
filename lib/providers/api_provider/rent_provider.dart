import 'package:p_cube_plus_application/models/product.dart';
import 'package:p_cube_plus_application/models/rent.dart';
import 'package:p_cube_plus_application/providers/api_provider/base/provider_base.dart';
import 'dart:async';

class RentProvider extends ApiProviderBase<List<Rent>> {
  RentProvider() : super(getFunction: getDummy);
  Future<List<Rent>>? searchRentList(String name) async {
    return data
        .where((element) => element.product.name.contains(name))
        .toList();
  }

  static List<Rent> getDummy() {
    return <Rent>[
      Rent(
          product: Product(
              code: 0,
              isAvailable: true,
              name: "판도라큐브의 은밀한 물품",
              category: "책",
              location: "123-123",
              detailLocation: "456-789",
              modelName: null,
              status: ProductStatus(value: "0", rentUser: "권오민")),
          deadline: DateTime(2024, 12, 12),
          rentDay: DateTime(2022, 04, 04),
          dDay:
              DateTime(2024, 12, 12).difference(DateTime(2022, 04, 04)).inDays,
          returnDay: null),
      Rent(
          product: Product(
              code: 0,
              isAvailable: true,
              name: "운영체제 족보",
              category: "책",
              location: "123-123",
              detailLocation: "456-789",
              modelName: null,
              status: ProductStatus(value: "0", rentUser: "권오민")),
          deadline: DateTime(2024, 12, 12),
          rentDay: DateTime(2023, 09, 12),
          dDay:
              DateTime(2024, 12, 12).difference(DateTime(2023, 09, 12)).inDays,
          returnDay: null),
      Rent(
          product: Product(
              code: 0,
              isAvailable: true,
              name: "Clean Code",
              category: "책",
              location: "123-123",
              detailLocation: "456-789",
              modelName: null,
              status: ProductStatus(value: "0", rentUser: "권오민")),
          deadline: DateTime(2024, 12, 12),
          rentDay: DateTime(2023, 08, 21),
          dDay:
              DateTime(2024, 12, 12).difference(DateTime(2023, 08, 21)).inDays,
          returnDay: null),
    ];
  }
}
