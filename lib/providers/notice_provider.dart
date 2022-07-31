import 'package:flutter/material.dart';
import '../sevices/notice_client.dart';

enum SortType {
  Ascending,
  Descending,
}

class NoticeProvider with ChangeNotifier {
  // DUMMY
  bool isFirst = true;

  List<NotificationNode> curList = [];
  SortType _sortType = SortType.Ascending;

  // 새 알림을 얻는 함수
  void getNotice(NotificationNode notice) {
    curList.add(notice);
    _sort();
    notifyListeners();
  }

  // 알림을 지우는 함수
  void deleteNotice(int idx) {
    curList.removeAt(idx);
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
        curList.sort((a, b) => (a.date!).compareTo(b.date!));
        break;
      case SortType.Descending:
        curList.sort((a, b) => (b.date!).compareTo(a.date!));
        break;
    }
  }
}
