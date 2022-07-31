import 'package:flutter/material.dart';
import '../sevices/notice_client.dart';

class NoticeBoxWidget extends StatelessWidget {
  const NoticeBoxWidget(this._box);

  final NotificationNode _box;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
            margin: EdgeInsets.only(left: 0, top: 12, right: 0, bottom: 0),
            elevation: 1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  leading: Icon(
                    Icons.lock_clock,
                    size: 32,
                  ),
                  trailing: Text(_box.date.toString(),
                      style: const TextStyle(
                        fontSize: 15,
                        height: 0,
                      )),
                  title: Text(
                    _box.id.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      height: 0,
                    ),
                  ),
                  subtitle: Text(
                    _box.description!,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.8,
                    ),
                  ),
                ),
              ],
            )));
  }
}
