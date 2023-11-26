import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/utilities/theme.dart';
import 'package:p_cube_plus_application/screens/executives/notification/set_notification_page.dart';

import '../../../widgets/common/rounded_border.dart';
import '../../../widgets/page/default_appbar.dart';
import '../../../widgets/page/default_page.dart';
import '../../../widgets/page/default_tabbar.dart';

class PartMettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      appbar: DefaultAppBar(
        centerTitle: "파트회의 알림",
      ),
      floatingActionButton: _getFloatingButton(context),
      content: DefaultTabBar(
        isCenter: true,
        tabs: [
          DefaultTab(
              title: "디자인",
              page: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                      2,
                      (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: _PartMettingBox("디자인 파트 회의 알림"),
                          )))),
          DefaultTab(
              title: "아트",
              page: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                      2,
                      (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: _PartMettingBox("아트 파트 회의 알림"),
                          )))),
          DefaultTab(
              title: "프로그래밍",
              page: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                      2,
                      (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: _PartMettingBox("프로그래밍 파트 회의 알림"),
                          )))),
        ],
      ),
    );
  }

  Widget _getFloatingButton(context) {
    return SizedBox(
      width: 64,
      height: 64,
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return SetNotificationPage("디자인 파트 회의 알림");
          }));
        },
        elevation: 7.68,
        focusElevation: 7.68,
        hoverElevation: 7.68,
        disabledElevation: 7.68,
        highlightElevation: 7.68,
        child: Center(
          child: Text(
            "+",
            style: TextStyle(
              fontSize: 56,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}

class _PartMettingBox extends StatelessWidget {
  const _PartMettingBox(this.title);
  final String title;
  @override
  Widget build(BuildContext context) {
    return RoundedBorder(
      height: 56,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) {
        return SetNotificationPage(title);
      })),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("수요일",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: MyThemes.primary80,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  )),
              SizedBox(width: 24),
              Text(
                "오전",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              SizedBox(width: 8),
              Text(
                "11:00",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 20,
            color: Color(0xFFABABAB),
          ),
        ],
      ),
    );
  }
}
