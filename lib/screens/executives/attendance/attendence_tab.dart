import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:p_cube_plus_application/utilities/theme.dart';
import 'package:p_cube_plus_application/widgets/common/rounded_border.dart';
import '../../../utilities/contants.dart' as Constants;
import '../../../widgets/common/default_bottomsheet.dart';

class AttendenceAll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 검색 및 필터
          Row(
            children: [
              Expanded(
                child: RoundedBorder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
              SizedBox(width: 8),
              RoundedBorder(
                onTap: () => showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    context: context,
                    builder: (context) => _MakeBottomsheet(context)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                radius: 50,
                color: MyThemes.primary20,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Constants.Icons.GetIcon(Constants.Icons.filter),
                    SizedBox(width: 8),
                    Text(
                      "필터",
                      style: TextStyle(
                        color: MyThemes.primary80,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 9),
          SizedBox(height: 24),
          Text(
            "총 85명",
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
          ),
          SizedBox(height: 4),

          // 리스트
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 22),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 회원
                        Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "홍길동",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                                SizedBox(width: 4),
                                RoundedBorder(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  color: Color.fromRGBO(94, 220, 167, 0.20),
                                  child: Text(
                                    "정회원",
                                    style: TextStyle(
                                      color: Color(0xFF5EDCA7),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 6),
                            Row(
                              children: [
                                Text(
                                  "3학년 · 프로그래밍",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // 시간, 이미지
                        Row(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "1차",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2!
                                          .copyWith(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "19시 01분 34초",
                                      style: TextStyle(
                                        color: Color(0xFF5EDCA7),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(
                                      "2차",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2!
                                          .copyWith(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "19시 01분 34초",
                                      style: TextStyle(
                                        color: Color(0xFF5EDCA7),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(width: 12),
                            Image.asset("assets/images/none.png",
                                width: 40, height: 40),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  _MakeBottomsheet(context) {
    return DefaultBottomsheet(
      title: "필터",
      contents: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("회원 분류",
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      )),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("활동 회원만 보기",
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          )),
                  FlutterSwitch(
                    width: 32,
                    height: 16,
                    activeColor: Theme.of(context).primaryColor,
                    value: true,
                    toggleSize: 10,
                    borderRadius: 50,
                    padding: 2,
                    onToggle: (value) {},
                  ),
                ],
              ),
              SizedBox(height: 40),
              Text("정렬",
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      )),
              SizedBox(height: 16),
              SizedBox(
                height: 36,
                child: Expanded(
                  child: RoundedBorder(
                    hasShadow: false,
                    radius: 50,
                    color: Theme.of(context).textTheme.headline3!.color,
                    padding: const EdgeInsets.all(1),
                    child: RoundedBorder(
                      radius: 50,
                      hasShadow: false,
                      color: Theme.of(context).backgroundColor,
                      padding: const EdgeInsets.all(3),
                      child: Row(
                        children: [
                          Expanded(
                            child: RoundedBorder(
                              radius: 50,
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              color: MyThemes.primary20,
                              child: Text(
                                "이름 순",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: MyThemes.primary80,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: RoundedBorder(
                              radius: 0,
                              hasShadow: false,
                              color: Theme.of(context).backgroundColor,
                              child: Text(
                                "회원구분 순",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32),
              SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "필터 적용하기",
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
