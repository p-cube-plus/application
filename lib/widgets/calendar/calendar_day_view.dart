import 'package:flutter/material.dart';

import '../../utilities/theme.dart';

class CalendarDayView extends StatelessWidget {
  const CalendarDayView({
    Key? key,
    required this.date,
    this.selected = false,
    this.onTap,
    this.decorateColor,
    this.selectedColor = MyThemes.primary80,
    this.isExecutive = false,
  }) : super(key: key);

  final DateTime date; // day 정보
  final bool selected; // 현재 날짜 or 클릭된 날짜
  final Function(DateTime)? onTap; // 터치 시 작동 함수
  final Color? decorateColor; // 날짜 아래 색
  final Color selectedColor; // 날짜를 덮는 큰 원의 색

  final bool isExecutive; // 임원진 달력

  @override
  Widget build(BuildContext context) {
    Widget view = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          date.day.toString(),
          style: selected
              ? TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                )
              : Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
        ),
        SizedBox(height: 2.0),
        Container(
          height: 4.0,
          width: 4.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: !selected && decorateColor != null
                ? decorateColor
                : Colors.transparent,
          ),
        ),
      ],
    );

    return Expanded(
      child: InkWell(
        onTap: () => onTap?.call(date),
        child: Container(
          height: 38,
          // 현재 날짜 or 클릭 시 날짜를 덮는 큰 원이 생김
          child: selected
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Container(
                        height: 24.0,
                        width: 24.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: selectedColor,
                        ),
                      ),
                    ),
                    view
                  ],
                )
              : view,
        ),
      ),
    );
  }
}
