import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/rent.dart';
import '../../widgets/common/rounded_border.dart';
import '../../widgets/page/default_appbar.dart';
import '../../widgets/page/default_page.dart';

class RentDetailPage extends StatelessWidget {
  const RentDetailPage({
    Key? key,
    required this.rent,
  }) : super(key: key);
  final Rent rent;

  Widget _defaultText(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline1!.copyWith(
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
          ),
    );
  }

  Widget _contentView(
    BuildContext context,
    List<String> name,
    List<String> content,
  ) {
    return Row(children: [
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            name.length,
            (index) => Padding(
              padding: EdgeInsets.only(top: (index == 0 ? 0.0 : 8.0)),
              child: _defaultText(context, name[index]),
            ),
          )),
      SizedBox(width: 16.0),
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            content.length,
            (index) => Padding(
              padding: EdgeInsets.only(top: (index == 0 ? 0.0 : 8.0)),
              child: _defaultText(context, content[index]),
            ),
          ))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      appbar: DefaultAppBar(
        centerTitle: rent.product.category,
      ),
      content: Column(
        children: [
          _SummaryText(
            summary: "대여 기간",
            content: [
              Row(
                children: [
                  Text(
                    "반납까지 ",
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  Text(
                    "${rent.dDay}일",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              _contentView(context, [
                "대여한 날짜",
                "반납 마감일"
              ], [
                "${DateFormat("yyyy.MM.dd").format(rent.rentDay)}",
                "${DateFormat("yyyy.MM.dd").format(rent.deadline)}",
              ]),
            ],
          ),
          SizedBox(height: 32.0),
          _SummaryText(
            summary: "물품 정보",
            content: [
              _contentView(context, [
                "이름",
                "종류",
                "위치",
                "상태"
              ], [
                "${rent.product.name}",
                "${rent.product.category}",
                "${rent.product.location}",
                "${rent.product.status}",
              ]),
            ],
          ),
        ]..addAll(rent.product.category == "도서"
            ? [
                SizedBox(height: 32.0),
                _SummaryText(
                  summary: "도서 정보",
                  content: [
                    _contentView(context, [
                      "도서명",
                      "출판사",
                      "저자",
                    ], [
                      "${rent.product.name}",
                      "${rent.product.publisher}",
                      "${rent.product.author}",
                    ]),
                  ],
                ),
              ]
            : []),
      ),
    );
  }
}

class _SummaryText extends StatelessWidget {
  const _SummaryText({
    Key? key,
    required this.summary,
    required this.content,
  }) : super(key: key);
  final String summary;
  final List<Widget> content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            summary,
            style: Theme.of(context).textTheme.headline3!.copyWith(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
        RoundedBorder(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: content,
          ),
        ),
      ],
    );
  }
}
