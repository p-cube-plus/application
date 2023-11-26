import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:p_cube_plus_application/widgets/executive/notification/required_text.dart';

import '../../common/rounded_border.dart';

class SetNotification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return RoundedBorder(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RequiredText(text: "알람 일정"),
          SizedBox(height: 20),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "매주",
                style: textTheme.headline5!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 8),
              ScrollableDate(["월", "화", "수", "목", "금", "토", "일"]),
              SizedBox(width: 8),
              Text(
                "요일",
                style: textTheme.headline5!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 32),
              ScrollableDate([
                for (int i = 19, cnt = 0; cnt < 24; ++cnt, i = (i + 1) % 24)
                  i.toString()
              ]),
              SizedBox(width: 8),
              Text("시"),
              SizedBox(width: 16),
              ScrollableDate([for (int i = 0; i < 60; ++i) i.toString()]),
              SizedBox(width: 8),
              Text("분"),
            ],
          ),
        ],
      ),
    );
  }
}

class ScrollableDate extends StatefulWidget {
  ScrollableDate(this.words);
  final List<String> words;

  @override
  State<ScrollableDate> createState() => _ScrollableDateState();
}

class _ScrollableDateState extends State<ScrollableDate> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 105,
      child: CupertinoPicker(
        selectionOverlay: null,
        useMagnifier: false,
        backgroundColor: Theme.of(context).cardColor,
        itemExtent: 55,
        diameterRatio: 10,
        offAxisFraction: -1,
        onSelectedItemChanged: (i) {
          setState(() {
            _selected = i;
          });
        },
        children: _getChildren(),
        looping: true,
      ),
    );
  }

  _getChildren() {
    List<Widget> children = <Widget>[];
    for (int i = 0; i < widget.words.length; ++i)
      children.add(Center(
        child: Text(widget.words[i],
            style: _selected == i
                ? Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    )
                : Theme.of(context).textTheme.headline3!.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    )),
      ));
    return children;
  }
}
