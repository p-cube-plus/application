import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:p_cube_plus_application/models/due.dart';
import 'package:provider/provider.dart';
import '../../providers/fee_provider.dart';
import '../../utilities/contants.dart' as Constants;
import '../../widgets/common/default_bottomsheet.dart';
import '../../widgets/common/list_divider.dart';
import '../../widgets/common/rounded_border.dart';
import '../../widgets/page/default_appbar.dart';
import '../../widgets/page/default_content.dart';
import '../../widgets/page/default_page.dart';

class FeeDetailPage extends StatelessWidget {
  static FeeType feeType = FeeType.All;

  @override
  Widget build(BuildContext context) {
    final feeProvider = Provider.of<FeeProvider>(context);

    return DefaultPage(
      title: "회비 내역",
      textColor: Colors.white,
      backgroundColor: Theme.of(context).primaryColor,
      appbar: DefaultAppBar(
        contentColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      action: GestureDetector(
        onTap: () => showModalBottomSheet(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            context: context,
            builder: (context) => DefaultBottomsheet(
                  title: "내역 유형",
                  contents: [
                    _getBottomTile(context, FeeType.All),
                    _getBottomTile(context, FeeType.Deposit),
                    _getBottomTile(context, FeeType.Withdraw),
                  ],
                )),
        child: Row(
          children: [
            Text(
              feeProvider.type == FeeType.All
                  ? "전체"
                  : feeProvider.type == FeeType.Deposit
                      ? "입금"
                      : "출금",
              style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
            )
          ],
        ),
      ),
      content: DefaultContent(
        child: Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AccountInfo(),
              DuesDetail(
                type: feeProvider.type,
              )
            ],
          ),
        ),
      ),
    );
  }

  _getBottomTile(context, FeeType type) {
    final feeProvider = Provider.of<FeeProvider>(context);

    return InkWell(
      onTap: () => feeProvider.changeType(type),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              type == FeeType.All
                  ? "전체"
                  : type == FeeType.Deposit
                      ? "입금"
                      : "출금",
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontSize: 16.0, fontWeight: FontWeight.w400),
            ),
            Radio(
                activeColor: Theme.of(context).primaryColor,
                value: type,
                groupValue: feeProvider.type,
                onChanged: (value) => feeProvider.changeType(type))
          ],
        ),
      ),
    );
  }
}

class AccountInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RoundedBorder(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Center(
              child: Text(
                "1,200,340원",
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 24, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          ListDivider(
            horizontal: 24.0,
            vertial: 16.0,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 24, left: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Text(
                    "회비계좌",
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ),
                GestureDetector(
                  onTap: () => Clipboard.setData(
                      ClipboardData(text: "카카오뱅크 1234-5678-90")),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Text(
                          "카카오뱅크",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Text(
                          "1234-5678-90 정성희",
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Constants.Icons.GetIcon(Constants.Icons.copy)
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DuesDetail extends StatelessWidget {
  const DuesDetail({required this.type});

  final FeeType type;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var due = <Due>[
      new Due(date: new DateTime(2023, 10, 8), name: "게임잼 상품", charge: -300000),
      new Due(date: new DateTime(2023, 10, 8), name: "게임잼 상품", charge: -300000),
      new Due(date: new DateTime(2023, 9, 2), name: "9월 회비 정산", charge: 300000),
      new Due(date: new DateTime(2023, 8, 7), name: "8월 회비 정산", charge: 300000),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8),
          child: Column(
            children: [
              _getDueList(theme, due, type),
            ],
          ),
        ),
      ],
    );
  }

  _getDueList(theme, List<Due> due, FeeType type) {
    var prevDate = due[0].date;
    var dueList = <List<Due>>[];
    var dueItemList = <Due>[];

    for (int i = 0; i < due.length; ++i) {
      if (prevDate.day != due[i].date.day ||
          prevDate.month != due[i].date.month) {
        if (dueItemList.length > 0) dueList.add(dueItemList);
        dueItemList = <Due>[];
      }
      if (type == FeeType.All ||
          (type == FeeType.Deposit && due[i].charge > 0) ||
          (type == FeeType.Withdraw && due[i].charge < 0)) {
        prevDate = due[i].date;
        dueItemList.add(due[i]);
      }
    }
    if (dueItemList.length > 0) dueList.add(dueItemList);

    return Column(
      children: [
        for (int i = 0; i < dueList.length; ++i)
          Padding(
            padding: EdgeInsets.only(top: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    DateFormat('M월 d일').format(dueList[i][0].date),
                    style: theme.textTheme.headline2!
                        .copyWith(fontSize: 12.0, fontWeight: FontWeight.w400),
                  ),
                ),
                RoundedBorder(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    children: [
                      _getDueListItem(theme, dueList[i]),
                    ],
                  ),
                )),
              ],
            ),
          ),
      ],
    );
  }

  Widget _getDueListItem(ThemeData theme, List<Due> dueItemList) {
    return Column(
      children: [
        for (int i = 0; i < dueItemList.length; ++i)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Constants.Icons.GetIcon(Constants.Icons.pcube_logo),
                  ),
                  Text(dueItemList[i].name),
                ],
              ),
              Text(NumberFormat('###,###,###원').format(dueItemList[i].charge),
                  style: theme.textTheme.headline1!.copyWith(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: dueItemList[i].charge > 0
                        ? Colors.green
                        : theme.textTheme.headline1!.color,
                  )),
            ],
          ),
      ],
    );
  }
}
