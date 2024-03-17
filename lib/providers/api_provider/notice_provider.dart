import 'package:p_cube_plus_application/models/notification_node.dart';
import 'package:p_cube_plus_application/providers/api_provider/base/provider_base.dart';
import 'package:p_cube_plus_application/services/notice_api.dart';

enum SortType {
  Ascending,
  Descending,
}

class NoticeProvider extends ApiProviderBase<List<NotificationNode>> {
  NoticeProvider() : super(client: new NoticeListApi());

  SortType _sortType = SortType.Ascending;

  void addNotice(NotificationNode notice) async {
    // TODO: DB에 알림 추가

    _sort();
    notifyListeners();
  }

  void deleteNotice(int idx) async {
    // TODO: DB에 알림 삭제

    notifyListeners();
  }

  void changeSortType(SortType type) {
    _sortType = type;
    _sort();
    notifyListeners();
  }

  void _sort() {
    switch (_sortType) {
      case SortType.Ascending:
        data.sort((a, b) => (a.date.toString()).compareTo(b.date.toString()));
        break;
      case SortType.Descending:
        data.sort((a, b) => (b.date.toString()).compareTo(a.date.toString()));
        break;
    }
  }

  void readNotification() async {}

  void deleteNotification() async {}
}
