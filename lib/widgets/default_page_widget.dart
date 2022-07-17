import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'custom_appbar_widget.dart';

class DefaultPage extends StatelessWidget {
  const DefaultPage({
    Key? key,
    required this.appBarTitle,
    this.appBarActions,
    this.appBarHasPrevious,
    this.content,
    this.padding,
  }) : super(key: key);

  final String appBarTitle;
  final List<Widget>? appBarActions;
  final bool? appBarHasPrevious;
  final Widget? content;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Theme.of(context).backgroundColor,
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomAppBar(
              title: appBarTitle,
              actions: appBarActions,
              hasPrevious: appBarHasPrevious,
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding ?? 20.0),
            child: SingleChildScrollView(child: content),
          )),
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
