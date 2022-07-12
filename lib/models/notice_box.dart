// SortType을 받아서 처리하는 게 로직적으로 더 좋은데
// 서버에서 가져오는 거라 함부로 못 바꾸겠음...
enum NoticeType {
  Cleaning,
  Book,
  Dues,
  Meeting,
}

class NoticeBox {
  NoticeBox(this.title, this.description, this.date);
  String title;
  String description;
  String date;
}
