import 'package:flutter/material.dart';

enum MessageType {
  OK,
  OKCancel,
}

class DefaultAlert extends StatelessWidget {
  const DefaultAlert({
    this.backgroundColor,
    required this.title,
    required this.messageType,
    this.description,
    this.children,
    this.onTap,
  });

  final Color? backgroundColor;
  final String title;
  final String? description;
  final MessageType messageType;
  final List<Widget>? children;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isCenterTitle = description != null;
    return AlertDialog(
        backgroundColor: backgroundColor ?? theme.backgroundColor,
        insetPadding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0))),
        contentPadding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: isCenterTitle ? 36.0 : 24.0,
            bottom: 16.0),
        content: Container(
          width: double.infinity,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: isCenterTitle
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.headline1!.copyWith(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (isCenterTitle)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 32.0),
                    child: Text(
                      description!,
                      style: theme.textTheme.headline1!.copyWith(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
              ]
                ..addAll(children ?? [SizedBox()])
                ..add(messageType == MessageType.OK
                    ? Container(
                        width: double.infinity,
                        height: 35.0,
                        child: ElevatedButton(
                          onPressed: onTap ?? () => Navigator.pop(context),
                          child:
                              Text("확인", style: TextStyle(color: Colors.white)),
                        ))
                    : Container(
                        width: double.infinity,
                        height: 35.0,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("취소",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w700)),
                                style: Theme.of(context)
                                    .elevatedButtonTheme
                                    .style!
                                    .copyWith(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Theme.of(context)
                                                    .dialogBackgroundColor)),
                              ),
                            ),
                            SizedBox(width: 16.0),
                            Expanded(
                              child: ElevatedButton(
                                  onPressed:
                                      onTap ?? () => Navigator.pop(context),
                                  child: Text("확인",
                                      style: TextStyle(color: Colors.white))),
                            )
                          ],
                        ),
                      ))),
        ));
  }
}
