import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/providers/view_provider/filter_provider.dart';
import 'package:p_cube_plus_application/widgets/common/default_user_search.dart';
import 'package:p_cube_plus_application/widgets/common/rounded_border.dart';

// 데이터 provider로 가져오고 아래 타입 중 하나로 부르기
// AttendanceAllSearchFilter
// AttendanceCompleteSearchFilter
// AttendanceLateSearchFilter
// AttendanceAbsentSearchFilter
//     T newFilter =
        // filterProvider.GetFilter<T>();
class ExecutiveAttendenceTab extends StatelessWidget {
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
                        style:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                      ),
                      Image.asset(
                        "assets/images/search.png",
                        color: Theme.of(context).textTheme.displaySmall!.color,
                        scale: 1.5,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 8),
              DefaultUserSearch<AttendanceAllSearchFilter>(),
            ],
          ),
          SizedBox(height: 9),
          SizedBox(height: 24),
          Text(
            "총 85명",
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
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
                                      .displayLarge!
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
                                      .displaySmall!
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
                                          .displayMedium!
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
                                          .displayMedium!
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
}
