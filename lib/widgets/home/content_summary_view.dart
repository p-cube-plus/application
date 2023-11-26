import 'package:flutter/material.dart';

class ContentSummaryView extends StatelessWidget {
  const ContentSummaryView({
    Key? key,
    required this.title,
    this.titleFontSize,
    this.descript,
    required this.onTap,
    this.children,
  }) : super(key: key);

  final String title;
  final double? titleFontSize;
  final Widget? descript;
  final List<Widget>? children;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    List<Widget> _barContents = <Widget>[
      Text(
        title,
        style: Theme.of(context).textTheme.headline1!.copyWith(
              fontSize: titleFontSize ?? 14.0,
              fontWeight: FontWeight.w700,
            ),
      ),
      GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Text(
              "자세히 보기",
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Icon(
              Icons.chevron_right,
              color: Theme.of(context).textTheme.headline2!.color,
              size: 20.0,
            ),
          ],
        ),
      ),
    ];
    if (descript != null) _barContents.insert(1, Expanded(child: descript!));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _barContents,
          ),
        ]..addAll(children ?? []),
      ),
    );
  }
}
