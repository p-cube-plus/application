import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/seminar.dart';
import '../../providers/user_data_provider.dart';
import '../../widgets/common/rounded_border.dart';
import '../../widgets/page/default_appbar.dart';
import '../../widgets/page/default_content.dart';
import '../../widgets/page/default_page.dart';

class SeminarListPage extends StatelessWidget {
  const SeminarListPage({
    Key? key,
    required this.userProvider,
  }) : super(key: key);

  final UserDataProvider userProvider;

  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      title: "세미나 내역",
      appbar: DefaultAppBar(),
      content: (userProvider.user!.seminars.length == 0)
          ? Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                "세미나 참여 내역이 존재하지 않습니다.",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            )
          : DefaultContent(child: SeminarListView(userProvider: userProvider)),
    );
  }
}

class SeminarListView extends StatelessWidget {
  const SeminarListView({
    Key? key,
    required this.userProvider,
  }) : super(key: key);

  final UserDataProvider userProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        userProvider.user!.seminars.length,
        (index) {
          Seminar seminar = userProvider.user!.seminars[index];

          return Padding(
            padding: EdgeInsets.only(top: index == 0 ? 0.0 : 8.0),
            child: RoundedBorder(
              height: 48.0,
              hasShadow: true,
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${["수습회원", "정회원", "졸업생"][seminar.type]} 세미나", // debug
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Text(
                      "${DateFormat("yyyy/MM/dd").format(seminar.date)}", // debug
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SeminarSummaryView extends StatelessWidget {
  const SeminarSummaryView({
    Key? key,
    required this.userProvider,
  }) : super(key: key);

  final UserDataProvider userProvider;

  @override
  Widget build(BuildContext context) {
    Map<int, int> _count = {};
    for (var seminar in userProvider.user!.seminars) {
      _count[seminar.date.year] = (_count[seminar.date.year] ?? 0) + 1;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(_count.length, (index) {
        List<int> years = _count.keys.toList();
        years.sort();

        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: [
              Text(
                "${years[index]}년 세미나 참여",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.black.withAlpha(0xDE),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w300,
                    ),
              ),
              SizedBox(width: 16.0),
              Text(
                "${_count[years[index]]}회",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.black.withAlpha(0xDE),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
