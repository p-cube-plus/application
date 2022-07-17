import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:p_cube_plus_application/widgets/default_page_widget.dart';
import '../../models/project.dart';
import 'package:provider/provider.dart';

import '../../models/seminar.dart';
import '../../providers/user_data.dart';
import '../../models/user.dart';
import '../../widgets/list_divider_widget.dart';
import '../../widgets/rounded_border_widget.dart';

import '../mainpage/setting_page.dart';
import 'seminar_list_page.dart';
import '../../utilities/contants.dart' as Constants;

class UserInformationPage extends StatelessWidget {
  const UserInformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Color(0xFFFBFBFB),
      ),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserDataProvider>(
          create: (_) => UserDataProvider(),
        ),
      ],
      child: DefaultPage(
        appBarTitle: "내 정보",
        appBarActions: [
          GestureDetector(
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
              color: Color(0xFF818181),
            ),
          ),
        ],
        content: InformationList(),
      ),
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
    if (!userProvider.isLoaded) return Container();

    // 필요한 위젯들을 추가하는 과정? build에 이걸 다 넣어도 괜찮은지 모르겠음
    // 코드 마음에 안들어요
    List<Widget> widgets = <Widget>[
      const ProfileView(),
      ListDivider(),
    ];

    widgets.add(
      ContentSummaryView(
        title: "승급 진행률",
        onTap: () {},
        descript: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "${(userProvider.user!.curriculum.progress * 100).round()}%", // debug
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Color(0xCCDE2B13),
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
                  color: const Color(0xFFF9D4CF),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: (userProvider.user!.curriculum.progress * 100)
                          .toInt(),
                      child: RoundedBorder(
                        radius: 8.0,
                        height: 16.0,
                        color: Color(0xCCDE2B13),
                      ),
                    ),
                    Expanded(
                        flex:
                            ((1 - userProvider.user!.curriculum.progress) * 100)
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
          onTap: () {},
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: RoundedBorder(
                radius: 10.0,
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
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: const Color(0xFF2E2E2E),
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.w400,
                                ),
                      ),
                      Text(
                        "총 ${userProvider.totalCaution(0)}회", // debug
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Color(0xCCDE2B13),
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
          title: "참여 중인 프로젝트",
          onTap: () {},
          children: List.generate(
            userProvider.user!.projects.length,
            (index) {
              Project project = userProvider.user!.projects[index];

              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: RoundedBorder(
                  radius: 10.0,
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
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                color: const Color(0xFF2E2E2E),
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        Text(
                          "${["메인", "꼬꼬마"][project.type]} 프로젝트", // debug
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                color: const Color(0xFFABABAB),
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
                  radius: 10.0,
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
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                color: const Color(0xFF2E2E2E),
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        Text(
                          "${DateFormat("MM/dd").format(seminar.date)}", // debug
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                color: const Color(0xFFABABAB),
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

class ContentSummaryView extends StatelessWidget {
  const ContentSummaryView({
    Key? key,
    required this.title,
    this.descript,
    required this.onTap,
    this.children,
  }) : super(key: key);

  final String title;
  final Widget? descript;
  final List<Widget>? children;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    List<Widget> _barContents = <Widget>[
      Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: Colors.black,
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
            ),
      ),
      GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Text(
              "자세히 보기",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Color(0xFF818181),
                    fontSize: 11.0,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Color(0xFF818181),
              size: 20.0,
            ),
          ],
        ),
      ),
    ];
    if (descript != null) _barContents.insert(1, Expanded(child: descript!));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _barContents,
          ),
        ]..addAll(children ?? []),
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
    bool _hasProfile = user?.profile == null;

    return Row(
      children: [
        GestureDetector(
          onTap: () {},
          child: SizedBox(
            width: 72.0,
            height: 72.0,
            child: _hasProfile
                ? Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFE9E9E9),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Constants.Icons.GetIcon(Constants.Icons.profile),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(user!.profile!),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
          ),
        ),
        const SizedBox(width: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user?.name ?? "Unknown",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Color(0xFF2E2E2E),
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 2.0),
            GestureDetector(
              onTap: () {}, // 회원 목록 보기?
              child: Text(
                "정회원",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Color(0xFF818181),
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
