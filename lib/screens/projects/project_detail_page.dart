import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:p_cube_plus_application/screens/projects/project_inquiry_page.dart';
import '../../models/member.dart';
import '../../models/project.dart';
import '../../widgets/common/default_profile.dart';
import '../../widgets/common/rounded_border.dart';
import '../../widgets/page/default_appbar.dart';
import '../../widgets/page/default_content.dart';
import '../../widgets/page/default_page.dart';
import '../../widgets/project/inquiry_tile.dart';

class ProjectDetailPage extends StatelessWidget {
  const ProjectDetailPage({
    Key? key,
    required this.project,
  }) : super(key: key);
  final Project project;

  @override
  Widget build(BuildContext context) {
    var projectName = project.name;
    var projectType = project.getType() + "프로젝트";
    var projectProperty = project.platforms.join(", ");
    if (project.graphic != null) {
      projectProperty += " / " + project.graphic!;
    }

    var projectDate = "";
    if (project.startDate != null)
      projectDate = "${DateFormat('yyyy.MM.dd').format(project.startDate!)} ~ ";
    if (project.status == 0 && project.endDate != null)
      projectDate += DateFormat('yyyy.MM.dd').format(project.endDate!);

    return DefaultPage(
      textColor: Colors.white,
      appbar: DefaultAppBar(
        contentColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: "프로젝트 정보",
      ),
      title: projectName,
      subtitle: projectType,
      backgroundColor: Theme.of(context).primaryColor,
      bottomPadding: 0.0,
      decorate: Stack(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            height: 71.0,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: RoundedBorder(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        project.name,
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      Text(
                        "팀원 모집 중", // 이 부분에 대한 json 수정 필요
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    projectProperty,
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Text(
                        project.getStatus(),
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        projectDate,
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      content: DefaultContent(
        child: Column(
          children: [
            SizedBox(height: 16.0),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: _ProjectDetailSectionView(
                    title: "팀원 정보",
                    content: List.generate(
                      project.members.length,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: _ProjectDetailMemeberView(
                            member: project.members[index],
                            pm: project.members[index].id == project.pm.id,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: _ProjectDetailSectionView(
                    title: "문의사항",
                    content: [
                      Column(
                        children: List.generate(
                          3,
                          (index) => Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: InquiryTile(
                                showChat: false,
                                content: ProjectInquiryPage(
                                    project: project, inquiryCount: index)),
                          ),
                        ),
                      )
                    ],
                    onTap: () {},
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _ProjectDetailSectionView extends StatelessWidget {
  const _ProjectDetailSectionView({
    Key? key,
    required this.title,
    required this.content,
    this.onTap,
  }) : super(key: key);
  final String title;
  final Function()? onTap;
  final List<Widget> content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            if (onTap != null)
              GestureDetector(
                onTap: onTap,
                child: Row(
                  children: [
                    Text(
                      "자세히 보기",
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Theme.of(context).textTheme.headline3!.color,
                      size: 16.0,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ]..addAll(content),
    );
  }
}

class _ProjectDetailMemeberView extends StatelessWidget {
  const _ProjectDetailMemeberView({
    Key? key,
    required this.member,
    this.pm,
  }) : super(key: key);
  final Member member;
  final bool? pm;

  @override
  Widget build(BuildContext context) {
    return RoundedBorder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const DefaultProfile(size: 24.0),
              SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member.name,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 11.0,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  Text(
                    member.getPart() + "파트",
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              if (pm ?? false)
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: _TagBorder(
                    "PM",
                    color: Theme.of(context).primaryColor,
                    contentColor: Colors.white,
                  ),
                ),
              _TagBorder("역할"), // json 수정 필요
            ],
          ),
        ],
      ),
    );
  }
}

class _TagBorder extends StatelessWidget {
  const _TagBorder(
    this.content, {
    Key? key,
    this.color,
    this.contentColor,
  }) : super(key: key);
  final String content;
  final Color? color;
  final Color? contentColor;

  @override
  Widget build(BuildContext context) {
    return RoundedBorder(
      color: color ?? Theme.of(context).dialogBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(
        content,
        style: Theme.of(context).textTheme.headline2!.copyWith(
              color: contentColor,
              fontSize: 9.0,
              fontWeight: FontWeight.w400,
            ),
      ),
    );
  }
}
