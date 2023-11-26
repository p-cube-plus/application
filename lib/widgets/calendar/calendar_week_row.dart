import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarWeekRow extends StatelessWidget {
  const CalendarWeekRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (index) {
        return Expanded(
          child: Text(
            DateFormat('E', "ko_KR").dateSymbols.SHORTWEEKDAYS[(index) % 7],
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline3!.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
          ),
        );
      }),
    );
  }
}
