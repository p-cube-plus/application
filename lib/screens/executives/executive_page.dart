import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/screens/executives/notification/executive_notification_page.dart';
import '../../widgets/common/rounded_border.dart';
import '../../widgets/page/default_appbar.dart';
import '../../widgets/page/default_content.dart';
import '../../widgets/page/default_page.dart';

class ExecutivePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      appbar: DefaultAppBar(),
      title: "임원진",
      subtitle: "임원진 전용 메뉴입니다.",
      content: DefaultContent(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _getButton(context, "assets/images/alarm.png", "알림",
                    ExecutiveNotificationPage()),
                SizedBox(width: 16),
                _getButton(context, "assets/images/fee2.png", "회비", null),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _getButton(context, "assets/images/member.png", "회원관리", null),
                SizedBox(width: 16),
                _getButton(context, "assets/images/attendance.png", "출석", null),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _getButton(context, "assets/images/product.png", "물품", null),
                Expanded(child: SizedBox()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _getButton(context, String icon, String text, page) {
    return Expanded(
      child: RoundedBorder(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        ),
        height: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 32, height: 32, child: Image.asset(icon)),
            SizedBox(height: 8),
            Text(
              text,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
