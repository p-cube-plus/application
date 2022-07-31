import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
    this.height,
    this.actions,
    this.hasPrevious,
    this.padding,
  }) : super(key: key);

  final EdgeInsetsGeometry? padding;
  final String title;
  final double? height;
  final List<Widget>? actions;
  final bool? hasPrevious;

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgets = <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: actions ?? [],
            ),
          ),
        ],
      ),
    ];
    if (hasPrevious ?? false)
      _widgets.insert(
        0,
        Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 20.0,
            ),
          ),
        ),
      );

    return Padding(
      padding: padding ?? EdgeInsets.only(top: 40.0, bottom: 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
        ]..add(
            Container(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: _widgets,
              ),
            ),
          ),
      ),
    );
  }
}
