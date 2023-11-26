import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../widgets/common/list_divider.dart';
import '../../widgets/common/rounded_border.dart';
import '../../widgets/page/default_content.dart';
import '../../widgets/page/default_page.dart';
import 'fee_detail_page.dart';
import '../../utilities/contants.dart' as Constants;

enum StateType { none, positive, late, negative, off }

_getImage(StateType type, double size) {
  return Image.asset("assets/images/${type.toString().split('.').last}.png",
      width: size, height: size);
}

class FeePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      title: "회비",
      content: DefaultContent(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(top: 12, bottom: 40),
                child: MonthFee(
                  type: StateType.negative,
                  startDay: DateTime(2022, 10, 6),
                  endDay: DateTime(2022, 10, 13),
                  charge: 5000,
                )),
            Padding(padding: EdgeInsets.only(bottom: 40), child: AnnualFee()),
            FeeInfo(sum: 1200340),
          ],
        ),
      ),
    );
  }
}

class MonthFee extends StatelessWidget {
  const MonthFee({required this.type, this.startDay, this.endDay, this.charge});
  final StateType type;
  final DateTime? startDay;
  final DateTime? endDay;
  final int? charge;

  _getText() {
    if (type == StateType.positive)
      return "회부 납부 완료!";
    else if (type == StateType.late)
      return "회비 납부 완료!\n납부 기간을 꼭 지켜주세요.";
    else if (type == StateType.negative)
      return "아직 회비를 납부하지 않았어요.";
    else if (type == StateType.off) return "회비 납부 기간이 아닙니다.";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Text("이번 달 회비 납부",
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w700)),
        ),
        RoundedBorder(
          width: double.infinity,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Padding(
            padding: EdgeInsets.only(top: 32, bottom: 24, left: 24, right: 24),
            child: Column(
              children: [
                Container(
                    height: 72,
                    width: 72,
                    margin: EdgeInsets.only(bottom: 16),
                    child: _getImage(type, 72.0)),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: type != StateType.off ? 32.0 : 8.0),
                  child: Text(_getText(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(fontSize: 12, fontWeight: FontWeight.w500)),
                ),
                if (type != StateType.off)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("납부 기간"),
                        Text(DateFormat('MM월 dd일 ~').format(startDay!) +
                            DateFormat('MM월 dd일').format(endDay!))
                      ],
                    ),
                  ),
                if (type != StateType.off)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("납부 금액"),
                      Text(NumberFormat('###,###,###원').format(charge!))
                    ],
                  ),
                if (type == StateType.negative)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListDivider(vertial: 16.0),
                      Padding(
                        padding: EdgeInsets.only(bottom: 3),
                        child: Text("회비계좌",
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(
                                    fontSize: 11, fontWeight: FontWeight.w400)),
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
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
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
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                              ),
                            ),
                            Constants.Icons.GetIcon(Constants.Icons.copy)
                          ],
                        ),
                      )
                    ],
                  )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class AnnualFee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Text("연도별 회비 납부",
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w700)),
        ),
        YearCalender(),
      ],
    );
  }
}

class YearCalender extends StatefulWidget {
  @override
  State<YearCalender> createState() => _YearCalenderState();
}

class _YearCalenderState extends State<YearCalender> {
  int _curYear = DateTime.now().year;

  _getCurYearInfo() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _getYearData(1, StateType.none),
            _getYearData(2, StateType.none),
            _getYearData(3, StateType.late),
            _getYearData(4, StateType.positive),
            _getYearData(5, StateType.positive),
            _getYearData(6, StateType.positive),
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _getYearData(7, StateType.late),
            _getYearData(8, StateType.positive),
            _getYearData(9, StateType.negative),
            _getYearData(10, StateType.none),
            _getYearData(11, StateType.none),
            _getYearData(12, StateType.none),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    late double startX, endX;
    return GestureDetector(
      onHorizontalDragStart: (details) => startX = details.globalPosition.dx,
      onHorizontalDragUpdate: (details) {
        endX = details.localPosition.dx;
      },
      onHorizontalDragEnd: (details) {
        setState(() {
          if (endX - startX > 50.0)
            --_curYear;
          else if (startX - endX > 50.0) ++_curYear;
        });
      },
      child: RoundedBorder(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Padding(
            padding: EdgeInsets.only(bottom: 32, top: 20),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 22.5),
                          child: GestureDetector(
                              onTap: () => setState(() => --_curYear),
                              child: Icon(Icons.chevron_left))),
                      Text(
                        _curYear.toString() + "년",
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Padding(
                          padding: EdgeInsets.only(right: 22.5),
                          child: GestureDetector(
                              onTap: () => setState(() => ++_curYear),
                              child: Icon(Icons.chevron_right))),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: _getCurYearInfo(),
                ),
              ],
            ),
          )),
    );
  }

  _getYearData(int month, StateType type) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 4),
          child: Text(
            month.toString() + "월",
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(fontSize: 10, fontWeight: FontWeight.w500),
          ),
        ),
        _getImage(type, 32.0)
      ],
    );
  }
}

class FeeInfo extends StatelessWidget {
  const FeeInfo({required this.sum});
  final int sum;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Text("회비 내역",
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w700)),
        ),
        RoundedBorder(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FeeDetailPage(),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 17, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(NumberFormat('###,###,###원').format(sum),
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontSize: 14, fontWeight: FontWeight.w400)),
                Row(
                  children: [
                    Text("자세히 보기",
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w500)),
                    Icon(Icons.chevron_right)
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
