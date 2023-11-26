import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/widgets/common/list_divider.dart';
import 'package:p_cube_plus_application/widgets/common/rounded_border.dart';

import '../../../widgets/common/default_bottomsheet.dart';
import '../../../widgets/common/default_profile.dart';
import '../../../widgets/page/default_appbar.dart';
import '../../../widgets/page/default_content.dart';
import '../../../widgets/page/default_page.dart';
import 'attendence_page.dart';

class AttendenceAddition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      appbar: DefaultAppBar(
        centerTitle: "출석 정보 추가하기",
      ),
      content: DefaultContent(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectAttendenceDay(),
            SizedBox(height: 32),
            Text("회원 정보"),
            SizedBox(height: 8),
            RoundedBorder(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              height: 56,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "아무도 선택되지 않았어요.",
                  ),
                  Icon(Icons.keyboard_arrow_down)
                ],
              ),
              onTap: () => showModalBottomSheet(
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20))),
                  context: context,
                  builder: (context) => _MakeBottomsheet(context)),
            ),
            SizedBox(height: 32),
            Text("출석 결과"),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Image.asset(
                      "assets/images/none.png",
                      scale: 0.6,
                    ),
                    SizedBox(height: 8),
                    Text("출석"),
                  ],
                ),
                Column(
                  children: [
                    Image.asset(
                      "assets/images/none.png",
                      scale: 0.6,
                    ),
                    SizedBox(height: 8),
                    Text("출석"),
                  ],
                ),
                Column(
                  children: [
                    Image.asset(
                      "assets/images/none.png",
                      scale: 0.6,
                    ),
                    SizedBox(height: 8),
                    Text("출석"),
                  ],
                ),
              ],
            ),
            SizedBox(height: 32),
            Text("출석 시간"),
            RoundedBorder(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Text("1차"),
                  Expanded(
                      child: Text(
                    "00시 00분 00초",
                    textAlign: TextAlign.center,
                  )),
                ],
              ),
            ),
            SizedBox(height: 8),
            RoundedBorder(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Text("2차"),
                  Expanded(
                      child: Text(
                    "00시 00분 00초",
                    textAlign: TextAlign.center,
                  )),
                ],
              ),
            ),
          ],
        ),
        bottomButtonText: "추가하기",
      ),
    );
  }

  _MakeBottomsheet(context) {
    return DefaultBottomsheet(
      title: "회원 선택",
      bottomPadding: 0,
      contents: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: RoundedBorder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Theme.of(context).dialogBackgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "회원 이름을 검색해보세요",
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                Image.asset(
                  "assets/images/search.png",
                  color: Theme.of(context).textTheme.headline3!.color,
                  scale: 1.5,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text("회원 구분 순"),
              Text("  |  "),
              Text("이름 순"),
            ],
          ),
        ),
        SizedBox(height: 12),
        SizedBox(
          height: 500,
          child: DefaultContent(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                10,
                (index) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      width: double.infinity,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          DefaultProfile(size: 28),
                          SizedBox(width: 16),
                          Text("권오민"),
                          SizedBox(width: 8),
                          Text("4학년"),
                          Spacer(),
                          Text("data"),
                        ],
                      ),
                    ),
                    ListDivider(),
                  ],
                ),
                growable: false,
              ),
            ),
            bottomButtonText: "선택 완료",
          ),
        ),
      ],
    );
  }
}
