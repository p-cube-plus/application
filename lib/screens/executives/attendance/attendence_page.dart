import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:p_cube_plus_application/widgets/common/rounded_border.dart';
import 'package:p_cube_plus_application/widgets/page/default_appbar.dart';
import 'package:p_cube_plus_application/widgets/page/default_content.dart';
import 'package:p_cube_plus_application/widgets/page/default_tabbar.dart';
import '../../../widgets/common/default_bottomsheet.dart';
import '../../../widgets/executive/notification/set_notification.dart';
import '../../../widgets/page/default_page.dart';
import 'attendence_addition.dart';
import 'attendence_tab.dart';

class AttendencePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      title: "출석",
      textColor: Colors.white,
      backgroundColor: Theme.of(context).primaryColor,
      appbar: DefaultAppBar(
        contentColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      content: DefaultContent(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: SelectAttendenceDay(),
        ),
        bottomPadding: 24,
        bottomWidget: Container(
          padding: const EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor,
                blurRadius: 4.0,
                spreadRadius: 0.0,
                offset: Offset.fromDirection(0.0, 16.0),
              )
            ],
          ),
          child: DefaultTabBar(
            isCenter: true,
            tabHeight: 8,
            tabs: [
              DefaultTab(title: "전체", page: AttendenceAll()),
              DefaultTab(title: "출석", page: AttendenceAll()),
              DefaultTab(title: "지각", page: AttendenceAll()),
              DefaultTab(title: "불참", page: AttendenceAll()),
            ],
          ),
        ),
      ),
      floatingActionButton: _getFloatingButton(context),
    );
  }

  Widget _getFloatingButton(context) {
    return SizedBox(
      width: 64,
      height: 64,
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return AttendenceAddition();
          }));
        },
        elevation: 7.68,
        focusElevation: 7.68,
        hoverElevation: 7.68,
        disabledElevation: 7.68,
        highlightElevation: 7.68,
        child: Center(
          child: Text(
            "+",
            style: TextStyle(
              fontSize: 56,
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}

class SelectAttendenceDay extends StatefulWidget {
  @override
  State<SelectAttendenceDay> createState() => _SelectAttendenceDayState();
}

class _SelectAttendenceDayState extends State<SelectAttendenceDay> {
  DateTime _curDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  Widget build(BuildContext context) {
    late double startX, endX;
    return GestureDetector(
      onHorizontalDragStart: (details) => startX = details.globalPosition.dx,
      onHorizontalDragUpdate: (details) {
        endX = details.localPosition.dx;
      },
      onHorizontalDragEnd: (details) {
        setState(() {
          if (endX - startX > 50.0)
            _curDate = _curDate.subtract(const Duration(days: 1));
          else if (startX - endX > 50.0)
            _curDate = _curDate.add(const Duration(days: 1));
        });
      },
      child: RoundedBorder(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Padding(
            padding: EdgeInsets.only(bottom: 32, top: 20),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 22.5),
                          child: GestureDetector(
                              onTap: () => setState(() => _curDate =
                                  _curDate.subtract(const Duration(days: 1))),
                              child: Icon(Icons.chevron_left))),
                      Text(
                        DateFormat('M월 d일').format(_curDate),
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Padding(
                          padding: EdgeInsets.only(right: 22.5),
                          child: GestureDetector(
                              onTap: () => setState(() => _curDate =
                                  _curDate.add(const Duration(days: 1))),
                              child: Icon(Icons.chevron_right))),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      SelectAttendenceBox("1차 인증", "18시 50분 00초 ~ 19시 09분 59초"),
                      SizedBox(height: 14),
                      SelectAttendenceBox("2차 인증", "눌러서 2차 인증 시간을 설정해주세요"),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class SelectAttendenceBox extends StatelessWidget {
  const SelectAttendenceBox(this.title, this.timeText);
  final String title;
  final String timeText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline1!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: RoundedBorder(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              timeText,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            radius: 40.0,
            color: Theme.of(context).dialogBackgroundColor,
            onTap: () => showModalBottomSheet(
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20))),
                context: context,
                builder: (context) => _MakeBottomsheet(context, title)),
          ),
        ),
      ],
    );
  }

  _MakeBottomsheet(context, title) {
    return DefaultBottomsheet(
      title: title + " 시간",
      contents: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "시작 시간",
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              SizedBox(height: 8),
              SetNotification(),
              SizedBox(height: 16),
              Text(
                "마감 시간",
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              SizedBox(height: 8),
              SetNotification(),
            ],
          ),
        ),
        SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(onPressed: () {}, child: Text("확인"))),
        ),
      ],
    );
  }
}
