import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/project.dart';
import '../../screens/projects/project_detail_page.dart';
import '../common/default_profile.dart';
import '../common/rounded_border.dart';

class ProjectView extends StatelessWidget {
  const ProjectView({
    Key? key,
    required this.project,
    this.showState,
  }) : super(key: key);

  final Project project;
  final bool? showState;

  @override
  Widget build(BuildContext context) {
    return RoundedBorder(
      padding: const EdgeInsets.all(20.0),
      color:
          project.status == 0 ? Theme.of(context).dialogBackgroundColor : null,
      hasShadow: true,
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProjectDetailPage(project: project),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                project.name, // debug
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: project.status == 0
                          ? Theme.of(context).textTheme.headline3!.color
                          : null,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              Stack(
                alignment: Alignment.centerRight,
                children: List.generate(
                  project.members.length > 5 ? 6 : project.members.length,
                  (index) {
                    return Padding(
                      padding: EdgeInsets.only(right: index * 20.0),
                      child: Container(
                        child: DefaultProfile(
                          size: 24.0,
                          isOverflow:
                              (project.members.length > 5 && index == 0),
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
            "${["메인", "꼬꼬마"][project.type]} 프로젝트",
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  color: project.status == 0
                      ? Theme.of(context).textTheme.headline3!.color
                      : null,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                ),
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    project.getStatus(),
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    project.startDate != null
                        ? "${DateFormat("yyyy.MM.dd").format(project.startDate!)} ~ " +
                            "${project.status == 0 && project.endDate != null ? DateFormat("yyyy.MM.dd").format(project.startDate!) : ""}"
                        : "", // debug
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
              if (project.status != 0)
                Text(
                  project.isFindingMember ? "팀원 모집 마감" : "팀원 모집중",
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                      ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
