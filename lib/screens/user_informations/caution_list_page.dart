import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../providers/user_data.dart';
import '../../widgets/custom_appbar_widget.dart';
import '../../widgets/list_divider_widget.dart';

class CautionListPage extends StatelessWidget {
  const CautionListPage({
    Key? key,
    required this.userProvider,
  }) : super(key: key);

  final UserDataProvider userProvider;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Theme.of(context).backgroundColor,
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
            title: "경고 현황",
            hasPrevious: true,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    //CautionSummaryView(userProvider: userProvider),
                    //ListDivider(),
                    CautionListView(
                      title: "경고 내역",
                      userProvider: userProvider,
                      mode: 1,
                    ),
                    ListDivider(padding: 20.0),
                    CautionListView(
                      title: "차감 내역",
                      userProvider: userProvider,
                      mode: -1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
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
    List<Widget> _dates = <Widget>[];
    List<Widget> _descriptions = <Widget>[];
    List<Widget> _results = <Widget>[];

    for (var caution in userProvider.user!.cautions) {
      if (mode.sign != caution.type.sign) continue;
      _dates.add(
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            children: [
              Text(
                DateFormat('yyyy/MM/dd').format(caution.date),
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.black,
                      fontSize: 10.0,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ],
          ),
        ),
      );
      _descriptions.add(
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            children: [
              Text(
                caution.description,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.black,
                      fontSize: 10.0,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ],
          ),
        ),
      );
      _results.add(
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            children: [
              Text(
                "${[
                  "주의",
                  "경고"
                ][caution.type.abs() - 1]} ${caution.type.sign == 1 ? "" : "차감"} ${caution.count}회",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.black,
                      fontSize: 10.0,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Colors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
        ),
        SizedBox(height: 6.0),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _dates,
            ),
            SizedBox(width: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _descriptions,
            ),
            SizedBox(width: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _results,
            ),
          ],
        ),
      ]..addAll(
          _dates.length == 0
              ? [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "${title}이 존재하지 않습니다.",
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: Color(0xFF818181),
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                              ),
                    ),
                  ),
                ]
              : [],
        ),
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                "합계",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.black,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                "주의",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.black,
                      fontSize: 10.0,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            Text(
              "경고",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.black,
                    fontSize: 10.0,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ],
        ),
        SizedBox(width: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                "${userProvider.totalCaution(0)}회",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                "${userProvider.totalCaution(1).toInt()}회",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.black,
                      fontSize: 10.0,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            Text(
              "${userProvider.totalCaution(2).toInt()}회",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.black,
                    fontSize: 10.0,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
