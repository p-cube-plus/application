import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/utilities/theme.dart';
import 'package:p_cube_plus_application/screens/executives/notification/set_notification_page.dart';

import '../../../widgets/common/rounded_border.dart';
import '../../../widgets/page/default_appbar.dart';
import '../../../widgets/page/default_page.dart';
import '../../../widgets/page/default_tabbar.dart';

class PartMettingPage extends StatefulWidget {
  @override
  State<PartMettingPage> createState() => _PartMettingPageState();
}

class _PartMettingPageState extends State<PartMettingPage> {
  final String editText = "편집하기";
  final String saveText = "저장하기";
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      appbar: DefaultAppBar(
        centerTitle: "파트회의 알림",
        rightWidget: Container(
          height: 20,
          child: ElevatedButton(
              onPressed: () => setState(() => _isEditing = !_isEditing),
              child: Text(_isEditing ? saveText : editText,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontSize: 12.0, fontWeight: FontWeight.w500)),
              style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).dialogBackgroundColor),
                  )),
        ),
      ),
      bottomButton: _isEditing
          ? ElevatedButton(
              onPressed: () => {},
              child: Text(
                "삭제하기",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontSize: 16.0, fontWeight: FontWeight.w700),
              ),
            )
          : null,
      floatingActionButton: _isEditing ? null : _getFloatingButton(context),
      content: DefaultTabBar(
        canMove: !_isEditing,
        isCenter: true,
        tabs: [
          _getTabWidget("디자인"),
          _getTabWidget("아트"),
          _getTabWidget("프로그래밍"),
        ],
      ),
    );
  }

  DefaultTab _getTabWidget(String title) {
    return DefaultTab(
        title: title,
        page: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                      15,
                      (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: _PartMettingBox(
                                "${title} 파트 회의 알림", _isEditing),
                          ))),
              SizedBox(height: 80)
            ],
          ),
        ));
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
  const _PartMettingBox(this.title, this.isEditing);
  final String title;
  final bool isEditing;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: RoundedBorder(
        height: 56,
        color: Colors.transparent,
        hasShadow: false,
        child: Row(
          children: [
            if (isEditing)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: RoundedBorder(
                  height: 20,
                  width: 20,
                  color: Colors.red,
                ),
              ),
            Expanded(
              child: RoundedBorder(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                onTap: isEditing
                    ? null
                    : () =>
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
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
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "11:00",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
