import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/providers/notice_provider.dart';
import 'package:p_cube_plus_application/widgets/default_page_widget.dart';
import 'package:p_cube_plus_application/widgets/notice_box_widget.dart';
import 'package:provider/provider.dart';

import '../../models/caution.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class NoticePage extends StatefulWidget {
  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  Future<Caution>? info;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var product = Provider.of<NoticeProvider>(context);

    return DefaultPage(
      appBarTitle: "알림",
      appBarActions: [
        PopupMenuButton(
          tooltip: "정렬기준",
          icon: const Icon(
            Icons.more_vert,
          ),
          elevation: 30,
          onSelected: (SortType value) {
            product.changeSortType(value);
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              child: Text(
                "오름차순",
              ),
              value: SortType.Ascending,
            ),
            const PopupMenuItem(
              child: Text(
                "내림차순",
              ),
              value: SortType.Descending,
            ),
          ],
        ),
      ],
      content: Column(
        children: List.generate(
          product.curList.length,
          (index) {
            return Dismissible(
              key: UniqueKey(),
              background: Container(
                margin: EdgeInsets.only(left: 0, top: 12, right: 0, bottom: 0),
                padding: EdgeInsets.symmetric(horizontal: 20),
                color: Colors.red,
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "삭제 ",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Icon(Icons.delete_outlined, size: 32, color: Colors.white),
                  ],
                ),
              ),
              child: NoticeBoxWidget(product.curList[index]),
              onDismissed: (direction) {
                product.deleteNotice(index);
              },
            );
          },
        ),
      ),
    );
  }
}
