import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/sevices/notice_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    dio.options.headers["Content-Type"] = "application/json";
    final client = NotificationClient(dio);

    return Scaffold(body:
        StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      return FutureBuilder(
          future: client.getListData(),
          initialData: [],
          builder: (context, AsyncSnapshot snapshot) {
            // response body가 받아와지는 동안 로딩
            //if (snapshot.connectionState == ConnectionState.waiting)
            //  return Center(
            //    child: CircularProgressIndicator(),
            //  );

            print("테스트: " + snapshot.data);

            return Text("테스트: " + snapshot.data);
            //return SingleChildScrollView(
            //    child: Container(
            //  height: 700,
            //  width: MediaQuery.of(context).size.width,
            //));
          });
    }));
  }
}
