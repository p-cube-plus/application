import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:p_cube_plus_application/models/schedule.dart';
import 'package:p_cube_plus_application/utilities/theme.dart';
import 'calendar_day_view.dart';

// Year, Month를 바탕으로 한 달 달력을 보여주는 위젯
class CalendarView extends StatefulWidget {
  const CalendarView({
    Key? key,
    required this.currentYearMonth,
    this.selectedDate,
    this.onSelectedDateChanged,
    required this.monthSchedule,
  }) : super(key: key);

  final DateTime currentYearMonth;
  final DateTime? selectedDate;
  final Function(DateTime)? onSelectedDateChanged;
  final Map<int, List<Schedule>> monthSchedule;

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> days = _getDays(context);
    //final _height = (days.length ~/ 7) * (widget.dayHeight ?? 0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        days.length ~/ 7,
        (i) => Container(
          child: Row(
            children: List.generate(7, (j) => days[i * 7 + j]),
          ),
        ),
      ),
    );
  }

  List<Widget> _getDays(BuildContext context) {
    List<Widget> days = <Widget>[];

    // 스크롤 인식을 위해 blank도 크기가 존재
    Widget _blank = Expanded(
        child: Container(
      height: 36,
      color: Colors.transparent,
    ));

    // 시작 날짜 초기화
    DateTime itr = widget.currentYearMonth
        .add(Duration(days: -widget.currentYearMonth.day + 1));

    // 앞 부분 공백
    for (int i = 0; i < itr.weekday % 7; i++) days.add(_blank);

    // 한 달의 날짜들을 얻기
    while (itr.month == widget.currentYearMonth.month) {
      Color selectedColor = itr.year == DateTime.now().year &&
              itr.month == DateTime.now().month &&
              itr.day == DateTime.now().day &&
              itr.difference(_selectedDate).inDays != 0
          ? Theme.of(context).dialogBackgroundColor
          : MyThemes.primary80;

      days.add(CalendarDayView(
          date: itr,
          // 선택: 현재 날짜 + 클릭된 날짜
          selected: itr.year == DateTime.now().year &&
                  itr.month == DateTime.now().month &&
                  itr.day == DateTime.now().day ||
              itr.day == _selectedDate.day &&
                  itr.difference(_selectedDate).inDays == 0,
          // 현재 날짜: 회색
          // 클릭 날짜: 붉은색
          selectedColor: selectedColor,
          onTap: (date) {
            setState(() {
              _selectedDate = date;
              widget.onSelectedDateChanged?.call(date);
            });
          },
          // type color의 첫번째 정보만 가져옴
          decorateColor: widget.monthSchedule[DateFormat.d().format(itr)]?[0]
              .getMarkColor()));
      itr = itr.add(const Duration(days: 1));
    }

    // 뒷 부분 공백
    int blanks = (7 - days.length % 7) % 7;
    for (int i = 0; i < blanks; i++) days.add(_blank);

    return days;
  }
}
