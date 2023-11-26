import 'package:flutter/material.dart';
import '../../models/project.dart';
import '../../providers/user_data_provider.dart';
import '../../widgets/page/default_appbar.dart';
import '../../widgets/page/default_content.dart';
import '../../widgets/page/default_page.dart';
import '../../widgets/project/project_view.dart';

class ProjectListPage extends StatelessWidget {
  const ProjectListPage({
    Key? key,
    required this.userProvider,
  }) : super(key: key);

  final UserDataProvider userProvider;

  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      title: "참여 프로젝트",
      appbar: DefaultAppBar(),
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
          : DefaultContent(child: ProjectListView(userProvider: userProvider)),
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
            child: ProjectView(project: project),
          );
        },
      ),
    );
  }
}
