import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/screens/logout_page.dart';
import 'package:p_cube_plus_application/widgets/common/default_profile.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';
import '../../widgets/common/default_alert.dart';
import '../../widgets/common/default_bottomsheet.dart';
import '../../widgets/common/default_textField.dart';
import '../../widgets/common/list_divider.dart';
import '../../widgets/common/rounded_border.dart';
import '../../widgets/page/default_appbar.dart';
import '../../widgets/page/default_page.dart';
import '../../widgets/setting/setting_tile.dart';
import 'setting_notice_page.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.read<ThemeProvider>();
    final theme = Theme.of(context);
    TextEditingController nameController = TextEditingController();
    TextEditingController contentController = TextEditingController();

    return DefaultPage(
      title: "설정",
      appbar: DefaultAppBar(),
      content: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Column(
            children: [
              SettingTile(
                  title: "알림 설정",
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingNoticePage(),
                        ),
                      )),
              SettingTile(
                  title: "테마 설정",
                  optionText: Text(
                    _getMode(themeProvider.type),
                    style: theme.textTheme.headline3!
                        .copyWith(fontSize: 12.0, fontWeight: FontWeight.w400),
                  ),
                  onTap: () => showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20))),
                      builder: (context) => DefaultBottomsheet(
                            title: "테마 설정",
                            bottomPadding: 48,
                            contents: [
                              SettingRadioBox(
                                  type: ThemeMode.system, text: "시스템 설정 사용"),
                              SettingRadioBox(
                                  type: ThemeMode.light, text: "라이트 모드"),
                              SettingRadioBox(
                                  type: ThemeMode.dark, text: "다크 모드"),
                            ],
                          ))),
              ListDivider(horizontal: 20, vertial: 10.0),
              SettingTile(
                title: "버전",
                hasIcon: false,
                optionText: FutureBuilder<PackageInfo>(
                    future: PackageInfo.fromPlatform(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasError) {
                        return const Text('버전 확인 실패');
                      } else if (!snapshot.hasData) {
                        return const Text('버전 확인중');
                      }
                      return Text(
                        "v" + snapshot.data!.version,
                        style: theme.textTheme.headline2!.copyWith(
                            fontSize: 14.0, fontWeight: FontWeight.w400),
                      );
                    }),
              ),
              SettingTile(
                  title: "PCube+에 피드백 보내기",
                  onTap: () => showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => DefaultAlert(
                            title: "피드백 보내기",
                            messageType: MessageType.OKCancel,
                            children: [
                              SizedBox(height: 16.0),
                              RoundedBorder(
                                radius: 4.0,
                                height: 30.0,
                                width: MediaQuery.of(context).size.width - 80,
                                child: DefaultTextField(
                                  maxLength: 20,
                                  hintText: "이름을 입력하세요",
                                  inputController: nameController,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              RoundedBorder(
                                radius: 4.0,
                                height: 150.0,
                                width: MediaQuery.of(context).size.width - 80,
                                child: DefaultTextField(
                                  minLine: 11,
                                  maxLength: 500,
                                  hintText: "내용을 입력하세요",
                                  inputController: contentController,
                                ),
                              ),
                              SizedBox(height: 16.0),
                            ],
                            // data 저장 provider 부르면 해결. 현재는 오류있음
                            onTap: nameController.text != "" &&
                                    contentController.text != ""
                                ? () {
                                    nameController.text = "";
                                    contentController.text = "";
                                    Navigator.pop(context);
                                    showDialog(
                                      context: context,
                                      builder: (context) => DefaultAlert(
                                        title: "피드백이 제출되었습니다!",
                                        description: "소중한 의견 감사합니다.",
                                        messageType: MessageType.OK,
                                      ),
                                    );
                                  }
                                : () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => DefaultAlert(
                                        title: "입력 오류",
                                        description: "이름과 내용을 모두 입력해주세요.",
                                        messageType: MessageType.OK,
                                      ),
                                    );
                                  }),
                      )),
              SettingTile(
                title: "개발진 목록",
                onTap: () => showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    builder: (context) => DefaultBottomsheet(
                          title: "개발진 목록",
                          bottomPadding: 8,
                          contents: [
                            Container(
                              height: 630,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: ListView.builder(
                                  itemCount: 7,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  DefaultProfile(size: 32),
                                                  SizedBox(width: 16),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "오창한",
                                                        style: theme.textTheme
                                                            .headline5!
                                                            .copyWith(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      SizedBox(height: 3),
                                                      Text(
                                                        "컴퓨터공학과 18학번",
                                                        style: theme.textTheme
                                                            .headline5!
                                                            .copyWith(
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "프로그래밍",
                                                    style: theme
                                                        .textTheme.headline5!
                                                        .copyWith(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text("졸업회원",
                                                      style: theme
                                                          .textTheme.headline3!
                                                          .copyWith(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      )),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        if (index < 6)
                                          ListDivider()
                                        else
                                          SizedBox(height: 8)
                                      ],
                                    );
                                  }),
                            )
                          ],
                        )),
              ),
              ListDivider(horizontal: 20),
              SettingTile(
                  title: "로그아웃",
                  onTap: () => showDialog(
                      context: context,
                      builder: (context) => DefaultAlert(
                            title: "로그아웃",
                            messageType: MessageType.OKCancel,
                            description: "정말 로그아웃 하시겠습니까?",
                            onTap: () => Navigator.pushAndRemoveUntil(context,
                                PageRouteBuilder(
                              pageBuilder: (BuildContext context,
                                  Animation animation,
                                  Animation secondaryAnimation) {
                                return LogoutPage();
                              },
                            ), (Route route) => false),
                          )))
            ],
          ),
        ),
      ),
    );
  }

  String _getMode(ThemeMode type) {
    return type == ThemeMode.system
        ? "시스템 설정 사용"
        : type == ThemeMode.light
            ? "라이트 모드"
            : "다크 모드";
  }
}

class SettingRadioBox extends StatelessWidget {
  final ThemeMode type;
  final String text;
  SettingRadioBox({required this.type, required this.text});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return InkWell(
      onTap: () => themeProvider.changeType(type),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontWeight: FontWeight.w400, fontSize: 16.0)),
            SizedBox(
              width: 20,
              height: 20,
              child: Radio(
                  activeColor: Theme.of(context).primaryColor,
                  value: type,
                  groupValue: themeProvider.type,
                  onChanged: (value) => themeProvider.changeType(type)),
            )
          ],
        ),
      ),
    );
  }
}
