import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget {
  const DefaultAppBar({
    this.centerTitle,
    this.leftTitle,
    this.leftTitleState,
    this.hasPrevious = true,
    this.contentColor,
    this.backgroundColor,
    this.bottomPadding = 24.0,
  });
  final String? centerTitle;
  final String? leftTitle;
  final Widget? leftTitleState;
  final bool hasPrevious;
  final Color? contentColor;
  final Color? backgroundColor;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final topPadding = (leftTitleState == null) ? 19.0 : 34.0;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.0,
          color: backgroundColor ?? theme.backgroundColor,
        ),
        color: backgroundColor ?? theme.backgroundColor,
      ),
      padding: EdgeInsets.only(
          left: 24.0,
          right: 24.0,
          top: statusBarHeight + topPadding,
          bottom: bottomPadding),
      child: Row(
        mainAxisAlignment: centerTitle != null
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.start,
        children: [
          if (hasPrevious)
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 20.0,
                color: contentColor ?? theme.textTheme.headline1!.color,
              ),
            )
          else
            SizedBox(),
          if (centerTitle != null)
            Text(
              centerTitle!,
              style: theme.textTheme.headline1!.copyWith(
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
                color: contentColor ?? theme.textTheme.headline1!.color,
              ),
            ),
          if (leftTitle != null)
            Padding(
              padding: EdgeInsets.only(left: 16.0, right: 4.0),
              child: Row(
                children: [
                  Text(
                    leftTitle!,
                    style: theme.textTheme.headline1!.copyWith(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      color: contentColor ?? theme.textTheme.headline1!.color,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 8), child: leftTitleState)
                ],
              ),
            ),
          SizedBox(width: centerTitle != null ? 20.0 : 0.0)
        ],
      ),
    );
  }
}
