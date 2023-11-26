import 'package:flutter/material.dart';
import '../../models/project.dart';
import '../../utilities/contants.dart' as Constants;
import '../../widgets/common/default_profile.dart';
import '../../widgets/common/default_textField.dart';
import '../../widgets/common/rounded_border.dart';
import '../../widgets/page/default_appbar.dart';
import '../../widgets/page/default_content.dart';
import '../../widgets/page/default_page.dart';

class ProjectChatPage extends StatelessWidget {
  const ProjectChatPage({
    Key? key,
    required this.project,
  }) : super(key: key);
  final Project project;
  final bool hasContent = true;

  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      appbar: DefaultAppBar(
        leftTitle: project.name,
        backgroundColor: Theme.of(context).primaryColor,
        contentColor: Colors.white,
        leftTitleState: RoundedBorder(
          padding: EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 2.0,
          ),
          color: const Color(0xFF5EDCA7),
          child: Text(
            "문의 가능", // 데이터 넣어야
            style: TextStyle(
              color: const Color(0xFF575757),
              fontSize: 10.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      bottomPadding: 0.0,
      content: hasContent
          ? DefaultContent(
              //isReverse: true,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _ChatBubble(
                      text:
                          "Lorem ipsum dolor sit amet consectetur. Commodo iaculis tortor mollis turpis auctor augue. Non dui condimentum morbi molestie ultrices sem sed.",
                      mine: false),
                  _ChatBubble(
                      text:
                          "Lorem ipsum dolor sit amet consectetur. Commodo iaculis tortor mollis turpis auctor augue. ",
                      mine: true),
                  _ChatBubble(
                      text:
                          "Lorem ipsum dolor sit amet consectetur. Commodo iaculis tortor mollis turpis auctor augue. ",
                      mine: false),
                  _ChatBubble(
                      text:
                          "Lorem ipsum dolor sit amet consectetur. Commodo iaculis tortor mollis turpis auctor augue. ",
                      mine: false),
                  _ChatBubble(
                      text:
                          "Lorem ipsum dolor sit amet consectetur. Commodo iaculis tortor mollis turpis auctor augue. ",
                      mine: false),
                  _ChatBubble(
                      text:
                          "Lorem ipsum dolor sit amet consectetur. Commodo iaculis tortor mollis turpis auctor augue. ",
                      mine: false),
                  _ChatBubble(
                      text:
                          "Lorem ipsum dolor sit amet consectetur. Commodo iaculis tortor mollis turpis auctor augue. ",
                      mine: false),
                  _ChatBubble(
                      text:
                          "Lorem ipsum dolor sit amet consectetur. Commodo iaculis tortor mollis turpis auctor augue. ",
                      mine: false),
                ],
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "아직 문의사항이 없네요.",
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                SizedBox(height: 8.0),
                Text(
                  "문의사항을 작성해보세요!\n답변이 등록될 경우 알림을 보내드립니다.",
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
      bottomContent: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: _ProjectChatTextBar(),
      ),
    );
  }
}

class _ProjectChatTextBar extends StatefulWidget {
  const _ProjectChatTextBar({
    Key? key,
  }) : super(key: key);

  @override
  State<_ProjectChatTextBar> createState() => _ProjectChatTextBarState();
}

class _ProjectChatTextBarState extends State<_ProjectChatTextBar> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            blurRadius: 10.0,
            spreadRadius: 0.0,
            offset: Offset.fromDirection(0, 2.0),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.link_rounded,
              size: 24.0,
              color: Theme.of(context).textTheme.headline1!.color,
            ),
          ),
          Expanded(
            child: DefaultTextField(
              maxLength: 500,
              minLine: 1,
              maxLine: 3,
              fontSize: 12.0,
              hintText: "메세지를 입력하세요",
              inputController: _controller,
            ),
          ),
          GestureDetector(
            onTap: () {
              if (_controller.text == "") return;
              // send chat
              _controller.text = "";
            },
            child: Constants.Icons.GetIcon(
              Constants.Icons.send,
              color: _controller.text != ""
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).textTheme.headline3!.color,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({
    Key? key,
    required this.text,
    required this.mine,
  }) : super(key: key);
  final bool mine;
  final String text;

  @override
  Widget build(BuildContext context) {
    var content = <Widget>[
      _bubble(context, text, mine),
      SizedBox(width: 8.0),
      Text(
        "22.5.7.(화)",
        style: Theme.of(context).textTheme.headline3!.copyWith(
              fontSize: 11.0,
              fontWeight: FontWeight.w400,
            ),
      ),
    ];
    if (mine) content = content.reversed.toList();

    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (mine) SizedBox(width: 24.0) else DefaultProfile(size: 24.0),
          SizedBox(width: 12.0),
          Flexible(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: content,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bubble(BuildContext context, String content, bool mine) {
    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
            mine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (!mine)
            Text(
              "김아무개",
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          SizedBox(height: 9.0),
          RoundedBorder(
            color: mine ? Theme.of(context).primaryColor : null,
            padding: EdgeInsets.all(16.0),
            child: Text(
              content,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w400,
                    color: mine ? Colors.white : null,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
