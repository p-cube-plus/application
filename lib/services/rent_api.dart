import 'dart:convert';

import '../models/rent.dart';
import 'pcube_api.dart';

class RentListApi extends PCubeApi {
  RentListApi({int? id})
      : super(endPoint: "/rent/" + (id?.toString() ?? "list"));

  Future<List<Rent>?> getRentList() async {
    Map<String, String>? headers = null;
    var response = await get(headers: headers);

    switch (response.statusCode) {
      case 200:
        List<dynamic> json = jsonDecode(response.body);
        //print(response.body);

        List<Rent> rentList = json.map<Rent>((e) => Rent.fromJson(e)).toList();

        return rentList;
      default:
        return null;
    }
  }

  Future<Rent?> getRentInformation() async {
    Map<String, String>? headers = null;
    var response = await get(headers: headers);

    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> json = jsonDecode(response.body);
        return Rent.fromJson(json);
      default:
        return null;
    }
  }
}
