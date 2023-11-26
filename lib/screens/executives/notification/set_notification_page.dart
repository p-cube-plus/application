import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:p_cube_plus_application/widgets/executive/notification/required_text.dart';

import '../../../widgets/executive/notification/notifitation_input.dart';
import '../../../widgets/executive/notification/set_notification.dart';
import '../../../widgets/page/default_appbar.dart';
import '../../../widgets/page/default_content.dart';
import '../../../widgets/page/default_page.dart';

class SetNotificationPage extends StatelessWidget {
  const SetNotificationPage(this.title);
  final String title;
  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      appbar: DefaultAppBar(
        centerTitle: title,
      ),
      content: DefaultContent(
        bottomButtonText: "확인",
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SetNotification(),
            SizedBox(height: 8),
            NotificationInput(RequiredText(text: "장소")),
            SizedBox(height: 8),
            NotificationInput(RequiredText(text: "일정")),
            SizedBox(height: 8),
            NotificationInput(RequiredText(text: "메모", isRequired: false)),
          ],
        ),
      ),
    );
  }
}
