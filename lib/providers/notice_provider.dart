import 'package:flutter/material.dart';
import '../models/notification_node.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

enum SortType {
  Ascending,
  Descending,
}

class NoticeProvider with ChangeNotifier {
  // DUMMY
  bool isFirst = true;
  late bool fail;
  late bool loaded;
  String? errorMessage;

  late List<NotificationNode>? curList;
  SortType _sortType = SortType.Ascending;

  NoticeProvider() {
    initialize();
  }

  Future initialize() async {
    fail = false;
    loaded = false;
    errorMessage = "";
    curList = await fetchNotification();
    notifyListeners();
  }

  Future<List<NotificationNode>?> fetchNotification() async {
    final url = Uri.parse('http://p-cube-plus.com/user/notification');
    final response = await http.get(url);

    if (response.statusCode == 200 && response.body.length > 0) {
      try {
        loaded = true;
        return (json.decode(response.body) as List)
            .map((data) => NotificationNode.fromJson(data))
            .toList();
      } catch (e) {
        fail = true;
        errorMessage = "데이터 변환 실패";
        return null;
      }
    } else {
      fail = true;
      errorMessage = "데이터 불러오기 실패";
      return null;
    }
  }

  // 새 알림을 얻는 함수
  void getNotice(NotificationNode notice) {
    curList!.add(notice);
    _sort();
    notifyListeners();
  }

  // 알림을 지우는 함수
  void deleteNotice(int idx) {
    curList!.removeAt(idx);
    notifyListeners();
  }

  // 정렬 방식을 바꾸는 함수
  void changeSortType(SortType type) {
    _sortType = type;
    _sort();
    notifyListeners();
  }

  void _sort() {
    switch (_sortType) {
      case SortType.Ascending:
        curList!.sort((a, b) => (a.date).compareTo(b.date));
        break;
      case SortType.Descending:
        curList!.sort((a, b) => (b.date).compareTo(a.date));
        break;
    }
  }
}
