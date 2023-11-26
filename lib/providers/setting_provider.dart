import 'package:flutter/material.dart';

enum SettingType {
  AllNotice,
  AllMeetingNotice,
  PartMeetingNotice,
  DuesNotice,
  CleanNotice,
  BookNotice,
}

abstract class ISetting {
  void toggle(bool isOn);
  bool get isOn;
  dynamic get item;
}

class NoticeAllSetting implements ISetting {
  bool flag = true;

  @override
  bool get isOn => flag;

  @override
  void toggle(bool isOn) => flag = isOn;

  @override
  get item => flag;
}

class NoticeSetting implements ISetting {
  bool flag = true;

  @override
  bool get isOn => flag;

  @override
  void toggle(bool isOn) => flag = isOn;

  @override
  get item => flag;
}

class SettingProvider with ChangeNotifier {
  late ISetting curState;
  final allNotice = NoticeAllSetting();
  final notices = List<NoticeSetting>.generate(5, (index) => NoticeSetting());

  void changeState(SettingType type) {
    if (type == SettingType.AllNotice)
      curState = allNotice;
    else
      curState = notices[type.index - 1];
  }

  void toggle(bool isOn) {
    curState.toggle(isOn);
    notifyListeners();
  }

  bool get isOn => curState.isOn;
  dynamic get item => curState.item;
}
