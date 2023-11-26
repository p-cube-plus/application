import 'package:flutter/material.dart';

enum FeeType { All, Deposit, Withdraw }

class FeeProvider with ChangeNotifier {
  FeeType type = FeeType.All;

  void changeType(FeeType newType) {
    type = newType;
    notifyListeners();
  }
}
