import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:p_cube_plus_application/widgets/calendar/calendar.dart';

import '../../../widgets/calendar/Home/calendar_summary_view.dart';
import '../../../widgets/common/rounded_border.dart';
import '../../../widgets/page/default_appbar.dart';
import '../../../widgets/page/default_content.dart';
import '../../../widgets/page/default_page.dart';

class CleaningNotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      appbar: DefaultAppBar(
        centerTitle: "청소 알림",
      ),
      content: DefaultContent(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [CleaningCalendar()],
        ),
      ),
    );
  }
}

class CleaningCalendar extends StatefulWidget {
  @override
  State<CleaningCalendar> createState() => _CleaningCalendarState();
}

class _CleaningCalendarState extends State<CleaningCalendar> {
  // @override
  // Widget build(BuildContext context) {
  //   return Calendar(
  //     onSelectedDateChanged: (date) {
  //       setState(() {
  //         _selectedDate = date;
  //       });
  //     },
  //   );
  // }

  DateTime _selectedDate = DateTime.now();
  DateTime _viewDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RoundedBorder(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
          child: Calendar(
            onSelectedDateChanged: (date) =>
                setState(() => _selectedDate = date),
            onViewDateChanged: (date) => setState(() {
              _viewDate = date;
            }),
            isHomeCalendar: true,
          ),
        ),
        if (_viewDate.month == _selectedDate.month &&
            _viewDate.difference(_selectedDate).inDays.abs() < 32)
          CalendarDailySummaryView(
            selectedDate: _selectedDate,
          )
        else
          Container(),
      ], //..add(SizedBox(height: 20.0)),
    );
  }
}
