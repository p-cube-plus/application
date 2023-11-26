import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/setting_provider.dart';
import '../../widgets/common/list_divider.dart';
import '../../widgets/page/default_appbar.dart';
import '../../widgets/page/default_page.dart';
import '../../widgets/setting/setting_switch_tile.dart';

class SettingNoticePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final noticeProvider = Provider.of<SettingProvider>(context);
    noticeProvider.changeState(SettingType.AllNotice);
    return DefaultPage(
      title: "알림 설정",
      appbar: DefaultAppBar(),
      content: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchTile(title: '알림 허용', type: SettingType.AllNotice),
          ]..addAll(noticeProvider.isOn
              ? [
                  ListDivider(horizontal: 20.0, vertial: 10.0),
                  _getSubTitle(theme, '회의 알림'),
                  SwitchTile(
                      title: '정기회의 알림', type: SettingType.AllMeetingNotice),
                  SwitchTile(
                      title: '파트회의 알림', type: SettingType.PartMeetingNotice),
                  ListDivider(horizontal: 20.0, vertial: 10.0),
                  _getSubTitle(theme, '기타 알림'),
                  SwitchTile(title: '회비 알림', type: SettingType.DuesNotice),
                  SwitchTile(title: '청소 알림', type: SettingType.CleanNotice),
                  SwitchTile(title: '도서 대여 알림', type: SettingType.BookNotice),
                ]
              : [SizedBox()]),
        ),
      ),
    );
  }

  _getSubTitle(ThemeData theme, title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Text(title,
          style: theme.textTheme.headline2!
              .copyWith(fontSize: 10.0, fontWeight: FontWeight.w400)),
    );
  }
}
