import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/schedule_provider.dart';
import 'calendar_header.dart';
import 'calendar_week_row.dart';
import 'calender_view.dart';

class Calendar extends StatefulWidget {
  const Calendar({
    Key? key,
    this.onSelectedDateChanged,
    this.onViewDateChanged,
    this.isHomeCalendar = false,
  }) : super(key: key);

  final Function(DateTime)? onSelectedDateChanged;
  final Function(DateTime)? onViewDateChanged;
  final bool isHomeCalendar;

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  bool _initialized = false;

  DateTime _selectedDate = DateTime.now(); // 클릭된 Day 정보
  late DateTime _viewDate; // 현재 Year, Month 정보
  late Map<String, CalendarView> _calendars;
  CalendarView? _currentCalendar; // days view

  GlobalKey _headerKey = GlobalKey();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 한국어 Localization 데이터 가져오기.
    initializeDateFormatting("ko_KR");
  }

  @override
  void initState() {
    super.initState();
    _calendars = <String, CalendarView>{};
    _initialized = false;
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      _setDate(_selectedDate);
      _initialized = true;
      return Center(child: Text("불러오는중"));
    }
    late double startX, endX;

    // 달력 좌우 스크롤 액션
    return GestureDetector(
        onHorizontalDragStart: (details) => startX = details.globalPosition.dx,
        onHorizontalDragUpdate: (details) {
          endX = details.localPosition.dx;
        },
        onHorizontalDragEnd: (details) {
          setState(() {
            if (endX - startX > 20.0) {
              _setDate(new DateTime(
                _viewDate.year,
                _viewDate.month - 1,
              ));
            } else if (startX - endX > 20.0) {
              _setDate(new DateTime(
                _viewDate.year,
                _viewDate.month + 1,
              ));
            }
          });
        },
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CalendarHeader(
                key: _headerKey,
                date: _viewDate,
                onArrowPressed: (delta) {
                  _setDate(new DateTime(
                    _viewDate.year,
                    _viewDate.month + delta,
                  ));
                },
              ),
              CalendarWeekRow(),
              SizedBox(height: 8),
              _currentCalendar!
            ]));
  }

  // Year, Month를 받아 현재 Calender를 업데이트 하는 함수
  void _setDate(DateTime date) async {
    if (_initialized && date.month == _viewDate.month) return;
    _viewDate = date;

    await context.read<ScheduleProvider>().loadSchedules(_viewDate);
    CalendarView result = await _getCalendar();

    setState(() => _currentCalendar = result);
    widget.onViewDateChanged?.call(date);
  }

  // _viewDate(현재 Year, Month 정보)를 기반으로 CalenderView를 가져오는 함수
  Future<CalendarView> _getCalendar() async {
    String yMDate = DateFormat.yM().format(_viewDate);
    if (_calendars.containsKey(yMDate)) return _calendars[yMDate]!;

    _calendars[yMDate] = CalendarView(
      date: _viewDate,
      selectedDate: _selectedDate,
      onSelectedDateChanged: widget.onSelectedDateChanged,
      isHomeCalendar: widget.isHomeCalendar,
    );

    return _calendars[yMDate]!;
  }
}
