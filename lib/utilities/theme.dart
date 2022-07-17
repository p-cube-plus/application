import 'package:flutter/material.dart';

class MyThemes {
  static final darkTheme = ThemeData(
    backgroundColor: Color(0xFF242424),
    scaffoldBackgroundColor: Color(0xFF242424),
    primaryColor: Colors.black,
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 18, color: Colors.white),
      headline2: TextStyle(fontSize: 15, color: Colors.white70),
    ),
    colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(color: Colors.white, opacity: 0.8),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF2E2E2E),
      unselectedItemColor: Colors.white,
      selectedItemColor: const Color(0xFFDE2B13),
    ),
    fontFamily: "SpoqaHanSansNeo",
  );

  static final lightTheme = ThemeData(
    backgroundColor: Color(0xFFFBFBFB),
    scaffoldBackgroundColor: Color(0xFFFBFBFB),
    primaryColor: Colors.white,
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 18, color: Colors.black),
      headline2: TextStyle(fontSize: 15, color: Colors.black87),
    ),
    colorScheme: ColorScheme.light(),
    iconTheme: IconThemeData(color: Colors.black87, opacity: 0.8),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      unselectedItemColor: Color(0xFF2E2E2E),
      selectedItemColor: const Color(0xCCDE2B13),
    ),
    fontFamily: "SpoqaHanSansNeo",
  );
}
