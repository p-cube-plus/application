import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:p_cube_plus_application/widgets/rent/rent_button.dart';
import 'package:p_cube_plus_application/widgets/rent/rented_box.dart';

import '../../models/rent.dart';

Future<List<Rent>> _fetchRentList() async {
  final url = Uri.parse('http://p-cube-plus.com/rent/list');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    print(json.decode(response.body).runtimeType);
    return (json.decode(response.body) as List)
        .map((data) => Rent.fromJson(data))
        .toList();
  } else {
    throw Exception('Failed to load post');
  }
}

class RentedItemListView extends StatefulWidget {
  @override
  State<RentedItemListView> createState() => RentedItemListViewState();
}

class RentedItemListViewState extends State<RentedItemListView> {
  late Future<List<Rent>> rentAPI;

  @override
  void initState() {
    super.initState();
    rentAPI = _fetchRentList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Rent>>(
      future: rentAPI,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.all(0),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return RentedBox(rent: snapshot.data![index]);
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 24.0),
                child: RentButton(text: "스캔하기", isActive: true, isRent: true),
              )
            ],
          );
        } else if (snapshot.hasError) {
          return Text("정보를 불러올 수 없습니다.");
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
