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
    client.getListData();

    return Scaffold(body:
        StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      return FutureBuilder(
          future: client.getListData(),
          builder: (context, AsyncSnapshot snapshot) {
            // response body가 받아와지는 동안 로딩
            //if (snapshot.connectionState == ConnectionState.waiting)
            //  return Center(
            //    child: CircularProgressIndicator(),
            //  );
            var result = snapshot.data as List<NotificationNode>;

            String str = "";
            for (var notification in result) {
              print("테스트: " + notification.description);
              str += "테스트: " + notification.description + "\n";
            }

            return Text(str);
            //return SingleChildScrollView(
            //    child: Container(
            //  height: 700,
            //  width: MediaQuery.of(context).size.width,
            //));
          });
    }));
  }
}
