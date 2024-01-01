import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:p_cube_plus_application/widgets/calendar/calendar_header.dart';
import 'package:p_cube_plus_application/widgets/calendar/calendar_week_row.dart';
import 'package:p_cube_plus_application/widgets/common/rounded_border.dart';
import 'package:p_cube_plus_application/widgets/page/default_appbar.dart';
import 'package:p_cube_plus_application/widgets/page/default_content.dart';
import 'package:p_cube_plus_application/widgets/page/default_page.dart';

class FeeNotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      appbar: DefaultAppBar(
        centerTitle: "회비 알림 설정",
      ),
      content: DefaultContent(
        child: Column(
          children: [
            _FeeMonthWidget(),
            _FeeCalendarWidget(),
          ],
        ),
      ),
    );
  }
}

class _FeeMonthWidget extends StatefulWidget {
  @override
  State<_FeeMonthWidget> createState() => _FeeMonthWidgetState();
}

class _FeeMonthWidgetState extends State<_FeeMonthWidget> {
  int _curYear = DateTime.now().year;

  _getCurYearInfo() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _getYearData(1),
            _getYearData(2),
            _getYearData(3),
            _getYearData(4),
            _getYearData(5),
            _getYearData(6),
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _getYearData(7),
            _getYearData(8),
            _getYearData(9),
            _getYearData(10),
            _getYearData(11),
            _getYearData(12),
          ],
        )
      ],
    );
  }

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
            --_curYear;
          else if (startX - endX > 50.0) ++_curYear;
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
                              onTap: () => setState(() => --_curYear),
                              child: Icon(Icons.chevron_left))),
                      Text(
                        _curYear.toString() + "년",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                                fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Padding(
                          padding: EdgeInsets.only(right: 22.5),
                          child: GestureDetector(
                              onTap: () => setState(() => ++_curYear),
                              child: Icon(Icons.chevron_right))),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: _getCurYearInfo(),
                ),
              ],
            ),
          )),
    );
  }

  _getYearData(int month) {
    return RoundedBorder(
      radius: 50,
      width: 36,
      height: 36,
      child: Center(
        child: Text(
          month.toString() + "월",
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class _FeeCalendarWidget extends StatefulWidget {
  @override
  State<_FeeCalendarWidget> createState() => _FeeCalendarWidgetState();
}

class _FeeCalendarWidgetState extends State<_FeeCalendarWidget> {
  DateTime _currentDate = DateTime.now();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initializeDateFormatting("ko_KR");
  }

  @override
  Widget build(BuildContext context) {
    double startX = 0.0, endX = 0.0;

    return GestureDetector(
        onHorizontalDragStart: (details) => startX = details.globalPosition.dx,
        onHorizontalDragUpdate: (details) => endX = details.localPosition.dx,
        onHorizontalDragEnd: (details) => _scrollAction(startX, endX),
        child: RoundedBorder(
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CalendarHeader(
                      date: _currentDate,
                      onArrowPressed: (newMonth) => setState(() =>
                          _currentDate =
                              new DateTime(_currentDate.year, newMonth)),
                    ),
                    CalendarWeekRow(),
                    SizedBox(height: 8),
                    // CalendarView(
                    //   scheduleProvider: widget.scheduleProvider,
                    //   currentDate: _currentDate,
                    //   selectedDate: widget.selectedDate,
                    //   selectFunction: widget.selectFunction,
                    // )
                  ])),
        ));
  }

  void _scrollAction(double startX, double endX) {
    const double scrollSensitivity = 20.0;
    if (endX - startX > scrollSensitivity) {
      setState(() => _currentDate = new DateTime(
            _currentDate.year,
            _currentDate.month - 1,
          ));
    } else if (startX - endX > scrollSensitivity) {
      setState(() => _currentDate = new DateTime(
            _currentDate.year,
            _currentDate.month + 1,
          ));
    }
  }
}
