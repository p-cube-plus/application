import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/rent.dart';
import '../common/rounded_border.dart';
import '../page/default_appbar.dart';
import '../page/default_page.dart';

class RentedDetail extends StatelessWidget {
  const RentedDetail({required this.rent});
  final Rent rent;
  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      title: "물품",
      appbar: DefaultAppBar(),
      content: Column(
        children: [
          RentedDetailTile(
              infoText: "대여 기간",
              isReturn: true,
              returnText: rent.dDay.toString(),
              infoes: [
                ItemInfo(
                    title: "대여한 날짜",
                    date: DateFormat("yyyy.MM.dd").format(rent.rentDay)),
                ItemInfo(
                    title: "반납 마감일",
                    date: DateFormat("yyyy.MM.dd").format(DateTime(
                        rent.rentDay.year,
                        rent.rentDay.month,
                        rent.rentDay.day + rent.dDay))),
              ]),
          RentedDetailTile(infoText: "도서 정보", infoes: [
            ItemInfo(title: "도서명", date: rent.product.name),
            ItemInfo(title: "출판사", date: rent.product.publisher!),
            ItemInfo(title: "저자", date: rent.product.author!),
          ]),
          RentedDetailTile(infoText: "물품 정보", infoes: [
            ItemInfo(title: "이름", date: rent.product.name),
            ItemInfo(title: "종류", date: rent.product.category),
            if (rent.product.location != null)
              ItemInfo(title: "위치", date: rent.product.location!),
            ItemInfo(title: "상태", date: rent.product.status.value),
          ]),
        ],
      ),
    );
  }
}

class ItemInfo {
  const ItemInfo({required this.title, required this.date});
  final String title;
  final String date;
}

class RentedDetailTile extends StatelessWidget {
  const RentedDetailTile(
      {required this.infoText,
      required this.infoes,
      this.isReturn = false,
      this.returnText});
  final String infoText;
  final bool isReturn;
  final String? returnText;
  final List<ItemInfo> infoes;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 32),
        Text(
          infoText,
          style: theme.textTheme.headline3!.copyWith(
            fontSize: 11,
            fontWeight: FontWeight.w400,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8),
          child: RoundedBorder(
            color: Theme.of(context).cardColor,
            width: double.infinity,
            hasShadow: true,
            child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {},
                child: Column(
                  children: [
                    isReturn
                        ? Padding(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Text("반납까지 ",
                                    style: theme.textTheme.headline1!.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    )),
                                Text(returnText! + "일",
                                    style: theme.textTheme.headline1!.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    )),
                              ],
                            ))
                        : SizedBox(height: 16),
                    for (int i = 0; i < infoes.length; ++i)
                      getItem(infoes[i].title, infoes[i].date),
                    SizedBox(height: 8)
                  ],
                )),
          ),
        )
      ],
    );
  }

  getItem(String title, String info) => Padding(
        padding: EdgeInsets.only(left: 16, bottom: 8),
        child: Row(
          children: [
            Padding(child: Text(title), padding: EdgeInsets.only(right: 16)),
            Text(info)
          ],
        ),
      );
}
