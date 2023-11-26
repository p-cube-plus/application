import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:p_cube_plus_application/models/schedule.dart';
import 'package:provider/provider.dart';

import '../../../providers/schedule_provider.dart';
import '../../common/rounded_border.dart';

// 클린된 날짜 일정 타임라인을 보여주는 위젯
class CalendarDailySummaryView extends StatelessWidget {
  const CalendarDailySummaryView({
    Key? key,
    required this.selectedDate,
  }) : super(key: key);

  final DateTime selectedDate; // 클릭된 Day 정보

  @override
  Widget build(BuildContext context) {
    List<Schedule>? _schedules = context
        .watch<ScheduleProvider>()
        .dailySchedules[DateFormat.yMd().format(selectedDate)];

    bool _hasSchedule = false;
    List<Widget> _widgets = List.generate(
      _schedules?.length ?? 0,
      (index) {
        if (_schedules![index].hasSpan) return Container();
        _hasSchedule = true;

        return Padding(
          padding: EdgeInsets.only(top: 28.0 * index.sign),
          child: Row(
            children: [
              Container(
                height: 7.0,
                width: 7.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _schedules[index].getMarkColor()),
              ),
              SizedBox(width: 16.0),
              Text(
                DateFormat("a hh:mm", "ko_KR").format(
                    selectedDate.day == _schedules[index].startDate?.day
                        ? _schedules[index].startDate ?? DateTime(0)
                        : DateTime(0)),
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              SizedBox(width: 8.0),
              Text(
                _schedules[index].name,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        );
      },
    );

    if (!_hasSchedule) return Container();
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: RoundedBorder(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat("yyyy.MM.dd").format(selectedDate),
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            SizedBox(height: 16.0),
            Stack(
              alignment: Alignment.topLeft,
              children: [
                Positioned(
                  left: 3,
                  top: 9,
                  child: Container(
                    color: Theme.of(context).dialogBackgroundColor,
                    height: (_schedules!.length - 1) * 42.0,
                    width: 1,
                  ),
                ),
                Column(children: _widgets),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 이번달 일주일 후까지의 정보를 가져옴
// => 마지막 주일 때 다음달 정보 가져오는 예외처리 안 함
class CalendarMonthlySummaryView extends StatelessWidget {
  const CalendarMonthlySummaryView({
    Key? key,
    required this.viewDate,
  }) : super(key: key);

  final DateTime viewDate;

  @override
  Widget build(BuildContext context) {
    List<Schedule>? _schedules = context
        .watch<ScheduleProvider>()
        .monthlySchedules[DateFormat.yM().format(viewDate)];

    bool _hasSchedule = false;
    List<Widget> widgets = List.generate(
      _schedules?.length ?? 0,
      (index) {
        Schedule _schedule = _schedules![index];
        if (!_schedule.hasSpan && _schedule.startDate == null)
          return Container();

        DateTime start = _schedule.startDate!;
        DateTime end = _schedule.endDate ?? start;

        // 이전 정보는 버림
        if (DateTime.now().isAfter(end)) return Container();

        // 일주일 후까지의 정보만 가져옴
        var weekLater = DateTime.now().add(Duration(days: 7));
        if (!start.difference(weekLater).isNegative) return Container();

        bool span = _schedule.hasSpan &&
            !(start.day == end.day && start.difference(end).inDays <= 0);

        _hasSchedule = true;

        return Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: RoundedBorder(
            height: 48.0,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Container(
                  height: 7.0,
                  width: 7.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _schedules[index].getMarkColor()),
                ),
                SizedBox(width: 12.0),
                Text(
                  "${DateFormat("yyyy.MM.dd").format(start)}" +
                      (span
                          ? "\n~ ${DateFormat("yyyy.MM.dd").format(end)}"
                          : ""),
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                SizedBox(width: 8.0),
                Text(
                  _schedule.name,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
        );
      },
    );
    if (!_hasSchedule) return Container();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "다가오는 일정",
          style: Theme.of(context).textTheme.headline1!.copyWith(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
              ),
        ),
        SizedBox(height: 8.0),
      ]..addAll(widgets),
    );
  }
}
