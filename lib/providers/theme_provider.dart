import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode type = ThemeMode.light;
  Brightness brightness = Brightness.light;

  void changeType(ThemeMode newType) {
    type = newType;
    brightness = type == ThemeMode.system
        ? MediaQueryData.fromWindow(WidgetsBinding.instance.window)
            .platformBrightness
        : type == ThemeMode.light
            ? Brightness.light
            : Brightness.dark;
    notifyListeners();
  }
}
