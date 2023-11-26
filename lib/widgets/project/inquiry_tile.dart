import 'package:flutter/material.dart';
import '../../utilities/contants.dart' as Constants;
import '../common/default_profile.dart';
import '../common/rounded_border.dart';

class InquiryTile extends StatelessWidget {
  const InquiryTile({
    required this.showChat,
    this.chatCount,
    this.content,
  });

  final bool showChat;
  final int? chatCount;
  final Widget? content;

  @override
  Widget build(BuildContext context) {
    return RoundedBorder(
        onTap: () => content != null
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => content!,
                ),
              )
            : null,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(left: 16.0, top: 16.0, right: 12.0),
                      child: const DefaultProfile(
                        size: 32.0,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("김아무개",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    )),
                            SizedBox(height: 8),
                            Text(
                                "Lorem ipsum dolor sit amet consectetur. Commodo iaculis tortor mollis turpis auctor augue. Non dui condimentum morbi molestie ultrices sem sed.",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                    ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 21),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Text("1월 1일",
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  )),
                    ),
                    if (showChat)
                      Stack(children: [
                        Padding(
                            padding: EdgeInsets.only(top: 11, right: 20),
                            child: Container(
                                height: 24,
                                width: 24,
                                child: Constants.Icons.GetIcon(
                                    Constants.Icons.general))),
                        if (chatCount != 0)
                          Positioned(
                            left: 16,
                            bottom: 16,
                            child: RoundedBorder(
                              radius: 50.0,
                              color: Theme.of(context).primaryColor,
                              height: 16,
                              width: 16,
                              child: Center(
                                child: Text(chatCount.toString(),
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white)),
                              ),
                            ),
                          )
                      ])
                  ],
                ),
              )
            ]));
  }
}
