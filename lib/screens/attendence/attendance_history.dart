import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/services/attendance_api.dart';
import 'package:p_cube_plus_application/widgets/common/default_futureBuilder.dart';
import 'package:p_cube_plus_application/widgets/page/default_page.dart';

class AttendanceHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultFutureBuilder(
        fetchData: AttendanceCheckApi(1).get(),
        showFunction: (data) => DefaultPage(
          title: "출석 현황",
          content: Column(
            children: [
              Text("정기회의 출석 현황"),
              Text("지난 정기회의 출석 현황을 확인할 수 있어요."),

            ],
          ),
        ));
  }
}
