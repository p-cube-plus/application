import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../providers/user_data_provider.dart';
import '../../widgets/common/list_divider.dart';
import '../../widgets/common/rounded_border.dart';
import '../../widgets/page/default_appbar.dart';
import '../../widgets/page/default_content.dart';
import '../../widgets/page/default_page.dart';

String _autoFix(double d) {
  if (d.toInt() == d)
    return d.toInt().toString();
  else
    return d.toString();
}

class CautionListPage extends StatelessWidget {
  const CautionListPage({
    Key? key,
    required this.userProvider,
  }) : super(key: key);

  final UserDataProvider userProvider;

  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      title: "경고 현황",
      appbar: DefaultAppBar(),
      content: DefaultContent(
        child: Column(
          children: [
            CautionSummaryView(userProvider: userProvider),
            ListDivider(vertial: 24.0),
            CautionListView(
              title: "경고 및 주의 내역",
              userProvider: userProvider,
              mode: 1,
            ),
            SizedBox(height: 32.0),
            CautionListView(
              title: "경고 차감 내역",
              userProvider: userProvider,
              mode: -1,
            ),
          ],
        ),
      ),
    );
  }
}

class CautionListView extends StatelessWidget {
  const CautionListView({
    Key? key,
    required this.userProvider,
    required this.mode,
    required this.title,
  }) : super(key: key);

  final String title;
  final int mode;
  final UserDataProvider userProvider;

  @override
  Widget build(BuildContext context) {
    List<Widget> _cautions = <Widget>[];

    for (var caution in userProvider.user!.cautions) {
      if (mode != caution.amount.sign) continue;
      String type = ["경고", "주의"][caution.type];

      _cautions.add(SizedBox(height: 8.0));
      _cautions.add(
        RoundedBorder(
          padding: const EdgeInsets.all(16.0),
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${type} ${mode == 1 ? "" : "차감"}",
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  Text(
                    "${caution.description}(으)로 인해 " +
                        "$type ${_autoFix(caution.amount.abs())}회" +
                        "${mode == 1 ? "" : "차감"}",
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
              Text(
                DateFormat('yyyy.MM.dd').format(caution.date),
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ],
          ),
        ),
      );
    }

    if (_cautions.length == 0) return Container();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline2!.copyWith(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
              ),
        ),
      ]..addAll(_cautions),
    );
  }
}

class CautionSummaryView extends StatelessWidget {
  const CautionSummaryView({
    Key? key,
    required this.userProvider,
  }) : super(key: key);

  final UserDataProvider userProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "주의 및 경고",
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            Text(
              "${_autoFix(userProvider.totalCaution(2))}회",
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
            )
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "경고 차감",
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            Text(
              "${_autoFix(userProvider.totalCaution(2, sign: -1))}회",
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
            )
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "총",
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            Text(
              "${_autoFix(userProvider.totalCaution(2) - userProvider.totalCaution(2, sign: -1))}회",
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
            )
          ],
        ),
      ],
    );
  }
}
