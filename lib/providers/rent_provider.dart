import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../services/rent_api.dart';
import '../models/rent.dart';

class RentProvider with ChangeNotifier {
  late RentListApi _client;

  bool loaded = false;
  bool fail = false;
  String? errorMessage;

  late List<Rent>? _rentList;
  List<Rent>? get rentList => loaded ? _rentList : null;

  RentProvider() {
    initialize();
  }

  Future<List<Rent>?> _getRents() async {
    _client = RentListApi();
    List<Rent>? _rentList = await _client.getRentList();

    //_client = RentListApi(id: 1);
    //Rent? _rent = await _client.getRentInformation();
    //print(_rent!.toJson().toString());

    return _rentList;
  }

  Future initialize() async {
    fail = false;
    loaded = false;
    _rentList = await fetchRentList();
    notifyListeners();
  }

  Future<List<Rent>?> fetchRentList() async {
    final url = Uri.parse('http://p-cube-plus.com/proeuct/list');
    final response = await http.get(url);

    if (response.statusCode == 200 && response.body.length > 0) {
      try {
        loaded = true;
        return (json.decode(response.body) as List)
            .map((data) => Rent.fromJson(data))
            .toList();
      } catch (e) {
        fail = true;
        errorMessage = "데이터 변환 실패";
        return null;
      }
    } else {
      fail = true;
      errorMessage = "데이터 불러오기 실패";
      return null;
    }
  }

  Future<List<Rent>>? searchRentList(String name) async {
    return _rentList!
        .where((element) => element.product.name.contains(name))
        .toList();
  }

  Rent? getRent(int index) {
    if (!loaded) return null;
    return _rentList![index];
  }

  void update() async {
    // 데이터 갱신
    _rentList = await _getRents();

    fail = _rentList == null;
    loaded = true;

    //print(getRent(id: 1)!.toJson());

    notifyListeners();
  }
}
