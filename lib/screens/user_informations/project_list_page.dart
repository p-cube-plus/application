import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../widgets/default_profile.dart';
import '../../models/project.dart';
import '../../providers/user_data.dart';
import '../../widgets/default_page_widget.dart';
import '../../widgets/rounded_border_widget.dart';

class ProjectListPage extends StatelessWidget {
  const ProjectListPage({
    Key? key,
    required this.userProvider,
  }) : super(key: key);

  final UserDataProvider userProvider;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Theme.of(context).backgroundColor,
      ),
    );

    return DefaultPage(
      appBarTitle: "참여 프로젝트",
      appBarHasPrevious: true,
      content: (userProvider.user!.projects.length == 0)
          ? Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                "참여한 프로젝트가 없습니다.",
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            )
          : ProjectListView(userProvider: userProvider),
    );
  }
}

class ProjectListView extends StatelessWidget {
  const ProjectListView({
    Key? key,
    required this.userProvider,
  }) : super(key: key);

  final UserDataProvider userProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        userProvider.user!.projects.length,
        (index) {
          Project project = userProvider.user!.projects[index];

          return Padding(
            padding: EdgeInsets.only(top: index == 0 ? 0.0 : 16.0),
            child: RoundedBorder(
              radius: 10.0,
              padding: const EdgeInsets.all(20.0),
              hasShadow: true,
              onTap: () {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        project.name, // debug
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      Stack(
                        alignment: Alignment.centerRight,
                        children: List.generate(
                          project.members.length,
                          (index) {
                            return Padding(
                              padding: EdgeInsets.only(right: index * 20.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x0A000000),
                                      blurRadius: 3.0,
                                      spreadRadius: 0.0,
                                      offset: Offset.fromDirection(1.0, 1.0),
                                    ),
                                  ],
                                ),
                                child: SizedBox(
                                  height: 24.0,
                                  width: 24.0,
                                  child: const DefaultProfile(),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    "${["메인", "꼬꼬마"][project.type]} 프로젝트", // debug
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(children: [
                    Text(
                      project.isEnd ? "종료" : "진행중", // debug
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      project.startDate != null
                          ? "${DateFormat("yyyy/MM/dd").format(project.startDate!)} ~ " +
                              "${project.isEnd && project.endDate != null ? DateFormat("yyyy/MM/dd").format(project.startDate!) : ""}"
                          : "", // debug
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ]),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
