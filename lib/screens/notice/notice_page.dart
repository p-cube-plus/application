import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:p_cube_plus_application/providers/notice_provider.dart';
import 'package:p_cube_plus_application/widgets/page/default_content.dart';
import 'package:provider/provider.dart';

import '../../models/notification_node.dart';
import '../../widgets/common/rounded_border.dart';
import '../../widgets/page/default_page.dart';
import '../../widgets/page/default_tabbar.dart';
import '../settings/setting_notice_page.dart';

class NoticePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var noticeProvider = context.watch<NoticeProvider>();

    if (!noticeProvider.loaded)
      return Center(child: CircularProgressIndicator());

    if (noticeProvider.fail)
      return Center(child: Text(noticeProvider.errorMessage!));

    return DefaultPage(
      title: "알림",
      action: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SettingNoticePage(),
            ),
          );
        },
        child: Icon(
          Icons.settings,
          color: Theme.of(context).textTheme.headline2!.color,
        ),
      ),
      content: DefaultTabBar(tabs: [
        DefaultTab(
            title: "새 알림",
            page: NoticeListView(
              isNew: true,
              noticeList: noticeProvider.curList!,
            )),
        DefaultTab(
            title: "읽은 알림",
            page: NoticeListView(
              isNew: false,
              noticeList: noticeProvider.curList!,
            )),
      ]),
    );
  }
}

class NoticeListView extends StatelessWidget {
  const NoticeListView({
    Key? key,
    required this.isNew,
    required this.noticeList,
  }) : super(key: key);

  final List<NotificationNode> noticeList;
  final bool isNew;

  @override
  Widget build(BuildContext context) {
    return DefaultContent(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
              noticeList.length,
              (index) => Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child:
                      NoticeBoxWidget(isNew: isNew, box: noticeList[index])))),
    );
  }
}

class NoticeBoxWidget extends StatelessWidget {
  const NoticeBoxWidget({required this.isNew, required this.box});

  final NotificationNode box;
  final bool isNew;

  @override
  Widget build(BuildContext context) {
    return RoundedBorder(
      onTap: () {},
      hasShadow: true,
      color: isNew
          ? Theme.of(context).bottomNavigationBarTheme.backgroundColor
          : Theme.of(context).disabledColor,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    box.name,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  SizedBox(width: 4.0),
                  if (isNew)
                    Container(
                      height: 4.0,
                      width: 4.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor),
                    ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                box.description,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ],
          ),
          Text(
            DateFormat("hh:mm").format(DateTime.parse(box.date)),
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ],
      ),
    );
  }
}
