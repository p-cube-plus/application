import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/widgets/list_divider_widget.dart';
import 'package:provider/provider.dart';

import '../../providers/setting_provider.dart';
import '../../widgets/default_page_widget.dart';
import '../../widgets/setting/subtext_tile.dart';
import '../../widgets/setting/switch_tile.dart';

class SettingNoticePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final noticeProvider = Provider.of<SettingProvider>(context);
    noticeProvider.changeState(SettingType.AllNotice);
    return DefaultPage(
      appBarTitle: "알림 설정",
      appBarHasPrevious: true,
      padding: 0.0,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _getChildren(noticeProvider),
      ),
    );
  }

  _getChildren(noticeProvider) {
    final result = <Widget>[
      SwitchTile(title: '전체 알림', type: SettingType.AllNotice),
    ];
    if (noticeProvider.isOn) {
      result.add(ListDivider());
      result.add(SubTextTile(title: '회비 알림'));
      result.add(
          SwitchTile(title: '정기회의 알림', type: SettingType.AllMeetingNotice));
      result.add(
          SwitchTile(title: '파트회의 알림', type: SettingType.PartMeetingNotice));
      result.add(ListDivider());
      result.add(SubTextTile(title: '기타 알림'));
      result.add(SwitchTile(title: '회비 알림', type: SettingType.DuesNotice));
      result.add(SwitchTile(title: '청소 알림', type: SettingType.CleanNotice));
      result.add(SwitchTile(title: '도서 대여 알림', type: SettingType.BookNotice));
    }
    return result;
  }
}
