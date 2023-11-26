import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:p_cube_plus_application/screens/user_informations/caution_list_page.dart';
import 'package:p_cube_plus_application/screens/user_informations/promotion_progress_page.dart';
import 'package:provider/provider.dart';

import '../../widgets/common/default_profile.dart';
import '../../widgets/common/list_divider.dart';
import '../../widgets/common/rounded_border.dart';
import '../../widgets/home/content_summary_view.dart';
import '../../widgets/page/default_content.dart';
import '../../widgets/page/default_page.dart';
import '../user_informations/project_list_page.dart';
import '../../models/project.dart';

import '../../models/seminar.dart';
import '../../providers/user_data_provider.dart';
import '../../models/user.dart';

import '../settings/setting_page.dart';
import 'seminar_list_page.dart';

class UserInformationPage extends StatelessWidget {
  const UserInformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      title: "내 정보",
      action: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SettingPage(),
            ),
          );
        },
        child: Icon(
          Icons.settings,
          color: Theme.of(context).textTheme.headline2!.color,
        ),
      ),
      content: DefaultContent(child: InformationList()),
    );
  }
}

class InformationList extends StatelessWidget {
  const InformationList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userProvider = context.watch<UserDataProvider>();

    if (!userProvider.loaded)
      return Center(child: CircularProgressIndicator()); // 로딩 중
    if (!userProvider.fail) return Container(); // 정보 불러오기 실패

    List<Widget> widgets = <Widget>[
      const ProfileView(),
      ListDivider(vertial: 20.0),
    ];

    widgets.add(
      ContentSummaryView(
        title: "승급 진행률",
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  PromotionProgressPage(userProvider: userProvider)),
        ),
        descript: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "${(userProvider.user!.promotionProgress.progress * 100).round()}%", // debug
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Stack(
              children: [
                RoundedBorder(
                  radius: 8.0,
                  height: 16.0,
                  color: const Color(0x1ADE2B13),
                ),
                Row(
                  children: [
                    Expanded(
                      flex:
                          (userProvider.user!.promotionProgress.progress * 100)
                              .toInt(),
                      child: RoundedBorder(
                        radius: 8.0,
                        height: 16.0,
                        color: const Color(0xCCDE2B13),
                      ),
                    ),
                    Expanded(
                        flex: ((1 -
                                    userProvider
                                        .user!.promotionProgress.progress) *
                                100)
                            .toInt(),
                        child: Container()),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

    widgets
      ..add(const SizedBox(height: 40.0))
      ..add(
        ContentSummaryView(
          title: "경고 현황",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CautionListPage(
                  userProvider: userProvider,
                ),
              ),
            );
          },
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: RoundedBorder(
                height: 48.0,
                hasShadow: true,
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "누적 경고 횟수", // debug
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontSize: 11.0,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      Text(
                        "총 ${userProvider.totalCaution(0)}회", // debug
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );

    widgets
      ..add(const SizedBox(height: 40.0))
      ..add(
        ContentSummaryView(
          title: "참여 프로젝트",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProjectListPage(
                  userProvider: userProvider,
                ),
              ),
            );
          },
          children: List.generate(
            userProvider.user!.projects.length,
            (index) {
              Project project = userProvider.user!.projects[index];

              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: RoundedBorder(
                  height: 48.0,
                  hasShadow: true,
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          project.name, // debug
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        Text(
                          "${["메인", "꼬꼬마"][project.type]} 프로젝트", // debug
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );

    widgets
      ..add(const SizedBox(height: 40.0))
      ..add(
        ContentSummaryView(
          title: "최근 세미나",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SeminarListPage(
                  userProvider: userProvider,
                ),
              ),
            );
          },
          children: List.generate(
            userProvider.user!.seminars.length,
            (index) {
              Seminar seminar = userProvider.user!.seminars[index];

              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: RoundedBorder(
                  height: 48.0,
                  hasShadow: true,
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${[
                            "수습회원",
                            "정회원",
                            "졸업생"
                          ][seminar.type]} 세미나", // debug
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        Text(
                          "${DateFormat("MM.dd").format(seminar.date)}", // debug
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: widgets,
      ),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = context.watch<UserDataProvider>().user;
    bool _hasProfile = false;
    Widget profile = Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          onError: (exception, stackTrace) => _hasProfile = false,
          image: Image.network(user!.profileImage ?? "").image,
          fit: BoxFit.fill,
        ),
      ),
    );

    return Row(
      children: [
        GestureDetector(
          onTap: () {},
          child: _hasProfile ? profile : const DefaultProfile(size: 72),
        ),
        const SizedBox(width: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 2.0),
            GestureDetector(
              onTap: () {}, // 회원 목록 보기?
              child: Text(
                user.level,
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            )
          ],
        )
      ],
    );
  }
}
