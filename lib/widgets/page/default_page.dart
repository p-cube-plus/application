import 'package:flutter/material.dart';
import 'default_appbar.dart';

class DefaultPage extends StatelessWidget {
  const DefaultPage({
    this.appbar,
    this.title,
    this.subtitle,
    this.content,
    this.bottomContent,
    this.action,
    this.decorate,
    this.floatingActionButton,
    this.textColor,
    this.contentColor,
    this.backgroundColor,
    this.bottomPadding = 20.0,
  });

  final DefaultAppBar? appbar;
  final String? title;
  final String? subtitle;
  final Widget? content;
  final Widget? bottomContent;
  final Widget? action;
  final Widget? decorate;
  final Widget? floatingActionButton;
  final Color? textColor;
  final Color? contentColor;
  final Color? backgroundColor;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final topPadding = title == null
        ? 0.0
        : (appbar != null)
            ? 6.0
            : MediaQuery.of(context).padding.top + 34.0;
    return Scaffold(
      backgroundColor: contentColor ?? theme.backgroundColor,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (appbar != null) appbar!,
          Container(
            decoration: BoxDecoration(
                color: backgroundColor ?? contentColor ?? theme.backgroundColor,
                border: Border.all(
                  width: 0.0,
                  color:
                      backgroundColor ?? contentColor ?? theme.backgroundColor,
                )),
            child: Padding(
              padding: EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: topPadding,
                  bottom: bottomPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (title != null)
                        Text(title!,
                            style: theme.textTheme.headline1!.copyWith(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w700,
                                color: textColor ??
                                    theme.textTheme.headline1!.color)),
                      if (subtitle != null)
                        Padding(
                          padding: EdgeInsets.only(top: 4.0),
                          child: Text(subtitle!,
                              style: theme.textTheme.headline1!.copyWith(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                  color: textColor ??
                                      theme.textTheme.headline1!.color)),
                        ),
                    ],
                  ),
                  action ?? SizedBox(),
                ],
              ),
            ),
          ),
          if (decorate != null) decorate!,
          Expanded(child: content ?? SizedBox()),
          bottomContent ?? SizedBox(),
        ],
      ),
      
      resizeToAvoidBottomInset: false,
      floatingActionButton: floatingActionButton,
    );
  }
}
