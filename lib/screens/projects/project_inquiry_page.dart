import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/screens/projects/project_chat_page.dart';
import '../../models/project.dart';
import '../../widgets/common/default_bottomsheet.dart';
import '../../widgets/common/rounded_border.dart';
import '../../widgets/page/default_appbar.dart';
import '../../widgets/page/default_content.dart';
import '../../widgets/page/default_page.dart';
import '../../widgets/project/inquiry_tile.dart';
import '../../utilities/contants.dart' as Constants;

class ProjectInquiryPage extends StatelessWidget {
  const ProjectInquiryPage({
    required this.project,
    required this.inquiryCount,
    this.isPM = false,
    Key? key,
  }) : super(key: key);

  final Project project;
  final int inquiryCount;
  final bool isPM;

  @override
  Widget build(BuildContext context) {
    return DefaultPage(
        title: project.name,
        subtitle: project.getType() + "프로젝트",
        appbar: DefaultAppBar(
          centerTitle: "프로젝트에 문의하기",
        ),
        floatingActionButton:
            !isPM ? _FloatingInquiryButton(project: project) : null,
        action: isPM
            ? GestureDetector(
                child: RoundedBorder(
                  radius: 20.0,
                  height: 31.0,
                  color: Theme.of(context).primaryColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Text(
                    "상태 지정하기",
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                onTap: () => showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    builder: (context) => DefaultBottomsheet(
                          title: "상태 지정하기",
                          contents: [
                            _StatusTile("문의 가능"),
                            _StatusTile("문의 불가"),
                          ],
                        )))
            : null,
        content: inquiryCount != 0
            ? DefaultContent(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    inquiryCount,
                    (index) => Padding(
                      padding: EdgeInsets.only(
                        top: (index == 0 ? 4.0 : 8.0),
                      ),
                      child: InquiryTile(showChat: true, chatCount: index),
                    ),
                    growable: false,
                  ),
                ),
              )
            : Padding(
                padding: EdgeInsets.only(bottom: 110),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text("아직 문의사항이 없네요.",
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w700)),
                      ),
                      Text("문의사항을 작성해보세요!",
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w400)),
                      Text("답변이 등록될 경우 알림을 보내드립니다.",
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              ));
  }
}

class _StatusTile extends StatefulWidget {
  const _StatusTile(this.optionText);
  final String optionText;

  @override
  State<_StatusTile> createState() => _StatusTileState();
}

class _StatusTileState extends State<_StatusTile> {
  bool dummy = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.optionText,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            Radio(
              activeColor: Theme.of(context).primaryColor,
              groupValue: dummy,
              value: dummy,
              onChanged: (value) => setState(() => dummy = true),
            ),
          ],
        ),
      ),
    );
  }
}

class _FloatingInquiryButton extends StatelessWidget {
  const _FloatingInquiryButton({required this.project});
  final Project project;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      height: 64,
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return ProjectChatPage(project: project);
          }));
        },
        elevation: 7.68,
        focusElevation: 7.68,
        hoverElevation: 7.68,
        disabledElevation: 7.68,
        highlightElevation: 7.68,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Constants.Icons.GetIcon(Constants.Icons.pencil),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
